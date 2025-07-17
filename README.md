# PostgreSQL to Liquibase Export Project

A comprehensive solution to export PostgreSQL database objects as SQL files and convert them to Liquibase-compatible changesets for deployment to different databases.

## 🎯 Overview

This project solves the limitation of Liquibase Open Source in exporting complete database schemas including functions, triggers, views, sequences, and custom types. It provides both JDBC-based and pg_dump-based export methods with automatic conversion to Liquibase changesets.

## ✨ Key Features

- **🔌 JDBC-Based Export (Recommended)**: Uses PostgreSQL JDBC driver - no PostgreSQL client tools required
- **🛠️ pg_dump Export (Alternative)**: Traditional PostgreSQL export method
- **🔄 Automatic Conversion**: Transforms SQL exports to Liquibase changesets
- **📊 Complete Object Export**: Tables, functions, triggers, views, sequences, indexes, custom types
- **📋 Multiple Output Formats**: XML, SQL, YAML, JSON
- **⚙️ Maven Integration**: Automated workflows via Maven profiles

## 🗂️ Project Structure

```
liquibase-schema-export/
├── README.md
├── pom.xml                             # Maven configuration
├── liquibase.properties               # Database connection config
├── liquibase-commands.md              # Command reference
├── src/
│   └── main/
│       ├── java/com/example/exporter/
│       │   └── DatabaseExporter.java   # JDBC-based exporter
│       └── resources/db/changelog/
│           ├── db.changelog-master.xml
│           └── generated changesets... # Liquibase output files
├── scripts/
│   ├── export-database.sh             # pg_dump export script
│   ├── convert-to-liquibase.py        # SQL to Liquibase converter
│   ├── run-jdbc-export.sh            # Complete JDBC workflow
│   └── run-complete-export.sh         # Complete pg_dump workflow
└── exports/                           # Generated SQL exports
```

## 🚀 Quick Start

### Method 1: JDBC Export (Recommended)

No PostgreSQL client tools installation required:

```bash
# Clone and navigate to project
cd liquibase-schema-export

# Run complete workflow
./scripts/run-jdbc-export.sh
```

### Method 2: Maven Profile

```bash
# JDBC-based export + conversion
mvn clean compile -Pjdbc-export

# Alternative: pg_dump export (requires PostgreSQL tools)
mvn clean compile -Ppgdump-export
```

## 📋 Generated Output

The export process creates:

### SQL Exports (exports/ directory)
- `00_complete_export_TIMESTAMP.sql` - Combined export file
- `01_schema_structure_TIMESTAMP.sql` - Table structures and constraints
- `02_table_data_TIMESTAMP.sql` - INSERT statements for all data
- `03_functions_procedures_TIMESTAMP.sql` - Functions and stored procedures
- `04_triggers_TIMESTAMP.sql` - Database triggers
- `05_views_TIMESTAMP.sql` - Database views
- `06_sequences_TIMESTAMP.sql` - Sequences with current values
- `07_indexes_TIMESTAMP.sql` - Non-primary key indexes
- `08_custom_types_TIMESTAMP.sql` - Custom types and enums

### Liquibase Changesets (src/main/resources/db/changelog/)
- `db.changelog-from-pgdump.xml` - XML format
- `db.changelog-from-pgdump.sql` - SQL format
- `db.changelog-from-pgdump.yaml` - YAML format
- `db.changelog-from-pgdump.json` - JSON format

## ⚙️ Configuration

### Database Connection

Update `liquibase.properties` with your database details:

```properties
# Database Connection
url=jdbc:postgresql://your-host:5432/your-database?currentSchema=your-schema
username=your-username
password=your-password
driver=org.postgresql.Driver

# Schema Configuration
defaultSchemaName=your-schema
```

### Java Configuration

Update `DatabaseExporter.java` constants if needed:

```java
private static final String DB_URL = "your-database-url";
private static final String DB_USER = "your-username";
private static final String DB_PASSWORD = "your-password";
private static final String DB_SCHEMA = "your-schema";
```

## 🔧 Available Commands

### Export Commands

