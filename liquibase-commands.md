# Liquibase Maven Commands

## Basic Generate Change Log Command

Generate changelog in XML format (default):
```bash
mvn liquibase:generateChangeLog
```

## Output Format Configuration

### XML Format
```bash
mvn liquibase:generateChangeLog -Pxml-output
```

### SQL Format
```bash
mvn liquibase:generateChangeLog -Psql-output
```

### YAML Format
```bash
mvn liquibase:generateChangeLog -Pyaml-output
```

### JSON Format
```bash
mvn liquibase:generateChangeLog -Pjson-output
```

## PostgreSQL Database Export + Liquibase Workflow

### JDBC-based Export Workflow (Recommended)
Uses PostgreSQL JDBC driver - no need for PostgreSQL client tools installation:

```bash
# Run complete JDBC workflow: export + conversion to Liquibase
./scripts/run-jdbc-export.sh
```

### pg_dump Export Workflow (Alternative)
Requires PostgreSQL client tools installation:

```bash
# Run complete pg_dump workflow: export + conversion to Liquibase
./scripts/run-complete-export.sh
```

### Manual Steps

#### Method 1: JDBC Export (No PostgreSQL tools required)
```bash
# Step 1: Export using Java JDBC
mvn clean compile exec:java -Dexec.mainClass="com.example.exporter.DatabaseExporter"

# Step 2: Convert to Liquibase format
python3 scripts/convert-to-liquibase.py exports/00_complete_export_TIMESTAMP.sql -o src/main/resources/db/changelog -f all
```

#### Method 2: pg_dump Export (Requires PostgreSQL client tools)
```bash
# Step 1: Export database using pg_dump
./scripts/export-database.sh

# Step 2: Convert to Liquibase format
python3 scripts/convert-to-liquibase.py exports/00_complete_export_TIMESTAMP.sql -o src/main/resources/db/changelog -f all
```

#### Step 3: Apply to different database
```bash
# Update target database connection in liquibase.properties, then:
mvn liquibase:update -f src/main/resources/db/changelog/db.changelog-from-pgdump.xml
```

### Maven Profiles for Automated Workflow
```bash
# JDBC-based export + conversion (Recommended)
mvn clean compile -Pjdbc-export

# pg_dump export + conversion (Requires PostgreSQL tools)
mvn clean compile -Ppgdump-export
```

## Custom Output Path

Specify custom changelog path:
```bash
mvn liquibase:generateChangeLog -Pcustom-path -Dcustom.changelog.path=custom/path/my-changelog.xml
```

## Database Object Type Configuration

### Include All Database Objects (Default)
```bash
mvn liquibase:generateChangeLog -Dliquibase.diffTypes=catalogs,checkconstraints,columns,data,databasepackage,databasepackagebody,foreignkeys,functions,indexes,primarykeys,sequences,storedprocedures,tables,triggers,uniqueconstraints,views
```

### Tables Only
```bash
mvn liquibase:generateChangeLog -Dliquibase.diffTypes=tables,columns,primarykeys,foreignkeys,indexes
```

### Schema Structure Only (No Data)
```bash
mvn liquibase:generateChangeLog -Dliquibase.diffTypes=tables,columns,primarykeys,foreignkeys,indexes,uniqueconstraints,checkconstraints
```

### Views and Functions Only
```bash
mvn liquibase:generateChangeLog -Dliquibase.diffTypes=views,functions,storedprocedures
```

## Advanced Configuration

### Custom Properties File
```bash
mvn liquibase:generateChangeLog -Dliquibase.propertyFile=custom-liquibase.properties
```

### Override Database Connection
```bash
mvn liquibase:generateChangeLog \
  -Dliquibase.url=jdbc:postgresql://localhost:5432/mydb \
  -Dliquibase.username=myuser \
  -Dliquibase.password=mypass
```

### Include/Exclude Objects
```bash
# Include only specific tables
mvn liquibase:generateChangeLog -Dliquibase.includeObjects=table:user.*,table:order.*

# Exclude temporary tables
mvn liquibase:generateChangeLog -Dliquibase.excludeObjects=table:temp_.*
```

## Complete Example Commands

### Generate complete schema with data in XML format
```bash
mvn clean compile liquibase:generateChangeLog \
  -Pxml-output \
  -Dliquibase.diffTypes=tables,columns,data,primarykeys,foreignkeys,indexes,uniqueconstraints,checkconstraints,views,functions,sequences,triggers \
  -Dliquibase.outputChangeLogFile=src/main/resources/db/changelog/complete-schema.xml
```

### Generate schema structure only in YAML format
```bash
mvn clean compile liquibase:generateChangeLog \
  -Pyaml-output \
  -Dliquibase.diffTypes=tables,columns,primarykeys,foreignkeys,indexes,uniqueconstraints,checkconstraints,views,functions,sequences \
  -Dliquibase.outputChangeLogFile=src/main/resources/db/changelog/schema-structure.yaml
```

### Generate to custom location with SQL format
```bash
mvn clean compile liquibase:generateChangeLog \
  -Psql-output \
  -Dcustom.changelog.path=exports/database-schema.sql
```

## Validation and Status Commands

### Validate changelog
```bash
mvn liquibase:validate
```

### Check database status
```bash
mvn liquibase:status
```

### Generate diff between database and changelog
```bash
mvn liquibase:diff
```

## Notes

1. Run `mvn clean compile` before Liquibase commands to ensure dependencies are available
2. The PostgreSQL database connection is configured in `liquibase.properties`
3. Output files are created in the `src/main/resources/db/changelog/` directory by default
4. Use Maven profiles (-P) to switch between output formats easily
5. Override properties using -D flags for custom configurations