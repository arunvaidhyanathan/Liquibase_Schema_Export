#!/usr/bin/env python3

"""
PostgreSQL to Liquibase Converter
Converts pg_dump SQL exports to Liquibase-compatible changesets
"""

import os
import re
import sys
import argparse
from datetime import datetime
from pathlib import Path

class PostgreSQLToLiquibaseConverter:
    def __init__(self, input_file, output_dir="liquibase-changesets", format_type="xml"):
        self.input_file = input_file
        self.output_dir = Path(output_dir)
        self.format_type = format_type.lower()
        self.changesets = []
        self.changeset_id = 1
        self.author = "pg_dump_converter"
        
        # Create output directory
        self.output_dir.mkdir(exist_ok=True)
        
    def parse_sql_file(self):
        """Parse the SQL file and extract statements"""
        print(f"📖 Reading SQL file: {self.input_file}")
        
        with open(self.input_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Split into logical statements
        statements = self._split_sql_statements(content)
        
        for statement in statements:
            statement = statement.strip()
            if statement and not statement.startswith('--'):
                self._process_statement(statement)
    
    def _split_sql_statements(self, content):
        """Split SQL content into individual statements"""
        # Remove comments but preserve them in a simplified way
        content = re.sub(r'--.*?$', '', content, flags=re.MULTILINE)
        
        # Split by semicolon, but be careful with semicolons inside quotes
        statements = []
        current_statement = ""
        in_quotes = False
        in_function = False
        
        i = 0
        while i < len(content):
            char = content[i]
            
            if char == "'" and (i == 0 or content[i-1] != '\\'):
                in_quotes = not in_quotes
            elif not in_quotes:
                if content[i:i+15].upper() == 'CREATE FUNCTION':
                    in_function = True
                elif content[i:i+8].upper() == '$$;' or (content[i:i+4].upper() == 'END;' and in_function):
                    in_function = False
                elif char == ';' and not in_function:
                    current_statement += char
                    statements.append(current_statement.strip())
                    current_statement = ""
                    i += 1
                    continue
            
            current_statement += char
            i += 1
        
        # Add any remaining statement
        if current_statement.strip():
            statements.append(current_statement.strip())
        
        return statements
    
    def _process_statement(self, statement):
        """Process individual SQL statement and convert to changeset"""
        statement_upper = statement.upper().strip()
        
        if statement_upper.startswith('CREATE TABLE'):
            self._create_table_changeset(statement)
        elif statement_upper.startswith('CREATE INDEX'):
            self._create_index_changeset(statement)
        elif statement_upper.startswith('CREATE SEQUENCE'):
            self._create_sequence_changeset(statement)
        elif statement_upper.startswith('CREATE VIEW'):
            self._create_view_changeset(statement)
        elif statement_upper.startswith('CREATE TRIGGER'):
            self._create_trigger_changeset(statement)
        elif statement_upper.startswith('CREATE TYPE') or statement_upper.startswith('CREATE DOMAIN'):
            self._create_type_changeset(statement)
        elif statement_upper.startswith('ALTER TABLE') and 'ADD CONSTRAINT' in statement_upper:
            self._create_constraint_changeset(statement)
        elif statement_upper.startswith('INSERT INTO'):
            self._create_insert_changeset(statement)
        elif statement_upper.startswith('CREATE FUNCTION') or statement_upper.startswith('CREATE OR REPLACE FUNCTION'):
            self._create_function_changeset(statement)
        else:
            # Generic SQL changeset for other statements
            self._create_sql_changeset(statement)
    
    def _create_table_changeset(self, statement):
        """Create changeset for CREATE TABLE"""
        table_match = re.search(r'CREATE TABLE\s+(?:"?(\w+)"?\.)?"?(\w+)"?\s*\(', statement, re.IGNORECASE)
        if table_match:
            table_name = table_match.group(2)
            changeset = {
                'id': f"{self.changeset_id}-create-table-{table_name}",
                'author': self.author,
                'type': 'createTable',
                'tableName': table_name,
                'sql': statement
            }
            self.changesets.append(changeset)
            self.changeset_id += 1
    
    def _create_index_changeset(self, statement):
        """Create changeset for CREATE INDEX"""
        index_match = re.search(r'CREATE\s+(?:UNIQUE\s+)?INDEX\s+(?:"?(\w+)"?\s+)?ON\s+(?:"?(\w+)"?\.)?"?(\w+)"?', statement, re.IGNORECASE)
        if index_match:
            index_name = index_match.group(1) or f"idx_{self.changeset_id}"
            table_name = index_match.group(3)
            changeset = {
                'id': f"{self.changeset_id}-create-index-{index_name}",
                'author': self.author,
                'type': 'createIndex',
                'indexName': index_name,
                'tableName': table_name,
                'sql': statement
            }
            self.changesets.append(changeset)
            self.changeset_id += 1
    
    def _create_sequence_changeset(self, statement):
        """Create changeset for CREATE SEQUENCE"""
        seq_match = re.search(r'CREATE SEQUENCE\s+(?:"?(\w+)"?\.)?"?(\w+)"?', statement, re.IGNORECASE)
        if seq_match:
            seq_name = seq_match.group(2)
            changeset = {
                'id': f"{self.changeset_id}-create-sequence-{seq_name}",
                'author': self.author,
                'type': 'createSequence',
                'sequenceName': seq_name,
                'sql': statement
            }
            self.changesets.append(changeset)
            self.changeset_id += 1
    
    def _create_view_changeset(self, statement):
        """Create changeset for CREATE VIEW"""
        view_match = re.search(r'CREATE VIEW\s+(?:"?(\w+)"?\.)?"?(\w+)"?', statement, re.IGNORECASE)
        if view_match:
            view_name = view_match.group(2)
            changeset = {
                'id': f"{self.changeset_id}-create-view-{view_name}",
                'author': self.author,
                'type': 'createView',
                'viewName': view_name,
                'sql': statement
            }
            self.changesets.append(changeset)
            self.changeset_id += 1
    
    def _create_trigger_changeset(self, statement):
        """Create changeset for CREATE TRIGGER"""
        trigger_match = re.search(r'CREATE TRIGGER\s+"?(\w+)"?', statement, re.IGNORECASE)
        if trigger_match:
            trigger_name = trigger_match.group(1)
            changeset = {
                'id': f"{self.changeset_id}-create-trigger-{trigger_name}",
                'author': self.author,
                'type': 'sql',
                'sql': statement
            }
            self.changesets.append(changeset)
            self.changeset_id += 1
    
    def _create_type_changeset(self, statement):
        """Create changeset for CREATE TYPE/DOMAIN"""
        type_match = re.search(r'CREATE\s+(?:TYPE|DOMAIN)\s+(?:"?(\w+)"?\.)?"?(\w+)"?', statement, re.IGNORECASE)
        if type_match:
            type_name = type_match.group(2)
            changeset = {
                'id': f"{self.changeset_id}-create-type-{type_name}",
                'author': self.author,
                'type': 'sql',
                'sql': statement
            }
            self.changesets.append(changeset)
            self.changeset_id += 1
    
    def _create_constraint_changeset(self, statement):
        """Create changeset for ALTER TABLE ADD CONSTRAINT"""
        constraint_match = re.search(r'ALTER TABLE\s+(?:"?(\w+)"?\.)?"?(\w+)"?\s+ADD CONSTRAINT\s+"?(\w+)"?', statement, re.IGNORECASE)
        if constraint_match:
            table_name = constraint_match.group(2)
            constraint_name = constraint_match.group(3)
            changeset = {
                'id': f"{self.changeset_id}-add-constraint-{constraint_name}",
                'author': self.author,
                'type': 'addForeignKeyConstraint',
                'tableName': table_name,
                'sql': statement
            }
            self.changesets.append(changeset)
            self.changeset_id += 1
    
    def _create_insert_changeset(self, statement):
        """Create changeset for INSERT statements"""
        insert_match = re.search(r'INSERT INTO\s+(?:"?(\w+)"?\.)?"?(\w+)"?', statement, re.IGNORECASE)
        if insert_match:
            table_name = insert_match.group(2)
            changeset = {
                'id': f"{self.changeset_id}-insert-data-{table_name}",
                'author': self.author,
                'type': 'insert',
                'tableName': table_name,
                'sql': statement
            }
            self.changesets.append(changeset)
            self.changeset_id += 1
    
    def _create_function_changeset(self, statement):
        """Create changeset for CREATE FUNCTION"""
        func_match = re.search(r'CREATE\s+(?:OR\s+REPLACE\s+)?FUNCTION\s+(?:"?(\w+)"?\.)?"?(\w+)"?', statement, re.IGNORECASE)
        if func_match:
            func_name = func_match.group(2)
            changeset = {
                'id': f"{self.changeset_id}-create-function-{func_name}",
                'author': self.author,
                'type': 'sql',
                'sql': statement
            }
            self.changesets.append(changeset)
            self.changeset_id += 1
    
    def _create_sql_changeset(self, statement):
        """Create generic SQL changeset"""
        changeset = {
            'id': f"{self.changeset_id}-sql-statement",
            'author': self.author,
            'type': 'sql',
            'sql': statement
        }
        self.changesets.append(changeset)
        self.changeset_id += 1
    
    def generate_xml_changelog(self):
        """Generate XML format changelog"""
        filename = self.output_dir / "db.changelog-from-pgdump.xml"
        
        with open(filename, 'w', encoding='utf-8') as f:
            f.write('<?xml version="1.0" encoding="UTF-8"?>\n')
            f.write('<databaseChangeLog\n')
            f.write('    xmlns="http://www.liquibase.org/xml/ns/dbchangelog"\n')
            f.write('    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n')
            f.write('    xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog\n')
            f.write('                        http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-4.25.xsd">\n\n')
            
            for changeset in self.changesets:
                f.write(f'    <changeSet id="{changeset["id"]}" author="{changeset["author"]}">\n')
                
                if changeset['type'] == 'sql':
                    f.write('        <sql><![CDATA[\n')
                    f.write(f'            {changeset["sql"]}\n')
                    f.write('        ]]></sql>\n')
                else:
                    f.write('        <sql><![CDATA[\n')
                    f.write(f'            {changeset["sql"]}\n')
                    f.write('        ]]></sql>\n')
                
                f.write('    </changeSet>\n\n')
            
            f.write('</databaseChangeLog>\n')
        
        return filename
    
    def generate_sql_changelog(self):
        """Generate SQL format changelog"""
        filename = self.output_dir / "db.changelog-from-pgdump.sql"
        
        with open(filename, 'w', encoding='utf-8') as f:
            f.write('-- liquibase formatted sql\n\n')
            
            for changeset in self.changesets:
                f.write(f'-- changeset {changeset["author"]}:{changeset["id"]}\n')
                f.write(f'{changeset["sql"]}\n\n')
        
        return filename
    
    def generate_yaml_changelog(self):
        """Generate YAML format changelog"""
        filename = self.output_dir / "db.changelog-from-pgdump.yaml"
        
        with open(filename, 'w', encoding='utf-8') as f:
            f.write('databaseChangeLog:\n')
            
            for changeset in self.changesets:
                f.write(f'  - changeSet:\n')
                f.write(f'      id: "{changeset["id"]}"\n')
                f.write(f'      author: "{changeset["author"]}"\n')
                f.write('      changes:\n')
                f.write('        - sql:\n')
                f.write('            sql: |\n')
                for line in changeset["sql"].split('\n'):
                    f.write(f'              {line}\n')
                f.write('\n')
        
        return filename
    
    def generate_json_changelog(self):
        """Generate JSON format changelog"""
        import json
        
        filename = self.output_dir / "db.changelog-from-pgdump.json"
        
        changelog = {
            "databaseChangeLog": [
                {
                    "changeSet": {
                        "id": changeset["id"],
                        "author": changeset["author"],
                        "changes": [
                            {
                                "sql": {
                                    "sql": changeset["sql"]
                                }
                            }
                        ]
                    }
                }
                for changeset in self.changesets
            ]
        }
        
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(changelog, f, indent=2, ensure_ascii=False)
        
        return filename
    
    def convert(self):
        """Main conversion method"""
        print(f"🔄 Converting {self.input_file} to Liquibase format...")
        
        # Parse SQL file
        self.parse_sql_file()
        
        print(f"📊 Found {len(self.changesets)} changesets")
        
        # Generate output based on format
        if self.format_type == 'xml':
            output_file = self.generate_xml_changelog()
        elif self.format_type == 'sql':
            output_file = self.generate_sql_changelog()
        elif self.format_type == 'yaml':
            output_file = self.generate_yaml_changelog()
        elif self.format_type == 'json':
            output_file = self.generate_json_changelog()
        else:
            # Generate all formats
            xml_file = self.generate_xml_changelog()
            sql_file = self.generate_sql_changelog()
            yaml_file = self.generate_yaml_changelog()
            json_file = self.generate_json_changelog()
            
            print(f"✅ Generated all formats:")
            print(f"   - XML: {xml_file}")
            print(f"   - SQL: {sql_file}")
            print(f"   - YAML: {yaml_file}")
            print(f"   - JSON: {json_file}")
            return [xml_file, sql_file, yaml_file, json_file]
        
        print(f"✅ Generated {self.format_type.upper()}: {output_file}")
        return output_file

def main():
    parser = argparse.ArgumentParser(description='Convert PostgreSQL pg_dump to Liquibase changesets')
    parser.add_argument('input_file', help='Input SQL file from pg_dump')
    parser.add_argument('-o', '--output-dir', default='liquibase-changesets',
                        help='Output directory for Liquibase files')
    parser.add_argument('-f', '--format', choices=['xml', 'sql', 'yaml', 'json', 'all'],
                        default='all', help='Output format (default: all)')
    
    args = parser.parse_args()
    
    if not os.path.exists(args.input_file):
        print(f"❌ Error: Input file '{args.input_file}' not found")
        sys.exit(1)
    
    converter = PostgreSQLToLiquibaseConverter(
        input_file=args.input_file,
        output_dir=args.output_dir,
        format_type=args.format
    )
    
    try:
        result = converter.convert()
        print(f"\n🎉 Conversion completed successfully!")
        
        if isinstance(result, list):
            print("Generated files:")
            for file in result:
                print(f"  - {file}")
        else:
            print(f"Generated file: {result}")
            
    except Exception as e:
        print(f"❌ Error during conversion: {str(e)}")
        sys.exit(1)

if __name__ == '__main__':
    main()