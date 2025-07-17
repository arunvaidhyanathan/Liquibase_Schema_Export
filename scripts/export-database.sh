#!/bin/bash

# PostgreSQL Database Export Script using pg_dump
# Exports database objects to SQL files for Liquibase conversion

set -e

# Configuration
DB_HOST="ep-wispy-haze-a5xy9c41-pooler.us-east-2.aws.neon.tech"
DB_NAME="workflow"
DB_USER="wf_owner"
DB_PASSWORD="npg_7hrdeDKf6WyC"
DB_SCHEMA="cads"
OUTPUT_DIR="exports"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}PostgreSQL Database Export Script${NC}"
echo "================================="
echo "Host: $DB_HOST"
echo "Database: $DB_NAME"
echo "Schema: $DB_SCHEMA"
echo "Timestamp: $TIMESTAMP"
echo ""

# Create output directory
mkdir -p $OUTPUT_DIR

# Set PGPASSWORD environment variable for non-interactive authentication
export PGPASSWORD="$DB_PASSWORD"

echo -e "${YELLOW}Starting database export...${NC}"

# 1. Export complete schema structure (no data)
echo "1. Exporting schema structure..."
pg_dump -h "$DB_HOST" \
        -U "$DB_USER" \
        -d "$DB_NAME" \
        -n "$DB_SCHEMA" \
        --schema-only \
        --no-owner \
        --no-privileges \
        --no-tablespaces \
        --no-security-labels \
        --no-comments \
        -f "$OUTPUT_DIR/01_schema_structure_${TIMESTAMP}.sql"

# 2. Export data only (for specific tables)
echo "2. Exporting table data..."
pg_dump -h "$DB_HOST" \
        -U "$DB_USER" \
        -d "$DB_NAME" \
        -n "$DB_SCHEMA" \
        --data-only \
        --no-owner \
        --no-privileges \
        --column-inserts \
        --rows-per-insert=1000 \
        -f "$OUTPUT_DIR/02_table_data_${TIMESTAMP}.sql"

# 3. Export functions and procedures separately
echo "3. Exporting functions and procedures..."
pg_dump -h "$DB_HOST" \
        -U "$DB_USER" \
        -d "$DB_NAME" \
        -n "$DB_SCHEMA" \
        --schema-only \
        --no-owner \
        --no-privileges \
        -t 'pg_proc' \
        --include-foreign-data=never \
        -f "$OUTPUT_DIR/03_functions_procedures_${TIMESTAMP}.sql" 2>/dev/null || true

# 4. Export triggers separately
echo "4. Exporting triggers..."
psql -h "$DB_HOST" \
     -U "$DB_USER" \
     -d "$DB_NAME" \
     -t \
     -c "
SELECT 'CREATE TRIGGER ' || trigger_name || ' ' ||
       action_timing || ' ' || string_agg(event_manipulation, ' OR ') || 
       ' ON ' || event_object_schema || '.' || event_object_table ||
       ' FOR EACH ' || action_orientation ||
       ' EXECUTE FUNCTION ' || action_statement || ';'
FROM information_schema.triggers
WHERE trigger_schema = '$DB_SCHEMA'
GROUP BY trigger_name, action_timing, event_object_schema, event_object_table, action_orientation, action_statement
ORDER BY trigger_name;
" > "$OUTPUT_DIR/04_triggers_${TIMESTAMP}.sql"

# 5. Export views separately
echo "5. Exporting views..."
psql -h "$DB_HOST" \
     -U "$DB_USER" \
     -d "$DB_NAME" \
     -t \
     -c "
SELECT 'CREATE VIEW ' || schemaname || '.' || viewname || ' AS ' || definition
FROM pg_views
WHERE schemaname = '$DB_SCHEMA'
ORDER BY viewname;
" > "$OUTPUT_DIR/05_views_${TIMESTAMP}.sql"

# 6. Export sequences
echo "6. Exporting sequences..."
psql -h "$DB_HOST" \
     -U "$DB_USER" \
     -d "$DB_NAME" \
     -t \
     -c "
SELECT 'CREATE SEQUENCE ' || schemaname || '.' || sequencename ||
       ' START WITH ' || start_value ||
       ' INCREMENT BY ' || increment_by ||
       ' MINVALUE ' || min_value ||
       ' MAXVALUE ' || max_value ||
       CASE WHEN cycle THEN ' CYCLE' ELSE ' NO CYCLE' END || ';'
FROM pg_sequences
WHERE schemaname = '$DB_SCHEMA'
ORDER BY sequencename;
" > "$OUTPUT_DIR/06_sequences_${TIMESTAMP}.sql"

