-- Functions and Procedures Export
-- Generated on: 2025-07-16T17:22:26.935956

CREATE OR REPLACE FUNCTION cads.automate_search_index_creation()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    r RECORD;
    index_name TEXT;
    sql_command TEXT;
    schema_name TEXT := 'cads'; -- Or the schema where your target tables reside. Adjust if needed.
BEGIN
    RAISE NOTICE 'Starting index automation process...';

    -- Ensure the target schema exists (optional, good practice)
    -- EXECUTE 'CREATE SCHEMA IF NOT EXISTS ' || quote_ident(schema_name);

    -- Enable pg_trgm if not already enabled (runs once)
    BEGIN
        CREATE EXTENSION IF NOT EXISTS pg_trgm;
        RAISE NOTICE 'pg_trgm extension ensured.';
    EXCEPTION WHEN duplicate_object THEN
        RAISE NOTICE 'pg_trgm extension already exists.';
    END;

    FOR r IN
        SELECT lower(esf.collection_name) AS table_name,
               lower(esf.field_name) AS column_name,
               lower(esf.field_type) AS column_type,
               esf.regex_enabled
        FROM cads.enhanced_search_fields esf
        JOIN cads.gui_label gl ON esf.gui_identifier = gl.gui_identifier
        WHERE esf.is_active = 'Y'
        -- Add any other filtering if needed, e.g., specific tables
        -- AND esf.collection_name IN ('table1', 'table2', ...)
    LOOP
        RAISE NOTICE 'Processing table: %, column: %, type: %, regex_enabled: %',
                     quote_ident(r.table_name), quote_ident(r.column_name), r.column_type, r.regex_enabled;

        -- Sanity check: Ensure table and column exist before attempting index creation
        IF NOT EXISTS (
            SELECT 1 FROM information_schema.columns
            WHERE table_schema = schema_name -- Use the defined schema
              AND table_name = r.table_name
              AND column_name = r.column_name
        ) THEN
            RAISE WARNING 'Skipping index creation: Table %.% or column % does not exist in schema %.',
                          quote_ident(r.table_name), quote_ident(r.column_name), quote_ident(r.column_name), quote_ident(schema_name);
            CONTINUE;
        END IF;

        -- Determine index type based on column_type and regex_enabled flag
        IF r.column_type IN ('int', 'date') THEN
            -- Create B-Tree Index
            index_name := format('idx_btree_%s_%s', r.table_name, r.column_name);
            sql_command := format(
                'CREATE INDEX IF NOT EXISTS %I ON %I.%I (%I);',
                index_name,            -- Index name
                schema_name,           -- Schema name
                r.table_name,          -- Table name
                r.column_name          -- Column name
            );
            RAISE NOTICE 'Executing: %', sql_command;
            EXECUTE sql_command;
            RAISE NOTICE 'B-Tree index % created or already exists.', index_name;

        ELSIF r.column_type IN ('string', 'regex') THEN
             -- Create GIN Index using pg_trgm (covers =, !=, LIKE, regex)
            index_name := format('idx_gin_trgm_%s_%s', r.table_name, r.column_name);
             -- Important: Ensure the column type is text-compatible (TEXT, VARCHAR, etc.)
            sql_command := format(
                'CREATE INDEX IF NOT EXISTS %I ON %I.%I USING GIN (%I gin_trgm_ops);',
                index_name,            -- Index name
                schema_name,           -- Schema name
                r.table_name,          -- Table name
                r.column_name          -- Column name
            );
            RAISE NOTICE 'Executing: %', sql_command;
            EXECUTE sql_command;
            RAISE NOTICE 'GIN (pg_trgm) index % created or already exists.', index_name;
        ELSE
            RAISE WARNING 'Unsupported column_type % for column %.% - No index created.',
                          r.column_type, quote_ident(r.table_name), quote_ident(r.column_name);
        END IF;

    END LOOP;

    RAISE NOTICE 'Index automation process finished.';
END;
$function$


