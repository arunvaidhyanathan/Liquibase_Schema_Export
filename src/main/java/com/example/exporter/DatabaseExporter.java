package com.example.exporter;

import java.io.*;
import java.nio.file.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * PostgreSQL Database Exporter using JDBC
 * Exports database objects to SQL files for Liquibase conversion
 */
public class DatabaseExporter {
    
    private static final String DB_URL = "jdbc:postgresql://ep-wispy-haze-a5xy9c41-pooler.us-east-2.aws.neon.tech/workflow?user=wf_owner&password=npg_7hrdeDKf6WyC&sslmode=require&currentSchema=cads";
    private static final String DB_USER = "wf_owner";
    private static final String DB_PASSWORD = "npg_7hrdeDKf6WyC";
    private static final String DB_SCHEMA = "cads";
    private static final String OUTPUT_DIR = "exports";
    
    private Connection connection;
    private String timestamp;
    private Path outputPath;
    
    public DatabaseExporter() {
        this.timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
        this.outputPath = Paths.get(OUTPUT_DIR);
        
        try {
            Files.createDirectories(outputPath);
        } catch (IOException e) {
            throw new RuntimeException("Failed to create output directory", e);
        }
    }
    
    public static void main(String[] args) {
        DatabaseExporter exporter = new DatabaseExporter();
        try {
            exporter.export();
            System.out.println("✅ Database export completed successfully!");
        } catch (Exception e) {
            System.err.println("❌ Export failed: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
    
    public void export() throws SQLException, IOException {
        System.out.println("🚀 PostgreSQL Database Export using JDBC");
        System.out.println("=========================================");
        System.out.println("Database: " + DB_URL);
        System.out.println("Schema: " + DB_SCHEMA);
        System.out.println("Timestamp: " + timestamp);
        System.out.println();
        
        connect();
        
        try {
            exportSchemaStructure();
            exportTableData();
            exportViews();
            exportSequences();
            exportIndexes();
            exportFunctions();
            exportTriggers();
            exportCustomTypes();
            createCombinedFile();
            
        } finally {
            disconnect();
        }
    }
    
    private void connect() throws SQLException {
        System.out.println("🔌 Connecting to database...");
        connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        connection.setSchema(DB_SCHEMA);
    }
    
    private void disconnect() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
            System.out.println("🔌 Database connection closed");
        }
    }
    
    private void exportSchemaStructure() throws SQLException, IOException {
        System.out.println("1. 🏗️  Exporting schema structure...");
        
        String filename = String.format("01_schema_structure_%s.sql", timestamp);
        Path filePath = outputPath.resolve(filename);
        
        try (PrintWriter writer = new PrintWriter(Files.newBufferedWriter(filePath))) {
            writer.println("-- Schema Structure Export");
            writer.println("-- Generated on: " + LocalDateTime.now());
            writer.println();
            
            // Export tables
            exportTables(writer);
            
            // Export constraints
            exportConstraints(writer);
        }
    }
    
    private void exportTables(PrintWriter writer) throws SQLException {
        String sql = """
            SELECT 
                table_name,
                CASE 
                    WHEN table_type = 'BASE TABLE' THEN 'TABLE'
                    ELSE table_type
                END as table_type
            FROM information_schema.tables 
            WHERE table_schema = ? 
            AND table_type = 'BASE TABLE'
            ORDER BY table_name
            """;
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, DB_SCHEMA);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                String tableName = rs.getString("table_name");
                writer.println(generateCreateTableSQL(tableName));
                writer.println();
            }
        }
    }
    
    private String generateCreateTableSQL(String tableName) throws SQLException {
        StringBuilder sql = new StringBuilder();
        sql.append("CREATE TABLE \"").append(tableName).append("\" (");
        
        // Get columns
        String columnSql = """
            SELECT 
                column_name,
                data_type,
                character_maximum_length,
                numeric_precision,
                numeric_scale,
                is_nullable,
                column_default,
                ordinal_position
            FROM information_schema.columns 
            WHERE table_schema = ? AND table_name = ?
            ORDER BY ordinal_position
            """;
        
        List<String> columns = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(columnSql)) {
            stmt.setString(1, DB_SCHEMA);
            stmt.setString(2, tableName);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                StringBuilder column = new StringBuilder();
                column.append("\"").append(rs.getString("column_name")).append("\" ");
                
                String dataType = rs.getString("data_type").toUpperCase();
                int maxLength = rs.getInt("character_maximum_length");
                int precision = rs.getInt("numeric_precision");
                int scale = rs.getInt("numeric_scale");
                
                // Format data type
                switch (dataType) {
                    case "CHARACTER VARYING":
                        column.append("VARCHAR");
                        if (maxLength > 0) column.append("(").append(maxLength).append(")");
                        break;
                    case "CHARACTER":
                        column.append("CHAR");
                        if (maxLength > 0) column.append("(").append(maxLength).append(")");
                        break;
                    case "NUMERIC":
                        column.append("NUMERIC");
                        if (precision > 0) {
                            column.append("(").append(precision);
                            if (scale > 0) column.append(",").append(scale);
                            column.append(")");
                        }
                        break;
                    case "TIMESTAMP WITHOUT TIME ZONE":
                        column.append("TIMESTAMP WITHOUT TIME ZONE");
                        break;
                    case "TIMESTAMP WITH TIME ZONE":
                        column.append("TIMESTAMP WITH TIME ZONE");
                        break;
                    default:
                        column.append(dataType);
                }
                
                // Nullable
                if ("NO".equals(rs.getString("is_nullable"))) {
                    column.append(" NOT NULL");
                }
                
                // Default value
                String defaultValue = rs.getString("column_default");
                if (defaultValue != null && !defaultValue.trim().isEmpty()) {
                    column.append(" DEFAULT ").append(defaultValue);
                }
                
                columns.add(column.toString());
            }
        }
        
        sql.append(String.join(", ", columns));
        sql.append(");");
        
        return sql.toString();
    }
    
    private void exportConstraints(PrintWriter writer) throws SQLException {
        writer.println("-- Constraints");
        
        String sql = """
            SELECT 
                tc.constraint_name,
                tc.table_name,
                tc.constraint_type,
                kcu.column_name,
                ccu.table_name AS foreign_table_name,
                ccu.column_name AS foreign_column_name
            FROM information_schema.table_constraints tc
            LEFT JOIN information_schema.key_column_usage kcu 
                ON tc.constraint_name = kcu.constraint_name
                AND tc.table_schema = kcu.table_schema
            LEFT JOIN information_schema.constraint_column_usage ccu 
                ON ccu.constraint_name = tc.constraint_name
                AND ccu.table_schema = tc.table_schema
            WHERE tc.table_schema = ?
            ORDER BY tc.table_name, tc.constraint_type, tc.constraint_name
            """;
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, DB_SCHEMA);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                String constraintType = rs.getString("constraint_type");
                String tableName = rs.getString("table_name");
                String constraintName = rs.getString("constraint_name");
                String columnName = rs.getString("column_name");
                
                if ("PRIMARY KEY".equals(constraintType)) {
                    writer.printf("ALTER TABLE \"%s\" ADD CONSTRAINT \"%s\" PRIMARY KEY (\"%s\");%n",
                        tableName, constraintName, columnName);
                } else if ("FOREIGN KEY".equals(constraintType)) {
                    String foreignTable = rs.getString("foreign_table_name");
                    String foreignColumn = rs.getString("foreign_column_name");
                    writer.printf("ALTER TABLE \"%s\" ADD CONSTRAINT \"%s\" FOREIGN KEY (\"%s\") REFERENCES \"%s\"(\"%s\");%n",
                        tableName, constraintName, columnName, foreignTable, foreignColumn);
                } else if ("UNIQUE".equals(constraintType)) {
                    writer.printf("ALTER TABLE \"%s\" ADD CONSTRAINT \"%s\" UNIQUE (\"%s\");%n",
                        tableName, constraintName, columnName);
                }
            }
        }
        
        writer.println();
    }
    
    private void exportTableData() throws SQLException, IOException {
        System.out.println("2. 📊 Exporting table data...");
        
        String filename = String.format("02_table_data_%s.sql", timestamp);
        Path filePath = outputPath.resolve(filename);
        
        try (PrintWriter writer = new PrintWriter(Files.newBufferedWriter(filePath))) {
            writer.println("-- Table Data Export");
            writer.println("-- Generated on: " + LocalDateTime.now());
            writer.println();
            
            // Get all tables
            String tablesSql = """
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_schema = ? AND table_type = 'BASE TABLE'
                ORDER BY table_name
                """;
            
            try (PreparedStatement stmt = connection.prepareStatement(tablesSql)) {
                stmt.setString(1, DB_SCHEMA);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    String tableName = rs.getString("table_name");
                    exportTableDataForTable(writer, tableName);
                }
            }
        }
    }
    
    private void exportTableDataForTable(PrintWriter writer, String tableName) throws SQLException {
        String sql = "SELECT * FROM \"" + tableName + "\"";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            
            // Get column names
            List<String> columnNames = new ArrayList<>();
            for (int i = 1; i <= columnCount; i++) {
                columnNames.add("\"" + metaData.getColumnName(i) + "\"");
            }
            
            while (rs.next()) {
                writer.print("INSERT INTO \"" + tableName + "\" (");
                writer.print(String.join(", ", columnNames));
                writer.print(") VALUES (");
                
                List<String> values = new ArrayList<>();
                for (int i = 1; i <= columnCount; i++) {
                    Object value = rs.getObject(i);
                    if (value == null) {
                        values.add("NULL");
                    } else if (value instanceof String || value instanceof java.util.Date || value instanceof Timestamp) {
                        values.add("'" + value.toString().replace("'", "''") + "'");
                    } else {
                        values.add(value.toString());
                    }
                }
                
                writer.print(String.join(", ", values));
                writer.println(");");
            }
        }
        
        writer.println();
    }
    
    private void exportViews() throws SQLException, IOException {
        System.out.println("3. 👁️  Exporting views...");
        
        String filename = String.format("05_views_%s.sql", timestamp);
        Path filePath = outputPath.resolve(filename);
        
        try (PrintWriter writer = new PrintWriter(Files.newBufferedWriter(filePath))) {
            writer.println("-- Views Export");
            writer.println("-- Generated on: " + LocalDateTime.now());
            writer.println();
            
            String sql = """
                SELECT table_name, view_definition 
                FROM information_schema.views 
                WHERE table_schema = ?
                ORDER BY table_name
                """;
            
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setString(1, DB_SCHEMA);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    String viewName = rs.getString("table_name");
                    String definition = rs.getString("view_definition");
                    
                    writer.printf("CREATE VIEW \"%s\" AS %s;%n", viewName, definition);
                    writer.println();
                }
            }
        }
    }
    
    private void exportSequences() throws SQLException, IOException {
        System.out.println("4. 🔢 Exporting sequences...");
        
        String filename = String.format("06_sequences_%s.sql", timestamp);
        Path filePath = outputPath.resolve(filename);
        
        try (PrintWriter writer = new PrintWriter(Files.newBufferedWriter(filePath))) {
            writer.println("-- Sequences Export");
            writer.println("-- Generated on: " + LocalDateTime.now());
            writer.println();
            
            String sql = """
                SELECT sequence_name, start_value, minimum_value, maximum_value, increment, cycle_option
                FROM information_schema.sequences 
                WHERE sequence_schema = ?
                ORDER BY sequence_name
                """;
            
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setString(1, DB_SCHEMA);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    String seqName = rs.getString("sequence_name");
                    long startValue = rs.getLong("start_value");
                    long minValue = rs.getLong("minimum_value");
                    long maxValue = rs.getLong("maximum_value");
                    long increment = rs.getLong("increment");
                    String cycle = rs.getString("cycle_option");
                    
                    writer.printf("CREATE SEQUENCE \"%s\" START WITH %d INCREMENT BY %d MINVALUE %d MAXVALUE %d %s;%n",
                        seqName, startValue, increment, minValue, maxValue, 
                        "YES".equals(cycle) ? "CYCLE" : "NO CYCLE");
                }
            }
        }
    }
    
    private void exportIndexes() throws SQLException, IOException {
        System.out.println("5. 📇 Exporting indexes...");
        
        String filename = String.format("07_indexes_%s.sql", timestamp);
        Path filePath = outputPath.resolve(filename);
        
        try (PrintWriter writer = new PrintWriter(Files.newBufferedWriter(filePath))) {
            writer.println("-- Indexes Export");
            writer.println("-- Generated on: " + LocalDateTime.now());
            writer.println();
            
            String sql = """
                SELECT indexname, indexdef 
                FROM pg_indexes 
                WHERE schemaname = ? AND indexname NOT LIKE '%_pkey'
                ORDER BY indexname
                """;
            
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setString(1, DB_SCHEMA);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    String indexDef = rs.getString("indexdef");
                    writer.println(indexDef + ";");
                }
            }
        }
    }
    
    private void exportFunctions() throws SQLException, IOException {
        System.out.println("6. ⚙️  Exporting functions...");
        
        String filename = String.format("03_functions_procedures_%s.sql", timestamp);
        Path filePath = outputPath.resolve(filename);
        
        try (PrintWriter writer = new PrintWriter(Files.newBufferedWriter(filePath))) {
            writer.println("-- Functions and Procedures Export");
            writer.println("-- Generated on: " + LocalDateTime.now());
            writer.println();
            
            String sql = """
                SELECT p.proname, pg_get_functiondef(p.oid) as definition
                FROM pg_proc p
                JOIN pg_namespace n ON p.pronamespace = n.oid
                WHERE n.nspname = ? AND p.prokind IN ('f', 'p')
                ORDER BY p.proname
                """;
            
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setString(1, DB_SCHEMA);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    String definition = rs.getString("definition");
                    writer.println(definition);
                    writer.println();
                }
            }
        }
    }
    
    private void exportTriggers() throws SQLException, IOException {
        System.out.println("7. 🎯 Exporting triggers...");
        
        String filename = String.format("04_triggers_%s.sql", timestamp);
        Path filePath = outputPath.resolve(filename);
        
        try (PrintWriter writer = new PrintWriter(Files.newBufferedWriter(filePath))) {
            writer.println("-- Triggers Export");
            writer.println("-- Generated on: " + LocalDateTime.now());
            writer.println();
            
            String sql = """
                SELECT trigger_name, event_manipulation, event_object_table, 
                       action_timing, action_statement
                FROM information_schema.triggers 
                WHERE trigger_schema = ?
                ORDER BY trigger_name
                """;
            
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setString(1, DB_SCHEMA);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    String triggerName = rs.getString("trigger_name");
                    String timing = rs.getString("action_timing");
                    String event = rs.getString("event_manipulation");
                    String table = rs.getString("event_object_table");
                    String statement = rs.getString("action_statement");
                    
                    writer.printf("CREATE TRIGGER \"%s\" %s %s ON \"%s\" FOR EACH ROW EXECUTE FUNCTION %s;%n",
                        triggerName, timing, event, table, statement);
                }
            }
        }
    }
    
    private void exportCustomTypes() throws SQLException, IOException {
        System.out.println("8. 🏷️  Exporting custom types...");
        
        String filename = String.format("08_custom_types_%s.sql", timestamp);
        Path filePath = outputPath.resolve(filename);
        
        try (PrintWriter writer = new PrintWriter(Files.newBufferedWriter(filePath))) {
            writer.println("-- Custom Types Export");
            writer.println("-- Generated on: " + LocalDateTime.now());
            writer.println();
            
            // Export ENUM types
            String enumSql = """
                SELECT t.typname, array_agg(e.enumlabel ORDER BY e.enumsortorder) as enum_values
                FROM pg_type t
                JOIN pg_namespace n ON t.typnamespace = n.oid
                JOIN pg_enum e ON t.oid = e.enumtypid
                WHERE n.nspname = ? AND t.typtype = 'e'
                GROUP BY t.typname
                ORDER BY t.typname
                """;
            
            try (PreparedStatement stmt = connection.prepareStatement(enumSql)) {
                stmt.setString(1, DB_SCHEMA);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    String typeName = rs.getString("typname");
                    Array enumArray = rs.getArray("enum_values");
                    String[] enumValues = (String[]) enumArray.getArray();
                    
                    writer.printf("CREATE TYPE \"%s\" AS ENUM ('%s');%n",
                        typeName, String.join("', '", enumValues));
                }
            }
        }
    }
    
    private void createCombinedFile() throws IOException {
        System.out.println("9. 📋 Creating combined SQL file...");
        
        String filename = String.format("00_complete_export_%s.sql", timestamp);
        Path filePath = outputPath.resolve(filename);
        
        try (PrintWriter writer = new PrintWriter(Files.newBufferedWriter(filePath))) {
            writer.println("-- Complete PostgreSQL Database Export");
            writer.println("-- Generated on: " + LocalDateTime.now());
            writer.println("-- Database: " + DB_URL);
            writer.println("-- Schema: " + DB_SCHEMA);
            writer.println();
            
            // Combine all files in order
            String[] fileOrder = {
                "08_custom_types_" + timestamp + ".sql",
                "06_sequences_" + timestamp + ".sql", 
                "01_schema_structure_" + timestamp + ".sql",
                "05_views_" + timestamp + ".sql",
                "07_indexes_" + timestamp + ".sql",
                "04_triggers_" + timestamp + ".sql",
                "03_functions_procedures_" + timestamp + ".sql",
                "02_table_data_" + timestamp + ".sql"
            };
            
            for (String file : fileOrder) {
                Path sourceFile = outputPath.resolve(file);
                if (Files.exists(sourceFile)) {
                    writer.println("-- ===== " + file.toUpperCase() + " =====");
                    Files.lines(sourceFile).forEach(writer::println);
                    writer.println();
                }
            }
        }
        
        System.out.println("✅ Combined file created: " + filename);
    }
}