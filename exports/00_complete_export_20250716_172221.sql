-- Complete PostgreSQL Database Export
-- Generated on: 2025-07-16T17:22:27.229530
-- Database: jdbc:postgresql://ep-wispy-haze-a5xy9c41-pooler.us-east-2.aws.neon.tech/workflow?user=wf_owner&password=npg_7hrdeDKf6WyC&sslmode=require&currentSchema=cads
-- Schema: cads

-- ===== 08_CUSTOM_TYPES_20250716_172221.SQL =====
-- Custom Types Export
-- Generated on: 2025-07-16T17:22:27.139873


-- ===== 06_SEQUENCES_20250716_172221.SQL =====
-- Sequences Export
-- Generated on: 2025-07-16T17:22:26.755248

CREATE SEQUENCE "alert_attachments_attachment_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "alert_audit_audit_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "alert_details_mst_alert_detail_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "alert_notes_note_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "business_on_boarding_onboarding_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "business_role_role_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "business_units_unit_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "business_user_user_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "match_notes_match_note_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "notes_audit_audit_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "partition_log_log_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "partition_table_list_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;
CREATE SEQUENCE "search_config_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- ===== 01_SCHEMA_STRUCTURE_20250716_172221.SQL =====
-- Schema Structure Export
-- Generated on: 2025-07-16T17:22:22.525085