CREATE OR REPLACE FUNCTION cads.get_alert_attachments_and_notes(p_alert_id integer)
 RETURNS TABLE(note_text text, file_name character varying, file_path character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        an.note_text,
        aa.file_name,
        aa.file_path
    FROM
        cads.alert_notes an
    LEFT JOIN
        cads.alert_attachments aa ON an.alert_id = aa.alert_id
    WHERE
        an.alert_id = p_alert_id;
END;
$function$


CREATE OR REPLACE FUNCTION cads.get_alert_audit_info(p_alert_id integer)
 RETURNS TABLE(action character varying, details text, created_date timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        aa.action,
        aa.details,
        aa.created_date
    FROM
        cads.alert_audit aa
    WHERE
        aa.alert_id = p_alert_id;
END;
$function$


CREATE OR REPLACE FUNCTION cads.get_alert_details(p_alert_id integer)
 RETURNS TABLE(alert_name character varying, detail_description text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        am.alert_name,
        adm.detail_description
    FROM
        cads.alert_mst am
    JOIN
        cads.alert_details_mst adm ON am.alert_id = adm.alert_id
    WHERE
        am.alert_id = p_alert_id;
END;
$function$


CREATE OR REPLACE FUNCTION cads.get_partition_cron_job_status()
 RETURNS TABLE(jobid bigint, schedule text, command text, nodename text, nodeport integer, database text, username text, active boolean, jobname text)
 LANGUAGE plpgsql
AS $function$
DECLARE
    _pg_cron_installed BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') INTO _pg_cron_installed;
    IF _pg_cron_installed THEN
        RETURN QUERY SELECT * FROM cron.job WHERE jobname = 'pg_partman_maintenance'; -- Use the standard name
    ELSE
        RAISE NOTICE 'pg_cron extension is not installed.';
        -- Return empty result set
        RETURN QUERY SELECT * FROM cron.job WHERE false;
    END IF;
END;
$function$


CREATE OR REPLACE FUNCTION cads.get_partition_logs(p_limit integer DEFAULT 100)
 RETURNS TABLE(log_id integer, log_timestamp timestamp with time zone, schema_name text, table_name text, log_level text, message text, details text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT pl.log_id, pl.log_timestamp, pl.schema_name, pl.table_name, pl.log_level, pl.message, pl.details
    FROM cads.partition_log pl
    ORDER BY pl.log_timestamp DESC
    LIMIT p_limit;
END;
$function$


CREATE OR REPLACE FUNCTION cads.get_partition_status(p_schema_name text DEFAULT NULL::text)
 RETURNS TABLE(id integer, schema_name text, table_name text, enabled boolean, last_run_status text, last_run_timestamp timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT ptl.id, ptl.schema_name, ptl.table_name, ptl.enabled, ptl.last_run_status, ptl.last_run_timestamp
    FROM cads.partition_table_list ptl
    WHERE (p_schema_name IS NULL OR ptl.schema_name = p_schema_name)
    ORDER BY ptl.schema_name, ptl.table_name;
END;
$function$


CREATE OR REPLACE FUNCTION cads.setup_schema_partitions(p_schema_name text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    _config RECORD;
    _parent_table TEXT;
    _column_exists BOOLEAN;
    _pg_partman_installed BOOLEAN;
    _pg_cron_installed BOOLEAN;
    _is_partitioned BOOLEAN;
    _partition_key TEXT;
    _sql TEXT;
    _job_id BIGINT;
    _job_exists BOOLEAN := FALSE;
    _cron_schedule TEXT;
    _maintenance_job_name TEXT := 'pg_partman_maintenance'; -- Standard name for the single maintenance job
BEGIN
    RAISE NOTICE '--- Starting Partitioning Setup for Schema: % ---', p_schema_name;

    -- === Initial Checks ===
    SELECT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_partman') INTO _pg_partman_installed;
    IF NOT _pg_partman_installed THEN
        INSERT INTO cads.partition_log (log_level, message, details) VALUES ('ERROR', 'pg_partman extension not installed.', 'Install with CREATE EXTENSION pg_partman;');
        RAISE EXCEPTION 'pg_partman extension is not installed. Aborting. Install with CREATE EXTENSION pg_partman;';
    END IF;
    RAISE NOTICE 'CHECK: pg_partman extension found.';

    SELECT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') INTO _pg_cron_installed;
    IF NOT _pg_cron_installed THEN
        INSERT INTO cads.partition_log (log_level, message, details) VALUES ('WARNING', 'pg_cron extension not installed.', 'Automatic scheduling via pg_cron will not be configured.');
        RAISE WARNING 'pg_cron extension not installed. Automatic scheduling will not be configured.';
        -- Continue without scheduling if pg_cron isn't there
    ELSE
        RAISE NOTICE 'CHECK: pg_cron extension found.';
    END IF;

    -- === Iterate Through Configured Tables ===
    FOR _config IN
        SELECT * FROM cads.partition_table_list
        WHERE schema_name = p_schema_name AND enabled = true
        ORDER BY table_name -- Process consistently
    LOOP
        _parent_table := format('%I.%I', _config.schema_name, _config.table_name);
        RAISE NOTICE 'Processing table: %', _parent_table;
        INSERT INTO cads.partition_log (schema_name, table_name, log_level, message)
            VALUES (_config.schema_name, _config.table_name, 'INFO', 'Starting processing for table ' || _parent_table);

        BEGIN -- Start block for table-specific error handling

            -- 1. Check Table Existence
            IF NOT EXISTS (
                SELECT 1 FROM information_schema.tables
                WHERE table_schema = _config.schema_name AND table_name = _config.table_name
            ) THEN
                RAISE WARNING 'Table % not found. Skipping.', _parent_table;
                INSERT INTO cads.partition_log (schema_name, table_name, log_level, message)
                    VALUES (_config.schema_name, _config.table_name, 'WARNING', 'Table not found. Skipping.');
                UPDATE cads.partition_table_list SET last_run_status = 'ERROR: Table not found', last_run_timestamp = now()
                    WHERE id = _config.id;
                CONTINUE; -- Next table in loop
            END IF;

            -- 2. Check Partition Column
            SELECT EXISTS (
                SELECT 1 FROM information_schema.columns
                WHERE table_schema = _config.schema_name
                  AND table_name = _config.table_name
                  AND column_name = _config.partition_column
            ) INTO _column_exists;

            IF NOT _column_exists THEN
                IF _config.add_partition_column_if_missing THEN
                    RAISE WARNING '[%] Partition column "%" missing. Adding automatically as type % (DEFAULT NULL). VALIDATE DATA COMPATIBILITY!',
                        _parent_table, _config.partition_column, _config.partition_column_type;
                    INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                        VALUES (_config.schema_name, _config.table_name, 'WARNING', 'Partition column missing. Adding automatically.', format('Column: %s, Type: %s', _config.partition_column, _config.partition_column_type));

                    _sql := format('ALTER TABLE %I.%I ADD COLUMN %I %s DEFAULT NULL;',
                                   _config.schema_name, _config.table_name, _config.partition_column, _config.partition_column_type);
                    RAISE NOTICE 'Executing: %', _sql;
                    EXECUTE _sql;

                    IF _config.create_partition_column_index THEN
                         _sql := format('CREATE INDEX IF NOT EXISTS idx_%s_%s ON %I.%I(%I);',
                                       _config.table_name, _config.partition_column, _config.schema_name, _config.table_name, _config.partition_column);
                         RAISE NOTICE 'Executing: %', _sql;
                         EXECUTE _sql;
                         INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                            VALUES (_config.schema_name, _config.table_name, 'INFO', 'Index created on partition column.', format('Column: %s', _config.partition_column));
                    END IF;
                     -- Re-check column existence after adding it
                     _column_exists := TRUE;
                ELSE
                    RAISE WARNING '[%] Partition column "%" is missing. Manual intervention required (add column and backfill data) or set add_partition_column_if_missing=true.',
                        _parent_table, _config.partition_column;
                    INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                        VALUES (_config.schema_name, _config.table_name, 'ERROR', 'Partition column missing. Manual intervention required.', format('Column: %s', _config.partition_column));
                    UPDATE cads.partition_table_list SET last_run_status = format('ERROR: Partition column %s missing', _config.partition_column), last_run_timestamp = now()
                        WHERE id = _config.id;
                    CONTINUE; -- Next table in loop
                END IF;
            ELSE
                 RAISE NOTICE '[%] Partition column "%" exists.', _parent_table, _config.partition_column;
                 -- Optionally check/create index even if column exists
                 IF _config.create_partition_column_index AND NOT EXISTS (
                     SELECT 1
                     FROM pg_index idx
                     JOIN pg_class t ON t.oid = idx.indrelid
                     JOIN pg_attribute a ON a.attrelid = t.oid AND a.attname = _config.partition_column AND a.attnum = ANY(idx.indkey) -- Ensure it's part of the index
                     JOIN pg_class i ON i.oid = idx.indexrelid
                     JOIN pg_namespace n ON n.oid = t.relnamespace
                     WHERE n.nspname = _config.schema_name
                       AND t.relname = _config.table_name
                       AND i.relname LIKE 'idx_%'  -- index naming convention
                 ) THEN
                     _sql := format('CREATE INDEX IF NOT EXISTS idx_%s_%s ON %I.%I(%I);',
                                    _config.table_name, _config.partition_column, _config.schema_name, _config.table_name, _config.partition_column);
                     RAISE NOTICE '[%] Creating missing index on partition column: %', _parent_table, _sql;
                     EXECUTE _sql;
                     INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                        VALUES (_config.schema_name, _config.table_name, 'INFO', 'Creating missing index on existing partition column.', format('Column: %s', _config.partition_column));
                 END IF;
            END IF; -- End column check/add

            -- 3. Check if already partitioned (and by the correct column)
            SELECT p.partstrat IS NOT NULL, a.attname
            INTO _is_partitioned, _partition_key
            FROM pg_class c
            JOIN pg_namespace n ON n.oid = c.relnamespace
            LEFT JOIN pg_partitioned_table p ON p.partrelid = c.oid
            LEFT JOIN pg_attribute a ON a.attrelid = c.oid AND a.attnum = ANY(p.partattrs)
            WHERE n.nspname = _config.schema_name AND c.relname = _config.table_name AND c.relkind IN ('p', 'r'); -- 'p' = partitioned table, 'r' = regular table

            IF _is_partitioned AND _partition_key IS DISTINCT FROM _config.partition_column THEN
                 RAISE WARNING '[%] Table is already partitioned by "%", but config expects "%". Skipping pg_partman setup.',
                     _parent_table, _partition_key, _config.partition_column;
                 INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                     VALUES (_config.schema_name, _config.table_name, 'ERROR', 'Table partitioned by wrong column.', format('Expected: %s, Found: %s', _config.partition_column, _partition_key));
                 UPDATE cads.partition_table_list SET last_run_status = format('ERROR: Partitioned by wrong column (%s)', _partition_key), last_run_timestamp = now()
                     WHERE id = _config.id;
                 CONTINUE; -- Next table in loop
            END IF;

            -- 4. Setup pg_partman Parent Table configuration
            -- Check if already configured in partman to avoid errors/duplicates
            IF NOT EXISTS (SELECT 1 FROM partman.part_config WHERE parent_table = _parent_table) THEN
                RAISE NOTICE '[%] Configuring pg_partman for table...', _parent_table;
                 _sql := format(
                    'SELECT partman.create_parent(
                        p_parent_table := %L,
                        p_control := %L,
                        p_type := ''range'',
                        p_interval := %L,
                        p_premake := %s
                    )',
                    _parent_table,
                    _config.partition_column,
                    _config.partition_interval,
                    _config.premake,
                    _config.partition_column, _config.schema_name, _config.table_name, -- For min() lookup
                    _config.inherit_privileges,
                    _config.optimize_constraint_exclusion
                );
                RAISE NOTICE 'Executing: %', _sql;
                EXECUTE _sql;
                INSERT INTO cads.partition_log (schema_name, table_name, log_level, message)
                    VALUES (_config.schema_name, _config.table_name, 'INFO', 'Executed partman.create_parent.');
            ELSE
                RAISE NOTICE '[%] Table already configured in pg_partman. Skipping create_parent.', _parent_table;
                INSERT INTO cads.partition_log (schema_name, table_name, log_level, message)
                    VALUES (_config.schema_name, _config.table_name, 'INFO', 'Table already configured in pg_partman.');
            END IF;

            -- 5. Configure Retention (if specified)
            IF _config.retention_interval IS NOT NULL THEN
                RAISE NOTICE '[%] Setting retention policy: interval=%, keep_table=%, keep_index=%',
                             _parent_table, _config.retention_interval, _config.retention_keep_table, _config.retention_keep_index;
                UPDATE partman.part_config
                   SET retention = _config.retention_interval,
                       retention_keep_table = _config.retention_keep_table,
                       retention_keep_index = _config.retention_keep_index,
                       infinite_time_partitions = true -- Recommended for time-based partitioning
                 WHERE parent_table = _parent_table;
                 INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                    VALUES (_config.schema_name, _config.table_name, 'INFO', 'Retention policy updated.',
                            format('Interval: %s, KeepTable: %s, KeepIndex: %s', _config.retention_interval, _config.retention_keep_table, _config.retention_keep_index));
            ELSE
                 RAISE NOTICE '[%] No retention interval specified. Disabling retention.', _parent_table;
                 UPDATE partman.part_config
                   SET retention = NULL,
                       infinite_time_partitions = true
                 WHERE parent_table = _parent_table;
                 INSERT INTO cads.partition_log (schema_name, table_name, log_level, message)
                    VALUES (_config.schema_name, _config.table_name, 'INFO', 'Retention disabled (retention_interval is NULL).');
            END IF;

             -- 6. Update Status in Metadata Table on Success for this table
            UPDATE cads.partition_table_list SET last_run_status = 'SUCCESS', last_run_timestamp = now()
                WHERE id = _config.id;
            RAISE NOTICE '[%] Successfully processed.', _parent_table;

        EXCEPTION WHEN OTHERS THEN
            -- Log error and update status, then continue with the next table
            RAISE WARNING '[%] ERROR during processing: % (%)', _parent_table, SQLERRM, SQLSTATE;
            INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                VALUES (_config.schema_name, _config.table_name, 'ERROR', SQLERRM, format('SQLSTATE: %s', SQLSTATE));
            UPDATE cads.partition_table_list SET last_run_status = format('ERROR: %s', SQLERRM), last_run_timestamp = now()
                WHERE id = _config.id;
            -- Do not re-raise; continue loop
        END; -- End block for table-specific error handling

    END LOOP; -- End table loop

    -- === Setup pg_cron Maintenance Job (if pg_cron is installed) ===
    IF _pg_cron_installed THEN
        -- Find the desired schedule from the *first* enabled config entry (or use a default)
        SELECT cron_schedule INTO _cron_schedule
        FROM cads.partition_table_list
        WHERE enabled = true AND schema_name = p_schema_name AND cron_schedule IS NOT NULL
        ORDER BY id
        LIMIT 1;

        _cron_schedule := COALESCE(_cron_schedule, '0 2 * * *'); -- Default: 2 AM daily if none found

        -- Check if the standard maintenance job already exists
        SELECT EXISTS (SELECT 1 FROM cron.job WHERE jobname = _maintenance_job_name) INTO _job_exists;

        IF NOT _job_exists THEN
            RAISE NOTICE 'Setting up pg_cron job "%" with schedule "%" to run partman.run_maintenance_proc().', _maintenance_job_name, _cron_schedule;
            _sql := format('SELECT cron.schedule(%L, %L, %L)',
                            _maintenance_job_name,
                            _cron_schedule,
                            'SELECT partman.run_maintenance_proc();');
            RAISE NOTICE 'Executing: %', _sql;
            BEGIN
                EXECUTE _sql INTO _job_id;
                 INSERT INTO cads.partition_log (log_level, message, details)
                    VALUES ('INFO', 'pg_cron job scheduled.', format('Job Name: %s, Schedule: %s, Job ID: %s', _maintenance_job_name, _cron_schedule, _job_id));
                 RAISE NOTICE 'Scheduled pg_cron job ID: %', _job_id;
            EXCEPTION WHEN OTHERS THEN
                 RAISE WARNING 'Failed to schedule pg_cron job "%": % (%)', _maintenance_job_name, SQLERRM, SQLSTATE;
                 INSERT INTO cads.partition_log (log_level, message, details)
                    VALUES ('ERROR', 'Failed to schedule pg_cron job.', format('Job Name: %s, Error: %s, SQLSTATE: %s', _maintenance_job_name, SQLERRM, SQLSTATE));
            END;
        ELSE
            RAISE NOTICE 'pg_cron job "%" already exists. Ensure schedule is appropriate. Current schedule can be checked via SELECT schedule FROM cron.job WHERE jobname = %L;', _maintenance_job_name, _maintenance_job_name;
            -- Optional: Update schedule if needed, but be cautious about overwriting manual changes
            -- EXECUTE format('SELECT cron.unschedule(%L)', _maintenance_job_name);
            -- EXECUTE format('SELECT cron.schedule(%L, %L, %L)', _maintenance_job_name, _cron_schedule, 'SELECT partman.run_maintenance_proc();');
             INSERT INTO cads.partition_log (log_level, message, details)
                    VALUES ('INFO', 'pg_cron maintenance job already exists.', format('Job Name: %s', _maintenance_job_name));
        END IF;

        RAISE NOTICE E'IMPORTANT: Ensure the user running the cron job (usually the db superuser or postgres user) has necessary permissions:';
        RAISE NOTICE E'  - USAGE on schema partman';
        RAISE NOTICE E'  - EXECUTE on ALL FUNCTIONS in schema partman';
        RAISE NOTICE E'  - Necessary privileges (SELECT, INSERT, DELETE, UPDATE, CREATE, TRIGGER etc.) on the partitioned tables and their schemas (e.g., %)', p_schema_name;

    ELSE
         RAISE NOTICE 'pg_cron not installed. Manual execution of partman.run_maintenance_proc() is required.';
         INSERT INTO cads.partition_log (log_level, message)
            VALUES ('WARNING', 'pg_cron not installed, maintenance job not scheduled.');
    END IF; -- End pg_cron setup

    RAISE NOTICE '--- Partitioning Setup Finished for Schema: % ---', p_schema_name;

END;
$function$


CREATE OR REPLACE PROCEDURE cads.unpartition_all_cads_tables()
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    parent_rec RECORD;
    child_rec RECORD;
    temp_table_name TEXT;
    original_table_schema TEXT := 'cads'; -- The schema to process
    quoted_parent_table TEXT;
    quoted_temp_table TEXT;
    parent_oid oid;
    child_drop_commands TEXT[]; -- Array to store DROP TABLE commands for children
    child_drop_cmd TEXT;
BEGIN
    RAISE NOTICE '--- Starting Unpartitioning Process for Schema: % ---', original_table_schema;

    -- Find all partitioned tables in the target schema
    FOR parent_rec IN
        SELECT
            c.oid,
            n.nspname AS schema_name,
            c.relname AS table_name
        FROM pg_catalog.pg_class c
        JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
        WHERE n.nspname = original_table_schema
          AND c.relkind = 'p' -- Filter for partitioned tables
    LOOP
        parent_oid := parent_rec.oid;
        quoted_parent_table := pg_catalog.quote_ident(parent_rec.schema_name) || '.' || pg_catalog.quote_ident(parent_rec.table_name);

        RAISE NOTICE 'Processing table: %', quoted_parent_table;

        -- Check if the table actually has partitions before proceeding
        IF EXISTS (SELECT 1 FROM pg_catalog.pg_inherits WHERE inhparent = parent_oid) THEN

            -- Generate a temporary table name
            temp_table_name := parent_rec.table_name || '_unpartitioned_temp_' || md5(random()::text);
            quoted_temp_table := pg_catalog.quote_ident(parent_rec.schema_name) || '.' || pg_catalog.quote_ident(temp_table_name);

            RAISE NOTICE 'Consolidating data from % into temporary table %...', quoted_parent_table, quoted_temp_table;
            BEGIN -- Use a block for EXCEPTION handling per table

                -- --- Step 1: Consolidate data into a new table ---
                RAISE NOTICE 'Creating temporary table %s and copying data...', quoted_temp_table;
                EXECUTE format('CREATE TABLE %s AS SELECT * FROM %s', quoted_temp_table, quoted_parent_table);
                RAISE NOTICE 'Data consolidation complete for %s.', quoted_parent_table;

                -- --- Step 2: Detach all partitions and collect DROP commands ---
                RAISE NOTICE 'Detaching partitions from %s...', quoted_parent_table;
                child_drop_commands := '{}'; -- Initialize the array
                FOR child_rec IN
                    SELECT child_c.relname AS partition_name, child_n.nspname AS partition_schema
                    FROM pg_catalog.pg_inherits i
                    JOIN pg_catalog.pg_class parent_c ON parent_c.oid = i.inhparent
                    JOIN pg_catalog.pg_class child_c ON i.inhrelid = child_c.oid
                    JOIN pg_catalog.pg_namespace child_n ON child_n.oid = child_c.relnamespace
                    WHERE parent_c.oid = parent_oid
                LOOP
                    RAISE NOTICE 'Detaching partition %.%...', child_rec.partition_schema, child_rec.partition_name;
                    EXECUTE format('ALTER TABLE %s DETACH PARTITION %s.%s',
                                   quoted_parent_table,
                                   pg_catalog.quote_ident(child_rec.partition_schema),
                                   pg_catalog.quote_ident(child_rec.partition_name));
                    -- Store the drop command for later
                    child_drop_commands := array_append(child_drop_commands, format('DROP TABLE %s.%s;',
                                                                   pg_catalog.quote_ident(child_rec.partition_schema),
                                                                   pg_catalog.quote_ident(child_rec.partition_name)));
                END LOOP;
                RAISE NOTICE 'All partitions detached for %s.', quoted_parent_table;

                -- --- Step 3: Drop the original parent table ---
                RAISE NOTICE 'Dropping the original partitioned table %s...', quoted_parent_table;
                EXECUTE format('DROP TABLE %s', quoted_parent_table);
                RAISE NOTICE 'Original partitioned table %s dropped.', quoted_parent_table; -- Added table name here for clarity

                -- --- Step 4: Rename the new table to the original table name ---
                RAISE NOTICE 'Renaming %s to %.%...', quoted_temp_table, parent_rec.schema_name, parent_rec.table_name;
                EXECUTE format('ALTER TABLE %s RENAME TO %I', quoted_temp_table, parent_rec.table_name);
                RAISE NOTICE 'Table %.% unpartitioning core steps finished.', parent_rec.schema_name, parent_rec.table_name;

                -- --- Final Notes for this table ---
                -- FIXED: Changed %.% to %s and provided the single quoted_parent_table
                RAISE NOTICE '*** IMPORTANT for %s: This procedure did NOT recreate indexes, constraints (PK, FK, UNIQUE, CHECK), defaults, triggers, permissions, or comments.', quoted_parent_table;
                RAISE NOTICE '*** You MUST manually recreate these objects on the new %s table.', quoted_parent_table;
                -- Added reminder to drop detached partitions
                RAISE NOTICE '*** The following DROP TABLE commands for detached partitions were collected:';
                FOREACH child_drop_cmd IN ARRAY child_drop_commands LOOP
                    RAISE NOTICE '    %s', child_drop_cmd; -- Print each drop command
                END LOOP;
                RAISE NOTICE '*** Execute these commands to drop the old partition tables.';


            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Error processing table %s: %', quoted_parent_table, SQLERRM;
                    -- Decide on rollback strategy if an error occurs mid-process for one table.
                    -- Current behaviour is to continue to the next table.
                    -- If you need atomic operations per table, you might need savepoints
                    -- or separate transactions, which adds complexity.
            END; -- End of per-table exception block
        ELSE
             RAISE NOTICE 'Table %s is marked as partitioned but has no attached partitions. Skipping.', quoted_parent_table;
        END IF;

    END LOOP; -- End of loop through partitioned tables

    RAISE NOTICE '--- Unpartitioning Process for Schema % Finished ---', original_table_schema;
    RAISE NOTICE 'Remember to perform manual post-processing steps for all tables processed (recreate objects, drop detached partitions).';

END;
$procedure$


