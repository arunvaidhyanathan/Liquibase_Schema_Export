#!/bin/bash

# JDBC-based Database Export and Conversion Workflow
# Uses PostgreSQL JDBC driver instead of pg_dump

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 PostgreSQL JDBC to Liquibase Export Workflow${NC}"
echo "==============================================="
echo ""

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

# Step 1: Compile and run Java exporter
echo -e "${BLUE}📤 Step 1: Exporting database using JDBC...${NC}"
mvn clean compile exec:java -Dexec.mainClass="com.example.exporter.DatabaseExporter" -q

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Database export failed${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Database export completed${NC}"
echo ""

# Step 2: Find the latest export file
echo -e "${BLUE}🔍 Step 2: Finding latest export file...${NC}"
LATEST_EXPORT=$(ls -t exports/00_complete_export_*.sql 2>/dev/null | head -1)

if [ -z "$LATEST_EXPORT" ]; then
    echo -e "${RED}❌ No export file found${NC}"
    exit 1
fi

echo -e "${GREEN}📁 Found export file: $LATEST_EXPORT${NC}"
echo ""

# Step 3: Convert to Liquibase format
echo -e "${BLUE}🔄 Step 3: Converting to Liquibase format...${NC}"
python3 scripts/convert-to-liquibase.py "$LATEST_EXPORT" -o src/main/resources/db/changelog -f all

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Conversion to Liquibase format failed${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Conversion completed${NC}"
echo ""

# Step 4: Display results
echo -e "${BLUE}📊 Step 4: Summary of generated files${NC}"
echo ""

echo -e "${YELLOW}🗃️  JDBC exports (exports/):${NC}"
ls -la exports/ | grep -E "\.(sql)$" | while read line; do
    echo "   📄 $line"
done

echo ""
echo -e "${YELLOW}🔄 Liquibase changesets (src/main/resources/db/changelog/):${NC}"
ls -la src/main/resources/db/changelog/ | grep -E "from-pgdump\.(xml|sql|yaml|json)$" | while read line; do
    echo "   📄 $line"
done

echo ""
echo -e "${GREEN}🎉 Complete JDBC export workflow finished successfully!${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Review the generated Liquibase changesets"
echo "2. Test deployment with: mvn liquibase:update"
echo "3. Use the changesets to deploy to other databases"
echo ""
echo -e "${BLUE}Available Liquibase commands:${NC}"
echo "• mvn liquibase:update                    # Apply changesets to database"
echo "• mvn liquibase:status                    # Check changeset status"
echo "• mvn liquibase:rollback -Dliquibase.rollbackCount=1  # Rollback changes"
echo "• mvn liquibase:validate                  # Validate changesets"
echo ""
echo -e "${BLUE}Maven profiles available:${NC}"
echo "• mvn clean compile -Pjdbc-export         # Full JDBC export + conversion"
echo "• mvn clean compile -Ppgdump-export       # pg_dump export + conversion (requires PostgreSQL tools)"