```bash
# Complete JDBC workflow (recommended)
./scripts/run-jdbc-export.sh

# Complete pg_dump workflow (requires PostgreSQL tools)
./scripts/run-complete-export.sh

# Manual JDBC export
mvn clean compile exec:java -Dexec.mainClass="com.example.exporter.DatabaseExporter"

# Manual pg_dump export
./scripts/export-database.sh

# Convert SQL to Liquibase formats
python3 scripts/convert-to-liquibase.py exports/export-file.sql -o output-dir -f all
```

### Liquibase Commands

```bash
# Apply changesets to target database
mvn liquibase:update

# Check changeset status
mvn liquibase:status

# Validate changesets
mvn liquibase:validate

# Rollback changes
mvn liquibase:rollback -Dliquibase.rollbackCount=1

# Generate changelog using Liquibase (Open Source limitations)
mvn liquibase:generateChangeLog -Pxml-output
mvn liquibase:generateChangeLog -Psql-output
mvn liquibase:generateChangeLog -Pyaml-output
mvn liquibase:generateChangeLog -Pjson-output
```

## 🔄 Deployment Workflow

### 1. Export Source Database

```bash
# Export from source database
./scripts/run-jdbc-export.sh
```

### 2. Configure Target Database

Update `liquibase.properties` with target database connection:

```properties
url=jdbc:postgresql://target-host:5432/target-database
username=target-username
password=target-password
```

### 3. Deploy to Target Database

```bash
# Apply all changesets
mvn liquibase:update

# Or apply specific changelog
mvn liquibase:update -Dliquibase.changeLogFile=src/main/resources/db/changelog/db.changelog-from-pgdump.xml
```

## 🛠️ Dependencies

### Required
- Java 17+
- Maven 3.6+
- Python 3.6+ (for SQL to Liquibase conversion)

### Optional
- PostgreSQL client tools (for pg_dump method)

### Maven Dependencies
- Liquibase Core 4.25.1
- PostgreSQL JDBC Driver 42.7.1
- Exec Maven Plugin 3.1.0

## 📊 Export Statistics

Recent successful export example:
- **280 changesets** generated
- **9 database object types** exported
- **4 output formats** created (XML, SQL, YAML, JSON)
- **Complete schema structure** with data

## 🔍 Troubleshooting

### Common Issues

1. **Java Version Error**
   ```
   text blocks are not supported in -source 11
   ```
   - Solution: Ensure Java 17+ is installed and configured

2. **PostgreSQL Connection Error**
   ```
   Connection refused
   ```
   - Solution: Verify database connection details in `liquibase.properties`

3. **Python Not Found**
   ```
   python3: command not found
   ```
   - Solution: Install Python 3.6+ or update script to use `python`

4. **Permission Denied**
   ```
   Permission denied: ./scripts/run-jdbc-export.sh
   ```
   - Solution: Make scripts executable: `chmod +x scripts/*.sh`

### Logs and Debugging

Enable verbose logging:
```bash
# Maven verbose mode
mvn clean compile -Pjdbc-export -X

# Liquibase debug mode
mvn liquibase:update -Dliquibase.logLevel=debug
```

## 🎯 Use Cases

- **Database Migration**: Move PostgreSQL databases between environments
- **Schema Versioning**: Create versioned database schemas with Liquibase
- **Multi-Environment Deployment**: Deploy consistent schemas across dev/test/prod
- **Database Backup**: Create portable SQL backups with Liquibase deployment capability
- **Cross-Platform Migration**: Export PostgreSQL for deployment to other databases

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with your PostgreSQL database
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🔗 Related Resources

- [Liquibase Documentation](https://docs.liquibase.com/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Maven Exec Plugin](https://www.mojohaus.org/exec-maven-plugin/)

## 📞 Support

For issues and questions:
1. Check the troubleshooting section
2. Review `liquibase-commands.md` for detailed command reference
3. Open an issue with export logs and error details

---

**Note**: This project overcomes Liquibase Open Source limitations by using direct database export methods to capture ALL PostgreSQL database objects including functions, triggers, views, and custom types that require Liquibase Pro licenses.