CREATE TABLE "alert_attachments" ("attachment_id" INTEGER NOT NULL DEFAULT nextval('alert_attachments_attachment_id_seq'::regclass), "alert_id" INTEGER, "file_name" VARCHAR(255) NOT NULL, "file_path" VARCHAR(255) NOT NULL, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

CREATE TABLE "alert_audit" ("audit_id" INTEGER NOT NULL DEFAULT nextval('alert_audit_audit_id_seq'::regclass), "alert_id" INTEGER, "user_id" INTEGER, "action" VARCHAR(255), "details" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

CREATE TABLE "alert_cstm_attributes" ("alert_id" NUMERIC NOT NULL, "pp_message" TEXT NOT NULL, "created_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_DATE, "created_by" VARCHAR(15) NOT NULL DEFAULT 'System'::character varying, "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_DATE, "gi_message" TEXT, "last_updated_by" VARCHAR(15), "last_updated_date" TIMESTAMP WITHOUT TIME ZONE, "is_post_positive_completed" CHAR(1), "is_early_pp_completed" CHAR(1));

CREATE TABLE "alert_det" ("id" NUMERIC NOT NULL, "alert_id" NUMERIC NOT NULL, "field_name" VARCHAR(4000) NOT NULL, "field_name_alias" VARCHAR(100) NOT NULL, "field_value_offset" NUMERIC NOT NULL, "field_order" NUMERIC NOT NULL, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT ((clock_timestamp() AT TIME ZONE COALESCE(current_setting('aws_oracle_ext.tz'::text, true), 'UTC'::text)))::timestamp(0) without time zone, "last_updated_date" TIMESTAMP WITHOUT TIME ZONE, "created_by" VARCHAR(50) NOT NULL DEFAULT 'System'::character varying, "last_updated_by" VARCHAR(50), "version" NUMERIC, "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_DATE, "field_value" VARCHAR(4000), "is_field_value_clob" CHAR(1));

CREATE TABLE "alert_details_mst" ("alert_detail_id" INTEGER NOT NULL DEFAULT nextval('alert_details_mst_alert_detail_id_seq'::regclass), "alert_id" INTEGER, "detail_description" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE);

CREATE TABLE "alert_mst" ("id" NUMERIC NOT NULL, "source_system" VARCHAR(250) NOT NULL, "due_time" VARCHAR(50), "priority" NUMERIC, "alert_type" VARCHAR(500), "business_unit" VARCHAR(50) NOT NULL, "business_user" VARCHAR(20), "rule_set" VARCHAR(500), "txn_id" VARCHAR(250) NOT NULL, "last_updated_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, "created_by" VARCHAR(50) NOT NULL DEFAULT 'System'::character varying, "last_updated_by" VARCHAR(50), "amount" NUMERIC, "hit_count" NUMERIC, "currency" VARCHAR(3), "replyto_queue_name" VARCHAR(50), "request_number" NUMERIC, "reply_to_manager" VARCHAR(500), "value_date" DATE, "branch" VARCHAR(500), "last_transaction_date" DATE, "closed_date" DATE, "qa_status" VARCHAR(50), "direction" VARCHAR(500), "receiver" VARCHAR(500), "systemid" VARCHAR(500), "remaining_sanctions_matches" NUMERIC, "steps" VARCHAR(50), "closed_by" VARCHAR(50), "origination_branch" VARCHAR(250), "origination_region" VARCHAR(250), "is_post_positive_completed" CHAR(1), "application_alias_name" VARCHAR(500), "unique_transaction_reference" VARCHAR(500), "country_origination" VARCHAR(500), "country_intermediary" VARCHAR(500), "country_destination" VARCHAR(500), "last_stage" VARCHAR(500), "screening_type" VARCHAR(500), "screening_category" VARCHAR(500), "sector" VARCHAR(500), "business_line" VARCHAR(500), "product" VARCHAR(500), "sub_product" VARCHAR(500), "local_reference" VARCHAR(500), "transaction_date" DATE, "sender_bic" VARCHAR(500), "receiver_bic" VARCHAR(500), "payment_currency" VARCHAR(500), "queue_transition_date" DATE, "qa_closed_by" VARCHAR(500), "header_version" CHAR(50), "inquiry_step_identifier" VARCHAR(50), "business_id" NUMERIC, "original_debtor_name" VARCHAR(500), "beneficiary_account" VARCHAR(500), "ordering_customer_account" VARCHAR(500), "product_code" VARCHAR(100), "secondary_site" VARCHAR(50), "derived_step_identifier" VARCHAR(250), "branch_txn_id" VARCHAR(250), "l3_dual_review" CHAR(3) DEFAULT 'No'::bpchar, "research_type" VARCHAR(500), "updated_final_decision" VARCHAR(50), "udf1_datetime" DATE, "screened_date" DATE, "org_citi_legal_vehicle" VARCHAR(750), "org_citi_legal_vehicle_type" VARCHAR(100), "dest_citi_legal_vehicle" VARCHAR(750), "dest_citi_legal_vehicle_type" VARCHAR(100), "dr_alert_id" NUMERIC, "uk_sanctions_authority" VARCHAR(50), "auto_dispose_matches" CHAR(1), "lapc_alert" VARCHAR(50), "citi_enabled" CHAR(1), "parent_alert_id" NUMERIC, "rescind_status" VARCHAR(50), "rmp_alert" VARCHAR(250), "rmp_prev_alertid" NUMERIC, "rmp_rules" VARCHAR(50), "rmp_csaw_instance" VARCHAR(50), "bulk_process_req_id" NUMERIC, "rtm_alert_id" NUMERIC, "is_urgent" CHAR(1) DEFAULT 'N'::bpchar, "partition_date" DATE NOT NULL, "step_identifier" VARCHAR(250), "classification" VARCHAR(250), "created_date" DATE);

CREATE TABLE "alert_notes" ("note_id" INTEGER NOT NULL DEFAULT nextval('alert_notes_note_id_seq'::regclass), "alert_id" INTEGER, "note_text" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

CREATE TABLE "business_on_boarding" ("onboarding_id" INTEGER NOT NULL DEFAULT nextval('business_on_boarding_onboarding_id_seq'::regclass), "user_id" INTEGER, "unit_id" INTEGER, "start_date" DATE, "end_date" DATE, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

CREATE TABLE "business_role" ("role_id" INTEGER NOT NULL DEFAULT nextval('business_role_role_id_seq'::regclass), "role_name" VARCHAR(255) NOT NULL, "description" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

CREATE TABLE "business_units" ("unit_id" INTEGER NOT NULL DEFAULT nextval('business_units_unit_id_seq'::regclass), "unit_name" VARCHAR(255) NOT NULL, "description" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

CREATE TABLE "business_user" ("user_id" INTEGER NOT NULL DEFAULT nextval('business_user_user_id_seq'::regclass), "username" VARCHAR(255) NOT NULL, "password" VARCHAR(255) NOT NULL, "email" VARCHAR(255), "role_id" INTEGER, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

CREATE TABLE "enhanced_search_field_mst" ("field_name" VARCHAR(150), "description" VARCHAR(512), "data_type" VARCHAR(50), "limit" NUMERIC, "operators" VARCHAR(200), "field_size" NUMERIC, "table_name" VARCHAR(30), "column_name" VARCHAR(160), "query" VARCHAR(4000), "argument" VARCHAR(1000), "created_by" VARCHAR(50), "created_date" TIMESTAMP WITHOUT TIME ZONE, "icon" VARCHAR(150), "column_width" NUMERIC, "text_align" VARCHAR(30), "field_type" VARCHAR(30), "gui_identifier" VARCHAR(100), "component" VARCHAR(50), "is_editable" CHAR(1) NOT NULL, "inline_filter_type" VARCHAR(58), "display_order" NUMERIC, "ui_enable" CHAR(1) NOT NULL DEFAULT 'Y'::bpchar, "is_sortable" CHAR(1) NOT NULL DEFAULT 'N'::bpchar);

CREATE TABLE "enhanced_search_fields" ("field_group" VARCHAR(100) NOT NULL, "field_name" VARCHAR(100) NOT NULL, "field_type" VARCHAR(20) NOT NULL, "display_order" NUMERIC NOT NULL, "gui_identifier" VARCHAR(100) NOT NULL, "created_by" VARCHAR(50), "created_date" DATE, "updated_by" VARCHAR(50), "updated_date" DATE, "is_active" CHAR(1) NOT NULL, "partition_date" DATE, "is_sortable" CHAR(1) NOT NULL, "collection_name" VARCHAR(50), "regex_enabled" VARCHAR(1));

CREATE TABLE "gui_label" ("gui_identifier" VARCHAR(100) NOT NULL, "role_identifier" VARCHAR(100) NOT NULL, "label" VARCHAR(1000), "user_language" VARCHAR(100) NOT NULL);

CREATE TABLE "hit_match_detail" ("id" NUMERIC NOT NULL, "match_pattern_value" VARCHAR(700) NOT NULL, "hit_percentage" NUMERIC NOT NULL, "matchable_description" VARCHAR(4000), "category" VARCHAR(400), "created_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_DATE, "created_by" VARCHAR(50) NOT NULL DEFAULT 'System'::character varying, "alert_det_id" NUMERIC NOT NULL, "offset" NUMERIC, "match_length" NUMERIC NOT NULL, "version" NUMERIC, "last_transitioned_by" VARCHAR(50), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_DATE, "alert_id" NUMERIC, "hit_number" NUMERIC(40), "hit_type" VARCHAR(250), "match_text" VARCHAR(4000), "taxonomy_sub_taxonomy_id" NUMERIC, "coverage_area" VARCHAR(100), "specific_coverage_area" VARCHAR(255), "is_final_decision" CHAR(1) DEFAULT 'N'::bpchar, "hit_touch_count" NUMERIC(40), "confirmed_false_match" CHAR(1) DEFAULT 'N'::bpchar, "l3_escalation_not_required" CHAR(1) DEFAULT 'N'::bpchar, "category_lookup" VARCHAR(40), "rule_checksum" VARCHAR(40), "repair_checksum" VARCHAR(40), "l3_checker_required" CHAR(1) DEFAULT 'N'::bpchar, "is_default_taxonomy" CHAR(1) DEFAULT 'N'::bpchar, "last_updated_date" TIMESTAMP WITHOUT TIME ZONE, "add_matchable_description" VARCHAR(4000), "mid_type" VARCHAR(18), "list_entry_type" VARCHAR(50), "list_entry_type_mg" VARCHAR(50), "is_batch_disposed" CHAR(1), "bulk_process_req_id" INTEGER, "rule_engine_id" INTEGER);

CREATE TABLE "match_notes" ("match_note_id" INTEGER NOT NULL DEFAULT nextval('match_notes_match_note_id_seq'::regclass), "alert_detail_id" INTEGER, "note_text" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

CREATE TABLE "notes_audit" ("audit_id" INTEGER NOT NULL DEFAULT nextval('notes_audit_audit_id_seq'::regclass), "note_id" INTEGER, "user_id" INTEGER, "action" VARCHAR(255), "details" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

CREATE TABLE "partition_log" ("log_id" INTEGER NOT NULL DEFAULT nextval('partition_log_log_id_seq'::regclass), "log_timestamp" TIMESTAMP WITH TIME ZONE DEFAULT now(), "schema_name" TEXT, "table_name" TEXT, "log_level" TEXT, "message" TEXT, "details" TEXT);

CREATE TABLE "partition_table_list" ("id" INTEGER NOT NULL DEFAULT nextval('partition_table_list_id_seq'::regclass), "schema_name" TEXT NOT NULL, "table_name" TEXT NOT NULL, "partition_column" TEXT NOT NULL DEFAULT 'partition_date'::text, "partition_column_type" TEXT NOT NULL DEFAULT 'DATE'::text, "partition_interval" TEXT NOT NULL DEFAULT '1 day'::text, "premake" INTEGER NOT NULL DEFAULT 4, "retention_interval" TEXT, "retention_keep_table" BOOLEAN NOT NULL DEFAULT false, "retention_keep_index" BOOLEAN NOT NULL DEFAULT true, "add_partition_column_if_missing" BOOLEAN NOT NULL DEFAULT false, "create_partition_column_index" BOOLEAN NOT NULL DEFAULT true, "optimize_constraint_exclusion" BOOLEAN NOT NULL DEFAULT true, "inherit_privileges" BOOLEAN NOT NULL DEFAULT true, "job_name" TEXT, "cron_schedule" TEXT DEFAULT '0 1 * * *'::text, "enabled" BOOLEAN NOT NULL DEFAULT true, "last_run_status" TEXT, "last_run_timestamp" TIMESTAMP WITH TIME ZONE, "created_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now());

CREATE TABLE "search_config" ("id" INTEGER NOT NULL DEFAULT nextval('search_config_id_seq'::regclass), "table_name" VARCHAR(100), "column_name" VARCHAR(100), "search_type" VARCHAR(50));

CREATE TABLE "user_bu_map" ("user_identifier" VARCHAR(50) NOT NULL, "bu_identifier" VARCHAR(500) NOT NULL, "created_date" TIMESTAMP WITHOUT TIME ZONE, "created_by" VARCHAR(100));

-- Constraints
ALTER TABLE "alert_attachments" ADD CONSTRAINT "alert_attachments_pkey" PRIMARY KEY ("attachment_id");
ALTER TABLE "alert_audit" ADD CONSTRAINT "alert_audit_pkey" PRIMARY KEY ("audit_id");
ALTER TABLE "alert_details_mst" ADD CONSTRAINT "alert_details_mst_pkey" PRIMARY KEY ("alert_detail_id");
ALTER TABLE "alert_notes" ADD CONSTRAINT "alert_notes_pkey" PRIMARY KEY ("note_id");
ALTER TABLE "business_on_boarding" ADD CONSTRAINT "business_on_boarding_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "business_units"("unit_id");
ALTER TABLE "business_on_boarding" ADD CONSTRAINT "business_on_boarding_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "business_user"("user_id");
ALTER TABLE "business_on_boarding" ADD CONSTRAINT "business_on_boarding_pkey" PRIMARY KEY ("onboarding_id");
ALTER TABLE "business_role" ADD CONSTRAINT "business_role_pkey" PRIMARY KEY ("role_id");
ALTER TABLE "business_role" ADD CONSTRAINT "business_role_role_name_key" UNIQUE ("role_name");
ALTER TABLE "business_units" ADD CONSTRAINT "business_units_pkey" PRIMARY KEY ("unit_id");
ALTER TABLE "business_user" ADD CONSTRAINT "business_user_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "business_role"("role_id");
ALTER TABLE "business_user" ADD CONSTRAINT "business_user_pkey" PRIMARY KEY ("user_id");
ALTER TABLE "business_user" ADD CONSTRAINT "business_user_username_key" UNIQUE ("username");
ALTER TABLE "match_notes" ADD CONSTRAINT "match_notes_alert_detail_id_fkey" FOREIGN KEY ("alert_detail_id") REFERENCES "alert_details_mst"("alert_detail_id");
ALTER TABLE "match_notes" ADD CONSTRAINT "match_notes_pkey" PRIMARY KEY ("match_note_id");
ALTER TABLE "notes_audit" ADD CONSTRAINT "notes_audit_note_id_fkey" FOREIGN KEY ("note_id") REFERENCES "alert_notes"("note_id");
ALTER TABLE "notes_audit" ADD CONSTRAINT "notes_audit_pkey" PRIMARY KEY ("audit_id");
ALTER TABLE "partition_log" ADD CONSTRAINT "partition_log_pkey" PRIMARY KEY ("log_id");
ALTER TABLE "partition_table_list" ADD CONSTRAINT "partition_table_list_pkey" PRIMARY KEY ("id");
ALTER TABLE "partition_table_list" ADD CONSTRAINT "partition_table_list_schema_name_table_name_key" UNIQUE ("table_name");
ALTER TABLE "partition_table_list" ADD CONSTRAINT "partition_table_list_schema_name_table_name_key" UNIQUE ("table_name");
ALTER TABLE "partition_table_list" ADD CONSTRAINT "partition_table_list_schema_name_table_name_key" UNIQUE ("schema_name");
ALTER TABLE "partition_table_list" ADD CONSTRAINT "partition_table_list_schema_name_table_name_key" UNIQUE ("schema_name");
ALTER TABLE "search_config" ADD CONSTRAINT "search_config_pkey" PRIMARY KEY ("id");
ALTER TABLE "user_bu_map" ADD CONSTRAINT "user_bu_map_pk" PRIMARY KEY ("bu_identifier");
ALTER TABLE "user_bu_map" ADD CONSTRAINT "user_bu_map_pk" PRIMARY KEY ("user_identifier");
ALTER TABLE "user_bu_map" ADD CONSTRAINT "user_bu_map_pk" PRIMARY KEY ("bu_identifier");
ALTER TABLE "user_bu_map" ADD CONSTRAINT "user_bu_map_pk" PRIMARY KEY ("user_identifier");


-- ===== 05_VIEWS_20250716_172221.SQL =====
-- Views Export
-- Generated on: 2025-07-16T17:22:26.657286


-- ===== 07_INDEXES_20250716_172221.SQL =====
-- Indexes Export
-- Generated on: 2025-07-16T17:22:26.845810

CREATE INDEX alert_det_alert_id_idx ON ONLY cads.alert_det USING btree (alert_id);
CREATE UNIQUE INDEX business_role_role_name_key ON cads.business_role USING btree (role_name);
CREATE UNIQUE INDEX business_user_username_key ON cads.business_user USING btree (username);
CREATE INDEX idx_partition_log_level ON cads.partition_log USING btree (log_level);
CREATE INDEX idx_partition_log_table ON cads.partition_log USING btree (schema_name, table_name);
CREATE INDEX idx_partition_log_timestamp ON cads.partition_log USING btree (log_timestamp);
CREATE UNIQUE INDEX partition_table_list_schema_name_table_name_key ON cads.partition_table_list USING btree (schema_name, table_name);
CREATE UNIQUE INDEX user_bu_map_pk ON cads.user_bu_map USING btree (user_identifier, bu_identifier);

-- ===== 04_TRIGGERS_20250716_172221.SQL =====
-- Triggers Export
-- Generated on: 2025-07-16T17:22:27.043632


-- ===== 03_FUNCTIONS_PROCEDURES_20250716_172221.SQL =====
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



-- ===== 02_TABLE_DATA_20250716_172221.SQL =====
-- Table Data Export
-- Generated on: 2025-07-16T17:22:24.697877













INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'ID', 'int', 1, 'enhsearch_alert_id', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'Y', 'alert_mst', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'SOURCE_SYSTEM', 'string', 2, 'enhsearch_application_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'OWNER', 'string', 3, 'enhsearch_assigned_to', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'Y', 'alert_mst', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'OWNER_GROUP', 'string', 4, 'enhsearch_assigned_to_group', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'Y', 'alert_mst', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'CREATED_DATE', 'date', 5, 'enhsearch_creation_date/time', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'Y', 'alert_mst', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'DUE_TIME', 'string', 6, 'enhsearch_cut_off_time', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'Y');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'INQUIRY_TYPE', 'string', 7, 'enhsearch_inquiry_type', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'RULE_SET', 'string', 8, 'enhsearch_ruleset', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'STEP_IDENTIFIER', 'string', 9, 'enhsearch_current_alert_step', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'Y');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'SUB_STEP_IDENTIFIER', 'string', 10, 'enhsearch_current_alert_sub_step', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'PP_MESSAGE', 'string', 11, 'enhsearch_transaction_message', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_cstm_attribute', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'BENEFICIARY_CUSTOMER_NAME_ADDRESS_59', 'string', 1, 'enhsearch_59_beneficiary_customer_name_address', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'ENRICH_BENEFICIARY_CUST_NAME_ADDR_59', 'string', 2, 'enhsearch_59_enrich_beneficiary_customer_name_address', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'BENEFICIARY', 'string', 3, 'enhsearch_beneficiary', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'BENEFICIARY_NAME', 'string', 4, 'enhsearch_beneficiary_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'CDTR_NAME', 'string', 5, 'enhsearch_cdtr_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'CREDITOR_NAME', 'string', 6, 'enhsearch_creditor_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'ENRICH_CREDITOR_NAME', 'string', 7, 'enhsearch_enrich_creditor_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'ENRICH_CREDITOR_NAME_ADDR', 'string', 8, 'enhsearch_enrich_creditor_name_address', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'ORIGINAL_CREDITOR_NAME', 'string', 9, 'enhsearch_original_creditor_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'ORIGINAL_CREDITOR_NAME_ADDR', 'string', 10, 'enhsearch_original_creditor_name_address', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'SEQB_BENEFICIARY_CUST_NAME_ADDR', 'string', 11, 'enhsearch_seq_b_59_beneficiary_customer_name_address', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'SEQB_ENRICH_BENEFICIARY_CUST_NAME_ADDR', 'string', 12, 'enhsearch_seq_b_59_enrich_beneficiary_customer_nm_addr', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY ACCOUNT', 'BENEFICIARY_ACCOUNT_ID', 'string', 1, 'enhsearch_beneficiary_account_id', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY ACCOUNT', 'BENEFICIARY_ACCOUNT_NUMBER', 'string', 2, 'enhsearch_beneficiary_account_number', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY ACCOUNT', 'CDTR_ACCOUNT_IBAN', 'string', 3, 'enhsearch_cdtr_account_iban', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY ACCOUNT', 'CREDITOR_ACCOUNT_IBAN', 'string', 4, 'enhsearch_creditor_account_iban', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'COVERAGE_AREA', 'string', 1, 'enhsearch_coverage_area', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'DEFAULT_TAXONOMY', 'string', 2, 'enhsearch_default_taxonomy', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'CATEGORY', 'string', 3, 'enhsearch_list_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'HIT_PERCENTAGE', 'string', 4, 'enhsearch_match_accuracy', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'HIT_NUMBER', 'string', 5, 'enhsearch_match_number', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'MATCH_ON', 'string', 6, 'enhsearch_match_on', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'MATCH_PATTERN_VALUE', 'string', 7, 'enhsearch_match_pattern', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'MATCH_TEXT', 'string', 8, 'enhsearch_match_text', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');

INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_alert_id', 'default', 'Alert ID', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_application_name', 'default', 'Application', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_assigned_to', 'default', 'Assigned To', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_assigned_to_group', 'default', 'Assigned To Group', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_creation_date/time', 'default', 'Creation Date/Time', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_cut_off_time', 'default', 'Cut off Time', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_inquiry_type', 'default', 'Inquiry Type', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_ruleset', 'default', 'Ruleset', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_current_alert_step', 'default', 'Step', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_current_alert_sub_step', 'default', 'Sub Step', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_transaction_message', 'default', 'Transaction Message', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_59_beneficiary_customer_name_address', 'default', '59: Beneficiary Customer Name & Address', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_59_enrich_beneficiary_customer_name_address', 'default', '59: Enrich Beneficiary Customer Name & Address', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_beneficiary', 'default', 'Beneficiary', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_beneficiary_name', 'default', 'Beneficiary Name', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_cdtr_name', 'default', 'Cdtr Name', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_creditor_name', 'default', 'Creditor Name', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_enrich_creditor_name', 'default', 'Enrich Creditor Name', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_enrich_creditor_name_address', 'default', 'Enrich Creditor Name & Address', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_original_creditor_name', 'default', 'Original Creditor Name', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_original_creditor_name_address', 'default', 'Original Creditor Name & Address', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_seq_b_59_beneficiary_customer_name_address', 'default', 'Seq B - 59: Beneficiary Customer Name & Address', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_seq_b_59_enrich_beneficiary_customer_nm_addr', 'default', 'Seq B - 59: Enrich Beneficiary Customer Nm & Addr', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_beneficiary_account_id', 'default', 'Beneficiary Account Id', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_beneficiary_account_number', 'default', 'Beneficiary Account Number', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_cdtr_account_iban', 'default', 'Cdtr Account IBAN', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_creditor_account_iban', 'default', 'Creditor Account IBAN', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_coverage_area', 'default', 'Coverage Area', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_default_taxonomy', 'default', 'Default Taxonomy', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_list_name', 'default', 'List Name', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_match_accuracy', 'default', 'Match Accuracy %', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_match_number', 'default', 'Match Number', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_match_on', 'default', 'Match On', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_match_pattern', 'default', 'Match Pattern', 'en');
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_match_text', 'default', 'Match Text', 'en');




INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (311, '2025-04-04 06:13:05.777886', NULL, NULL, 'WARNING', 'pg_cron extension not installed.', 'Automatic scheduling via pg_cron will not be configured.');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (312, '2025-04-04 06:13:05.777886', 'cads', 'alert_attachments', 'INFO', 'Starting processing for table cads.alert_attachments', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (314, '2025-04-04 06:13:05.777886', 'cads', 'alert_attachments', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_attachments'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (315, '2025-04-04 06:13:05.777886', 'cads', 'alert_audit', 'INFO', 'Starting processing for table cads.alert_audit', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (317, '2025-04-04 06:13:05.777886', 'cads', 'alert_audit', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_audit'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (318, '2025-04-04 06:13:05.777886', 'cads', 'alert_details_mst', 'INFO', 'Starting processing for table cads.alert_details_mst', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (320, '2025-04-04 06:13:05.777886', 'cads', 'alert_details_mst', 'ERROR', 'Control column given (partition_date) for parent table (cads.alert_details_mst) does not exist or must be set to NOT NULL
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 103 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_details_mst'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (321, '2025-04-04 06:13:05.777886', 'cads', 'alert_mst', 'INFO', 'Starting processing for table cads.alert_mst', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (322, '2025-04-04 06:13:05.777886', 'cads', 'alert_mst', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_mst'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (323, '2025-04-04 06:13:05.777886', 'cads', 'alert_notes', 'INFO', 'Starting processing for table cads.alert_notes', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (325, '2025-04-04 06:13:05.777886', 'cads', 'alert_notes', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_notes'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (326, '2025-04-04 06:13:05.777886', 'cads', 'business_on_boarding', 'INFO', 'Starting processing for table cads.business_on_boarding', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (328, '2025-04-04 06:13:05.777886', 'cads', 'business_on_boarding', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_on_boarding'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (329, '2025-04-04 06:13:05.777886', 'cads', 'business_role', 'INFO', 'Starting processing for table cads.business_role', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (331, '2025-04-04 06:13:05.777886', 'cads', 'business_role', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_role'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (332, '2025-04-04 06:13:05.777886', 'cads', 'business_units', 'INFO', 'Starting processing for table cads.business_units', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (334, '2025-04-04 06:13:05.777886', 'cads', 'business_units', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_units'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (335, '2025-04-04 06:13:05.777886', 'cads', 'business_user', 'INFO', 'Starting processing for table cads.business_user', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (337, '2025-04-04 06:13:05.777886', 'cads', 'business_user', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_user'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (338, '2025-04-04 06:13:05.777886', 'cads', 'match_notes', 'INFO', 'Starting processing for table cads.match_notes', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (340, '2025-04-04 06:13:05.777886', 'cads', 'match_notes', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.match_notes'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (341, '2025-04-04 06:13:05.777886', 'cads', 'notes_audit', 'INFO', 'Starting processing for table cads.notes_audit', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (343, '2025-04-04 06:13:05.777886', 'cads', 'notes_audit', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.notes_audit'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (344, '2025-04-04 06:13:05.777886', NULL, NULL, 'WARNING', 'pg_cron not installed, maintenance job not scheduled.', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (345, '2025-04-18 08:50:30.594704', NULL, NULL, 'WARNING', 'pg_cron extension not installed.', 'Automatic scheduling via pg_cron will not be configured.');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (346, '2025-04-18 08:50:30.594704', 'cads', 'alert_attachments', 'INFO', 'Starting processing for table cads.alert_attachments', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (348, '2025-04-18 08:50:30.594704', 'cads', 'alert_attachments', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_attachments'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (349, '2025-04-18 08:50:30.594704', 'cads', 'alert_audit', 'INFO', 'Starting processing for table cads.alert_audit', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (351, '2025-04-18 08:50:30.594704', 'cads', 'alert_audit', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_audit'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (352, '2025-04-18 08:50:30.594704', 'cads', 'alert_details_mst', 'INFO', 'Starting processing for table cads.alert_details_mst', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (354, '2025-04-18 08:50:30.594704', 'cads', 'alert_details_mst', 'ERROR', 'Control column given (partition_date) for parent table (cads.alert_details_mst) does not exist or must be set to NOT NULL
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 103 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_details_mst'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (355, '2025-04-18 08:50:30.594704', 'cads', 'alert_mst', 'INFO', 'Starting processing for table cads.alert_mst', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (357, '2025-04-18 08:50:30.594704', 'cads', 'alert_mst', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_mst'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (358, '2025-04-18 08:50:30.594704', 'cads', 'alert_notes', 'INFO', 'Starting processing for table cads.alert_notes', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (360, '2025-04-18 08:50:30.594704', 'cads', 'alert_notes', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_notes'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (361, '2025-04-18 08:50:30.594704', 'cads', 'business_on_boarding', 'INFO', 'Starting processing for table cads.business_on_boarding', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (363, '2025-04-18 08:50:30.594704', 'cads', 'business_on_boarding', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_on_boarding'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (364, '2025-04-18 08:50:30.594704', 'cads', 'business_role', 'INFO', 'Starting processing for table cads.business_role', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (366, '2025-04-18 08:50:30.594704', 'cads', 'business_role', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_role'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (367, '2025-04-18 08:50:30.594704', 'cads', 'business_units', 'INFO', 'Starting processing for table cads.business_units', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (369, '2025-04-18 08:50:30.594704', 'cads', 'business_units', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_units'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (370, '2025-04-18 08:50:30.594704', 'cads', 'business_user', 'INFO', 'Starting processing for table cads.business_user', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (372, '2025-04-18 08:50:30.594704', 'cads', 'business_user', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_user'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (373, '2025-04-18 08:50:30.594704', 'cads', 'match_notes', 'INFO', 'Starting processing for table cads.match_notes', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (375, '2025-04-18 08:50:30.594704', 'cads', 'match_notes', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.match_notes'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (376, '2025-04-18 08:50:30.594704', 'cads', 'notes_audit', 'INFO', 'Starting processing for table cads.notes_audit', NULL);
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (378, '2025-04-18 08:50:30.594704', 'cads', 'notes_audit', 'ERROR', 'You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.notes_audit'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', 'SQLSTATE: P0001');
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (379, '2025-04-18 08:50:30.594704', NULL, NULL, 'WARNING', 'pg_cron not installed, maintenance job not scheduled.', NULL);

INSERT INTO "partition_table_list" ("id", "schema_name", "table_name", "partition_column", "partition_column_type", "partition_interval", "premake", "retention_interval", "retention_keep_table", "retention_keep_index", "add_partition_column_if_missing", "create_partition_column_index", "optimize_constraint_exclusion", "inherit_privileges", "job_name", "cron_schedule", "enabled", "last_run_status", "last_run_timestamp", "created_at", "updated_at") VALUES (1, 'cads', 'alert_attachments', 'partition_date', 'timestamp', '1 day', 3, '6 months', false, true, true, true, true, true, NULL, '0 2 * * *', true, 'ERROR: You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_attachments'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', '2025-04-18 08:50:30.594704', '2025-04-02 21:21:23.663046', '2025-04-02 21:21:23.663046');
INSERT INTO "partition_table_list" ("id", "schema_name", "table_name", "partition_column", "partition_column_type", "partition_interval", "premake", "retention_interval", "retention_keep_table", "retention_keep_index", "add_partition_column_if_missing", "create_partition_column_index", "optimize_constraint_exclusion", "inherit_privileges", "job_name", "cron_schedule", "enabled", "last_run_status", "last_run_timestamp", "created_at", "updated_at") VALUES (2, 'cads', 'alert_audit', 'partition_date', 'timestamp', '1 day', 3, '6 months', false, true, true, true, true, true, NULL, '0 2 * * *', true, 'ERROR: You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_audit'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', '2025-04-18 08:50:30.594704', '2025-04-02 21:21:23.663046', '2025-04-02 21:21:23.663046');
INSERT INTO "partition_table_list" ("id", "schema_name", "table_name", "partition_column", "partition_column_type", "partition_interval", "premake", "retention_interval", "retention_keep_table", "retention_keep_index", "add_partition_column_if_missing", "create_partition_column_index", "optimize_constraint_exclusion", "inherit_privileges", "job_name", "cron_schedule", "enabled", "last_run_status", "last_run_timestamp", "created_at", "updated_at") VALUES (3, 'cads', 'alert_details_mst', 'partition_date', 'timestamp', '1 day', 3, '6 months', false, true, true, true, true, true, NULL, '0 2 * * *', true, 'ERROR: Control column given (partition_date) for parent table (cads.alert_details_mst) does not exist or must be set to NOT NULL
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 103 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_details_mst'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', '2025-04-18 08:50:30.594704', '2025-04-02 21:21:23.663046', '2025-04-02 21:21:23.663046');
INSERT INTO "partition_table_list" ("id", "schema_name", "table_name", "partition_column", "partition_column_type", "partition_interval", "premake", "retention_interval", "retention_keep_table", "retention_keep_index", "add_partition_column_if_missing", "create_partition_column_index", "optimize_constraint_exclusion", "inherit_privileges", "job_name", "cron_schedule", "enabled", "last_run_status", "last_run_timestamp", "created_at", "updated_at") VALUES (4, 'cads', 'alert_mst', 'partition_date', 'timestamp', '1 day', 3, '6 months', false, true, true, true, true, true, NULL, '0 2 * * *', true, 'ERROR: You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_mst'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', '2025-04-18 08:50:30.594704', '2025-04-02 21:21:23.663046', '2025-04-02 21:21:23.663046');
INSERT INTO "partition_table_list" ("id", "schema_name", "table_name", "partition_column", "partition_column_type", "partition_interval", "premake", "retention_interval", "retention_keep_table", "retention_keep_index", "add_partition_column_if_missing", "create_partition_column_index", "optimize_constraint_exclusion", "inherit_privileges", "job_name", "cron_schedule", "enabled", "last_run_status", "last_run_timestamp", "created_at", "updated_at") VALUES (7, 'cads', 'business_role', 'partition_date', 'timestamp', '1 day', 3, '6 months', false, true, true, true, true, true, NULL, '0 2 * * *', true, 'ERROR: You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_role'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', '2025-04-18 08:50:30.594704', '2025-04-02 21:21:23.663046', '2025-04-02 21:21:23.663046');
INSERT INTO "partition_table_list" ("id", "schema_name", "table_name", "partition_column", "partition_column_type", "partition_interval", "premake", "retention_interval", "retention_keep_table", "retention_keep_index", "add_partition_column_if_missing", "create_partition_column_index", "optimize_constraint_exclusion", "inherit_privileges", "job_name", "cron_schedule", "enabled", "last_run_status", "last_run_timestamp", "created_at", "updated_at") VALUES (8, 'cads', 'business_units', 'partition_date', 'timestamp', '1 day', 3, '6 months', false, true, true, true, true, true, NULL, '0 2 * * *', true, 'ERROR: You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_units'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', '2025-04-18 08:50:30.594704', '2025-04-02 21:21:23.663046', '2025-04-02 21:21:23.663046');
INSERT INTO "partition_table_list" ("id", "schema_name", "table_name", "partition_column", "partition_column_type", "partition_interval", "premake", "retention_interval", "retention_keep_table", "retention_keep_index", "add_partition_column_if_missing", "create_partition_column_index", "optimize_constraint_exclusion", "inherit_privileges", "job_name", "cron_schedule", "enabled", "last_run_status", "last_run_timestamp", "created_at", "updated_at") VALUES (9, 'cads', 'business_user', 'partition_date', 'timestamp', '1 day', 3, '6 months', false, true, true, true, true, true, NULL, '0 2 * * *', true, 'ERROR: You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_user'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', '2025-04-18 08:50:30.594704', '2025-04-02 21:21:23.663046', '2025-04-02 21:21:23.663046');
INSERT INTO "partition_table_list" ("id", "schema_name", "table_name", "partition_column", "partition_column_type", "partition_interval", "premake", "retention_interval", "retention_keep_table", "retention_keep_index", "add_partition_column_if_missing", "create_partition_column_index", "optimize_constraint_exclusion", "inherit_privileges", "job_name", "cron_schedule", "enabled", "last_run_status", "last_run_timestamp", "created_at", "updated_at") VALUES (6, 'cads', 'business_on_boarding', 'partition_date', 'timestamp', '1 day', 3, '6 months', false, true, true, true, true, true, NULL, '0 2 * * *', true, 'ERROR: You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.business_on_boarding'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', '2025-04-18 08:50:30.594704', '2025-04-02 21:21:23.663046', '2025-04-02 21:21:23.663046');
INSERT INTO "partition_table_list" ("id", "schema_name", "table_name", "partition_column", "partition_column_type", "partition_interval", "premake", "retention_interval", "retention_keep_table", "retention_keep_index", "add_partition_column_if_missing", "create_partition_column_index", "optimize_constraint_exclusion", "inherit_privileges", "job_name", "cron_schedule", "enabled", "last_run_status", "last_run_timestamp", "created_at", "updated_at") VALUES (5, 'cads', 'alert_notes', 'partition_date', 'timestamp', '1 day', 3, '6 months', false, true, true, true, true, true, NULL, '0 2 * * *', true, 'ERROR: You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.alert_notes'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', '2025-04-18 08:50:30.594704', '2025-04-02 21:21:23.663046', '2025-04-02 21:21:23.663046');
INSERT INTO "partition_table_list" ("id", "schema_name", "table_name", "partition_column", "partition_column_type", "partition_interval", "premake", "retention_interval", "retention_keep_table", "retention_keep_index", "add_partition_column_if_missing", "create_partition_column_index", "optimize_constraint_exclusion", "inherit_privileges", "job_name", "cron_schedule", "enabled", "last_run_status", "last_run_timestamp", "created_at", "updated_at") VALUES (10, 'cads', 'match_notes', 'partition_date', 'timestamp', '1 day', 3, '6 months', false, true, true, true, true, true, NULL, '0 2 * * *', true, 'ERROR: You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.match_notes'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', '2025-04-18 08:50:30.594704', '2025-04-02 21:21:23.663046', '2025-04-02 21:21:23.663046');
INSERT INTO "partition_table_list" ("id", "schema_name", "table_name", "partition_column", "partition_column_type", "partition_interval", "premake", "retention_interval", "retention_keep_table", "retention_keep_index", "add_partition_column_if_missing", "create_partition_column_index", "optimize_constraint_exclusion", "inherit_privileges", "job_name", "cron_schedule", "enabled", "last_run_status", "last_run_timestamp", "created_at", "updated_at") VALUES (11, 'cads', 'notes_audit', 'partition_date', 'timestamp', '1 day', 3, '6 months', false, true, true, true, true, true, NULL, '0 2 * * *', true, 'ERROR: You must have created the given parent table as ranged or list partitioned already. Ex: CREATE TABLE ... PARTITION BY [RANGE|LIST] ...)
CONTEXT: PL/pgSQL function partman.create_parent(text,text,text,text,text,integer,text,boolean,text,text[],text,boolean,text) line 137 at RAISE
SQL statement "SELECT partman.create_parent(
                        p_parent_table := ''cads.notes_audit'',
                        p_control := ''partition_date'',
                        p_type := ''range'',
                        p_interval := ''1 day'',
                        p_premake := 3
                    )"
PL/pgSQL function cads.setup_schema_partitions(text) line 163 at EXECUTE
DETAIL: 
HINT: ', '2025-04-18 08:50:30.594704', '2025-04-02 21:21:23.663046', '2025-04-02 21:21:23.663046');

INSERT INTO "search_config" ("id", "table_name", "column_name", "search_type") VALUES (1, 'products', 'name', 'LIKE');
INSERT INTO "search_config" ("id", "table_name", "column_name", "search_type") VALUES (2, 'products', 'description', 'LIKE');
INSERT INTO "search_config" ("id", "table_name", "column_name", "search_type") VALUES (3, 'products', 'price', 'BETWEEN');
INSERT INTO "search_config" ("id", "table_name", "column_name", "search_type") VALUES (4, 'products', 'category', 'REGEX');