# 7. Export indexes (non-primary key indexes)
echo "7. Exporting indexes..."
psql -h "$DB_HOST" \
     -U "$DB_USER" \
     -d "$DB_NAME" \
     -t \
     -c "
SELECT indexdef || ';'
FROM pg_indexes
WHERE schemaname = '$DB_SCHEMA'
  AND indexname NOT LIKE '%_pkey'
ORDER BY indexname;
" > "$OUTPUT_DIR/07_indexes_${TIMESTAMP}.sql"

# 8. Export custom types and domains
echo "8. Exporting custom types..."
psql -h "$DB_HOST" \
     -U "$DB_USER" \
     -d "$DB_NAME" \
     -t \
     -c "
SELECT 
    CASE 
        WHEN t.typtype = 'e' THEN 
            'CREATE TYPE ' || n.nspname || '.' || t.typname || ' AS ENUM (' ||
            string_agg('''' || e.enumlabel || '''', ', ' ORDER BY e.enumsortorder) || ');'
        WHEN t.typtype = 'd' THEN
            'CREATE DOMAIN ' || n.nspname || '.' || t.typname || ' AS ' || format_type(t.typbasetype, t.typtypmod) || ';'
    END as type_definition
FROM pg_type t
JOIN pg_namespace n ON t.typnamespace = n.oid
LEFT JOIN pg_enum e ON t.oid = e.enumtypid
WHERE n.nspname = '$DB_SCHEMA'
  AND t.typtype IN ('e', 'd')
GROUP BY n.nspname, t.typname, t.typtype, t.typbasetype, t.typtypmod
ORDER BY t.typname;
" > "$OUTPUT_DIR/08_custom_types_${TIMESTAMP}.sql"

# Clean up environment variable
unset PGPASSWORD

# Create a combined file with all objects
echo "9. Creating combined SQL file..."
cat > "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql" << EOF
-- Complete PostgreSQL Database Export
-- Generated on: $(date)
-- Database: $DB_NAME
-- Schema: $DB_SCHEMA
-- Host: $DB_HOST

-- ===== CUSTOM TYPES =====
EOF

if [ -s "$OUTPUT_DIR/08_custom_types_${TIMESTAMP}.sql" ]; then
    cat "$OUTPUT_DIR/08_custom_types_${TIMESTAMP}.sql" >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql"
fi

cat >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql" << EOF

-- ===== SEQUENCES =====
EOF

if [ -s "$OUTPUT_DIR/06_sequences_${TIMESTAMP}.sql" ]; then
    cat "$OUTPUT_DIR/06_sequences_${TIMESTAMP}.sql" >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql"
fi

cat >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql" << EOF

-- ===== SCHEMA STRUCTURE =====
EOF

cat "$OUTPUT_DIR/01_schema_structure_${TIMESTAMP}.sql" >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql"

cat >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql" << EOF

-- ===== VIEWS =====
EOF

if [ -s "$OUTPUT_DIR/05_views_${TIMESTAMP}.sql" ]; then
    cat "$OUTPUT_DIR/05_views_${TIMESTAMP}.sql" >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql"
fi

cat >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql" << EOF

-- ===== INDEXES =====
EOF

if [ -s "$OUTPUT_DIR/07_indexes_${TIMESTAMP}.sql" ]; then
    cat "$OUTPUT_DIR/07_indexes_${TIMESTAMP}.sql" >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql"
fi

cat >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql" << EOF

-- ===== TRIGGERS =====
EOF

if [ -s "$OUTPUT_DIR/04_triggers_${TIMESTAMP}.sql" ]; then
    cat "$OUTPUT_DIR/04_triggers_${TIMESTAMP}.sql" >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql"
fi

cat >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql" << EOF

-- ===== TABLE DATA =====
EOF

cat "$OUTPUT_DIR/02_table_data_${TIMESTAMP}.sql" >> "$OUTPUT_DIR/00_complete_export_${TIMESTAMP}.sql"

echo ""
echo -e "${GREEN}Database export completed successfully!${NC}"
echo ""
echo "Generated files:"
echo "- 00_complete_export_${TIMESTAMP}.sql (Combined export)"
echo "- 01_schema_structure_${TIMESTAMP}.sql"
echo "- 02_table_data_${TIMESTAMP}.sql"
echo "- 03_functions_procedures_${TIMESTAMP}.sql"
echo "- 04_triggers_${TIMESTAMP}.sql"
echo "- 05_views_${TIMESTAMP}.sql"
echo "- 06_sequences_${TIMESTAMP}.sql"
echo "- 07_indexes_${TIMESTAMP}.sql"
echo "- 08_custom_types_${TIMESTAMP}.sql"
echo ""
echo "Next step: Run convert-to-liquibase.py to create Liquibase changesets"