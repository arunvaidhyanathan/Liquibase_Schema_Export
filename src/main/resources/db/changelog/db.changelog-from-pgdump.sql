-- liquibase formatted sql

-- changeset pg_dump_converter:1-create-sequence-alert_attachments_attachment_id_seq
CREATE SEQUENCE "alert_attachments_attachment_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:2-create-sequence-alert_audit_audit_id_seq
CREATE SEQUENCE "alert_audit_audit_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:3-create-sequence-alert_details_mst_alert_detail_id_seq
CREATE SEQUENCE "alert_details_mst_alert_detail_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:4-create-sequence-alert_notes_note_id_seq
CREATE SEQUENCE "alert_notes_note_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:5-create-sequence-business_on_boarding_onboarding_id_seq
CREATE SEQUENCE "business_on_boarding_onboarding_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:6-create-sequence-business_role_role_id_seq
CREATE SEQUENCE "business_role_role_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:7-create-sequence-business_units_unit_id_seq
CREATE SEQUENCE "business_units_unit_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:8-create-sequence-business_user_user_id_seq
CREATE SEQUENCE "business_user_user_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:9-create-sequence-match_notes_match_note_id_seq
CREATE SEQUENCE "match_notes_match_note_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:10-create-sequence-notes_audit_audit_id_seq
CREATE SEQUENCE "notes_audit_audit_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:11-create-sequence-partition_log_log_id_seq
CREATE SEQUENCE "partition_log_log_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:12-create-sequence-partition_table_list_id_seq
CREATE SEQUENCE "partition_table_list_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:13-create-sequence-search_config_id_seq
CREATE SEQUENCE "search_config_id_seq" START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE;

-- changeset pg_dump_converter:14-create-table-alert_attachments
CREATE TABLE "alert_attachments" ("attachment_id" INTEGER NOT NULL DEFAULT nextval('alert_attachments_attachment_id_seq'::regclass), "alert_id" INTEGER, "file_name" VARCHAR(255) NOT NULL, "file_path" VARCHAR(255) NOT NULL, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

-- changeset pg_dump_converter:15-create-table-alert_audit
CREATE TABLE "alert_audit" ("audit_id" INTEGER NOT NULL DEFAULT nextval('alert_audit_audit_id_seq'::regclass), "alert_id" INTEGER, "user_id" INTEGER, "action" VARCHAR(255), "details" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

-- changeset pg_dump_converter:16-create-table-alert_cstm_attributes
CREATE TABLE "alert_cstm_attributes" ("alert_id" NUMERIC NOT NULL, "pp_message" TEXT NOT NULL, "created_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_DATE, "created_by" VARCHAR(15) NOT NULL DEFAULT 'System'::character varying, "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_DATE, "gi_message" TEXT, "last_updated_by" VARCHAR(15), "last_updated_date" TIMESTAMP WITHOUT TIME ZONE, "is_post_positive_completed" CHAR(1), "is_early_pp_completed" CHAR(1));

-- changeset pg_dump_converter:17-create-table-alert_det
CREATE TABLE "alert_det" ("id" NUMERIC NOT NULL, "alert_id" NUMERIC NOT NULL, "field_name" VARCHAR(4000) NOT NULL, "field_name_alias" VARCHAR(100) NOT NULL, "field_value_offset" NUMERIC NOT NULL, "field_order" NUMERIC NOT NULL, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT ((clock_timestamp() AT TIME ZONE COALESCE(current_setting('aws_oracle_ext.tz'::text, true), 'UTC'::text)))::timestamp(0) without time zone, "last_updated_date" TIMESTAMP WITHOUT TIME ZONE, "created_by" VARCHAR(50) NOT NULL DEFAULT 'System'::character varying, "last_updated_by" VARCHAR(50), "version" NUMERIC, "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_DATE, "field_value" VARCHAR(4000), "is_field_value_clob" CHAR(1));

-- changeset pg_dump_converter:18-create-table-alert_details_mst
CREATE TABLE "alert_details_mst" ("alert_detail_id" INTEGER NOT NULL DEFAULT nextval('alert_details_mst_alert_detail_id_seq'::regclass), "alert_id" INTEGER, "detail_description" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE);

-- changeset pg_dump_converter:19-create-table-alert_mst
CREATE TABLE "alert_mst" ("id" NUMERIC NOT NULL, "source_system" VARCHAR(250) NOT NULL, "due_time" VARCHAR(50), "priority" NUMERIC, "alert_type" VARCHAR(500), "business_unit" VARCHAR(50) NOT NULL, "business_user" VARCHAR(20), "rule_set" VARCHAR(500), "txn_id" VARCHAR(250) NOT NULL, "last_updated_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP, "created_by" VARCHAR(50) NOT NULL DEFAULT 'System'::character varying, "last_updated_by" VARCHAR(50), "amount" NUMERIC, "hit_count" NUMERIC, "currency" VARCHAR(3), "replyto_queue_name" VARCHAR(50), "request_number" NUMERIC, "reply_to_manager" VARCHAR(500), "value_date" DATE, "branch" VARCHAR(500), "last_transaction_date" DATE, "closed_date" DATE, "qa_status" VARCHAR(50), "direction" VARCHAR(500), "receiver" VARCHAR(500), "systemid" VARCHAR(500), "remaining_sanctions_matches" NUMERIC, "steps" VARCHAR(50), "closed_by" VARCHAR(50), "origination_branch" VARCHAR(250), "origination_region" VARCHAR(250), "is_post_positive_completed" CHAR(1), "application_alias_name" VARCHAR(500), "unique_transaction_reference" VARCHAR(500), "country_origination" VARCHAR(500), "country_intermediary" VARCHAR(500), "country_destination" VARCHAR(500), "last_stage" VARCHAR(500), "screening_type" VARCHAR(500), "screening_category" VARCHAR(500), "sector" VARCHAR(500), "business_line" VARCHAR(500), "product" VARCHAR(500), "sub_product" VARCHAR(500), "local_reference" VARCHAR(500), "transaction_date" DATE, "sender_bic" VARCHAR(500), "receiver_bic" VARCHAR(500), "payment_currency" VARCHAR(500), "queue_transition_date" DATE, "qa_closed_by" VARCHAR(500), "header_version" CHAR(50), "inquiry_step_identifier" VARCHAR(50), "business_id" NUMERIC, "original_debtor_name" VARCHAR(500), "beneficiary_account" VARCHAR(500), "ordering_customer_account" VARCHAR(500), "product_code" VARCHAR(100), "secondary_site" VARCHAR(50), "derived_step_identifier" VARCHAR(250), "branch_txn_id" VARCHAR(250), "l3_dual_review" CHAR(3) DEFAULT 'No'::bpchar, "research_type" VARCHAR(500), "updated_final_decision" VARCHAR(50), "udf1_datetime" DATE, "screened_date" DATE, "org_citi_legal_vehicle" VARCHAR(750), "org_citi_legal_vehicle_type" VARCHAR(100), "dest_citi_legal_vehicle" VARCHAR(750), "dest_citi_legal_vehicle_type" VARCHAR(100), "dr_alert_id" NUMERIC, "uk_sanctions_authority" VARCHAR(50), "auto_dispose_matches" CHAR(1), "lapc_alert" VARCHAR(50), "citi_enabled" CHAR(1), "parent_alert_id" NUMERIC, "rescind_status" VARCHAR(50), "rmp_alert" VARCHAR(250), "rmp_prev_alertid" NUMERIC, "rmp_rules" VARCHAR(50), "rmp_csaw_instance" VARCHAR(50), "bulk_process_req_id" NUMERIC, "rtm_alert_id" NUMERIC, "is_urgent" CHAR(1) DEFAULT 'N'::bpchar, "partition_date" DATE NOT NULL, "step_identifier" VARCHAR(250), "classification" VARCHAR(250), "created_date" DATE);

-- changeset pg_dump_converter:20-create-table-alert_notes
CREATE TABLE "alert_notes" ("note_id" INTEGER NOT NULL DEFAULT nextval('alert_notes_note_id_seq'::regclass), "alert_id" INTEGER, "note_text" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

-- changeset pg_dump_converter:21-create-table-business_on_boarding
CREATE TABLE "business_on_boarding" ("onboarding_id" INTEGER NOT NULL DEFAULT nextval('business_on_boarding_onboarding_id_seq'::regclass), "user_id" INTEGER, "unit_id" INTEGER, "start_date" DATE, "end_date" DATE, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

-- changeset pg_dump_converter:22-create-table-business_role
CREATE TABLE "business_role" ("role_id" INTEGER NOT NULL DEFAULT nextval('business_role_role_id_seq'::regclass), "role_name" VARCHAR(255) NOT NULL, "description" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

-- changeset pg_dump_converter:23-create-table-business_units
CREATE TABLE "business_units" ("unit_id" INTEGER NOT NULL DEFAULT nextval('business_units_unit_id_seq'::regclass), "unit_name" VARCHAR(255) NOT NULL, "description" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

-- changeset pg_dump_converter:24-create-table-business_user
CREATE TABLE "business_user" ("user_id" INTEGER NOT NULL DEFAULT nextval('business_user_user_id_seq'::regclass), "username" VARCHAR(255) NOT NULL, "password" VARCHAR(255) NOT NULL, "email" VARCHAR(255), "role_id" INTEGER, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

-- changeset pg_dump_converter:25-create-table-enhanced_search_field_mst
CREATE TABLE "enhanced_search_field_mst" ("field_name" VARCHAR(150), "description" VARCHAR(512), "data_type" VARCHAR(50), "limit" NUMERIC, "operators" VARCHAR(200), "field_size" NUMERIC, "table_name" VARCHAR(30), "column_name" VARCHAR(160), "query" VARCHAR(4000), "argument" VARCHAR(1000), "created_by" VARCHAR(50), "created_date" TIMESTAMP WITHOUT TIME ZONE, "icon" VARCHAR(150), "column_width" NUMERIC, "text_align" VARCHAR(30), "field_type" VARCHAR(30), "gui_identifier" VARCHAR(100), "component" VARCHAR(50), "is_editable" CHAR(1) NOT NULL, "inline_filter_type" VARCHAR(58), "display_order" NUMERIC, "ui_enable" CHAR(1) NOT NULL DEFAULT 'Y'::bpchar, "is_sortable" CHAR(1) NOT NULL DEFAULT 'N'::bpchar);

-- changeset pg_dump_converter:26-create-table-enhanced_search_fields
CREATE TABLE "enhanced_search_fields" ("field_group" VARCHAR(100) NOT NULL, "field_name" VARCHAR(100) NOT NULL, "field_type" VARCHAR(20) NOT NULL, "display_order" NUMERIC NOT NULL, "gui_identifier" VARCHAR(100) NOT NULL, "created_by" VARCHAR(50), "created_date" DATE, "updated_by" VARCHAR(50), "updated_date" DATE, "is_active" CHAR(1) NOT NULL, "partition_date" DATE, "is_sortable" CHAR(1) NOT NULL, "collection_name" VARCHAR(50), "regex_enabled" VARCHAR(1));

-- changeset pg_dump_converter:27-create-table-gui_label
CREATE TABLE "gui_label" ("gui_identifier" VARCHAR(100) NOT NULL, "role_identifier" VARCHAR(100) NOT NULL, "label" VARCHAR(1000), "user_language" VARCHAR(100) NOT NULL);

-- changeset pg_dump_converter:28-create-table-hit_match_detail
CREATE TABLE "hit_match_detail" ("id" NUMERIC NOT NULL, "match_pattern_value" VARCHAR(700) NOT NULL, "hit_percentage" NUMERIC NOT NULL, "matchable_description" VARCHAR(4000), "category" VARCHAR(400), "created_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_DATE, "created_by" VARCHAR(50) NOT NULL DEFAULT 'System'::character varying, "alert_det_id" NUMERIC NOT NULL, "offset" NUMERIC, "match_length" NUMERIC NOT NULL, "version" NUMERIC, "last_transitioned_by" VARCHAR(50), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_DATE, "alert_id" NUMERIC, "hit_number" NUMERIC(40), "hit_type" VARCHAR(250), "match_text" VARCHAR(4000), "taxonomy_sub_taxonomy_id" NUMERIC, "coverage_area" VARCHAR(100), "specific_coverage_area" VARCHAR(255), "is_final_decision" CHAR(1) DEFAULT 'N'::bpchar, "hit_touch_count" NUMERIC(40), "confirmed_false_match" CHAR(1) DEFAULT 'N'::bpchar, "l3_escalation_not_required" CHAR(1) DEFAULT 'N'::bpchar, "category_lookup" VARCHAR(40), "rule_checksum" VARCHAR(40), "repair_checksum" VARCHAR(40), "l3_checker_required" CHAR(1) DEFAULT 'N'::bpchar, "is_default_taxonomy" CHAR(1) DEFAULT 'N'::bpchar, "last_updated_date" TIMESTAMP WITHOUT TIME ZONE, "add_matchable_description" VARCHAR(4000), "mid_type" VARCHAR(18), "list_entry_type" VARCHAR(50), "list_entry_type_mg" VARCHAR(50), "is_batch_disposed" CHAR(1), "bulk_process_req_id" INTEGER, "rule_engine_id" INTEGER);

-- changeset pg_dump_converter:29-create-table-match_notes
CREATE TABLE "match_notes" ("match_note_id" INTEGER NOT NULL DEFAULT nextval('match_notes_match_note_id_seq'::regclass), "alert_detail_id" INTEGER, "note_text" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "modified_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

-- changeset pg_dump_converter:30-create-table-notes_audit
CREATE TABLE "notes_audit" ("audit_id" INTEGER NOT NULL DEFAULT nextval('notes_audit_audit_id_seq'::regclass), "note_id" INTEGER, "user_id" INTEGER, "action" VARCHAR(255), "details" TEXT, "created_date" TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'::text), "partition_date" TIMESTAMP WITHOUT TIME ZONE NOT NULL);

-- changeset pg_dump_converter:31-create-table-partition_log
CREATE TABLE "partition_log" ("log_id" INTEGER NOT NULL DEFAULT nextval('partition_log_log_id_seq'::regclass), "log_timestamp" TIMESTAMP WITH TIME ZONE DEFAULT now(), "schema_name" TEXT, "table_name" TEXT, "log_level" TEXT, "message" TEXT, "details" TEXT);

-- changeset pg_dump_converter:32-create-table-partition_table_list
CREATE TABLE "partition_table_list" ("id" INTEGER NOT NULL DEFAULT nextval('partition_table_list_id_seq'::regclass), "schema_name" TEXT NOT NULL, "table_name" TEXT NOT NULL, "partition_column" TEXT NOT NULL DEFAULT 'partition_date'::text, "partition_column_type" TEXT NOT NULL DEFAULT 'DATE'::text, "partition_interval" TEXT NOT NULL DEFAULT '1 day'::text, "premake" INTEGER NOT NULL DEFAULT 4, "retention_interval" TEXT, "retention_keep_table" BOOLEAN NOT NULL DEFAULT false, "retention_keep_index" BOOLEAN NOT NULL DEFAULT true, "add_partition_column_if_missing" BOOLEAN NOT NULL DEFAULT false, "create_partition_column_index" BOOLEAN NOT NULL DEFAULT true, "optimize_constraint_exclusion" BOOLEAN NOT NULL DEFAULT true, "inherit_privileges" BOOLEAN NOT NULL DEFAULT true, "job_name" TEXT, "cron_schedule" TEXT DEFAULT '0 1 * * *'::text, "enabled" BOOLEAN NOT NULL DEFAULT true, "last_run_status" TEXT, "last_run_timestamp" TIMESTAMP WITH TIME ZONE, "created_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now());

-- changeset pg_dump_converter:33-create-table-search_config
CREATE TABLE "search_config" ("id" INTEGER NOT NULL DEFAULT nextval('search_config_id_seq'::regclass), "table_name" VARCHAR(100), "column_name" VARCHAR(100), "search_type" VARCHAR(50));

-- changeset pg_dump_converter:34-create-table-user_bu_map
CREATE TABLE "user_bu_map" ("user_identifier" VARCHAR(50) NOT NULL, "bu_identifier" VARCHAR(500) NOT NULL, "created_date" TIMESTAMP WITHOUT TIME ZONE, "created_by" VARCHAR(100));

-- changeset pg_dump_converter:35-add-constraint-alert_attachments_pkey
ALTER TABLE "alert_attachments" ADD CONSTRAINT "alert_attachments_pkey" PRIMARY KEY ("attachment_id");

-- changeset pg_dump_converter:36-add-constraint-alert_audit_pkey
ALTER TABLE "alert_audit" ADD CONSTRAINT "alert_audit_pkey" PRIMARY KEY ("audit_id");

-- changeset pg_dump_converter:37-add-constraint-alert_details_mst_pkey
ALTER TABLE "alert_details_mst" ADD CONSTRAINT "alert_details_mst_pkey" PRIMARY KEY ("alert_detail_id");

-- changeset pg_dump_converter:38-add-constraint-alert_notes_pkey
ALTER TABLE "alert_notes" ADD CONSTRAINT "alert_notes_pkey" PRIMARY KEY ("note_id");

-- changeset pg_dump_converter:39-add-constraint-business_on_boarding_unit_id_fkey
ALTER TABLE "business_on_boarding" ADD CONSTRAINT "business_on_boarding_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "business_units"("unit_id");

-- changeset pg_dump_converter:40-add-constraint-business_on_boarding_user_id_fkey
ALTER TABLE "business_on_boarding" ADD CONSTRAINT "business_on_boarding_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "business_user"("user_id");

-- changeset pg_dump_converter:41-add-constraint-business_on_boarding_pkey
ALTER TABLE "business_on_boarding" ADD CONSTRAINT "business_on_boarding_pkey" PRIMARY KEY ("onboarding_id");

-- changeset pg_dump_converter:42-add-constraint-business_role_pkey
ALTER TABLE "business_role" ADD CONSTRAINT "business_role_pkey" PRIMARY KEY ("role_id");

-- changeset pg_dump_converter:43-add-constraint-business_role_role_name_key
ALTER TABLE "business_role" ADD CONSTRAINT "business_role_role_name_key" UNIQUE ("role_name");

-- changeset pg_dump_converter:44-add-constraint-business_units_pkey
ALTER TABLE "business_units" ADD CONSTRAINT "business_units_pkey" PRIMARY KEY ("unit_id");

-- changeset pg_dump_converter:45-add-constraint-business_user_role_id_fkey
ALTER TABLE "business_user" ADD CONSTRAINT "business_user_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "business_role"("role_id");

-- changeset pg_dump_converter:46-add-constraint-business_user_pkey
ALTER TABLE "business_user" ADD CONSTRAINT "business_user_pkey" PRIMARY KEY ("user_id");

-- changeset pg_dump_converter:47-add-constraint-business_user_username_key
ALTER TABLE "business_user" ADD CONSTRAINT "business_user_username_key" UNIQUE ("username");

-- changeset pg_dump_converter:48-add-constraint-match_notes_alert_detail_id_fkey
ALTER TABLE "match_notes" ADD CONSTRAINT "match_notes_alert_detail_id_fkey" FOREIGN KEY ("alert_detail_id") REFERENCES "alert_details_mst"("alert_detail_id");

-- changeset pg_dump_converter:49-add-constraint-match_notes_pkey
ALTER TABLE "match_notes" ADD CONSTRAINT "match_notes_pkey" PRIMARY KEY ("match_note_id");

-- changeset pg_dump_converter:50-add-constraint-notes_audit_note_id_fkey
ALTER TABLE "notes_audit" ADD CONSTRAINT "notes_audit_note_id_fkey" FOREIGN KEY ("note_id") REFERENCES "alert_notes"("note_id");

-- changeset pg_dump_converter:51-add-constraint-notes_audit_pkey
ALTER TABLE "notes_audit" ADD CONSTRAINT "notes_audit_pkey" PRIMARY KEY ("audit_id");

-- changeset pg_dump_converter:52-add-constraint-partition_log_pkey
ALTER TABLE "partition_log" ADD CONSTRAINT "partition_log_pkey" PRIMARY KEY ("log_id");

-- changeset pg_dump_converter:53-add-constraint-partition_table_list_pkey
ALTER TABLE "partition_table_list" ADD CONSTRAINT "partition_table_list_pkey" PRIMARY KEY ("id");

-- changeset pg_dump_converter:54-add-constraint-partition_table_list_schema_name_table_name_key
ALTER TABLE "partition_table_list" ADD CONSTRAINT "partition_table_list_schema_name_table_name_key" UNIQUE ("table_name");

-- changeset pg_dump_converter:55-add-constraint-partition_table_list_schema_name_table_name_key
ALTER TABLE "partition_table_list" ADD CONSTRAINT "partition_table_list_schema_name_table_name_key" UNIQUE ("table_name");

-- changeset pg_dump_converter:56-add-constraint-partition_table_list_schema_name_table_name_key
ALTER TABLE "partition_table_list" ADD CONSTRAINT "partition_table_list_schema_name_table_name_key" UNIQUE ("schema_name");

-- changeset pg_dump_converter:57-add-constraint-partition_table_list_schema_name_table_name_key
ALTER TABLE "partition_table_list" ADD CONSTRAINT "partition_table_list_schema_name_table_name_key" UNIQUE ("schema_name");

-- changeset pg_dump_converter:58-add-constraint-search_config_pkey
ALTER TABLE "search_config" ADD CONSTRAINT "search_config_pkey" PRIMARY KEY ("id");

-- changeset pg_dump_converter:59-add-constraint-user_bu_map_pk
ALTER TABLE "user_bu_map" ADD CONSTRAINT "user_bu_map_pk" PRIMARY KEY ("bu_identifier");

-- changeset pg_dump_converter:60-add-constraint-user_bu_map_pk
ALTER TABLE "user_bu_map" ADD CONSTRAINT "user_bu_map_pk" PRIMARY KEY ("user_identifier");

-- changeset pg_dump_converter:61-add-constraint-user_bu_map_pk
ALTER TABLE "user_bu_map" ADD CONSTRAINT "user_bu_map_pk" PRIMARY KEY ("bu_identifier");

-- changeset pg_dump_converter:62-add-constraint-user_bu_map_pk
ALTER TABLE "user_bu_map" ADD CONSTRAINT "user_bu_map_pk" PRIMARY KEY ("user_identifier");

-- changeset pg_dump_converter:63-create-index-alert_det_alert_id_idx
CREATE INDEX alert_det_alert_id_idx ON ONLY cads.alert_det USING btree (alert_id);

-- changeset pg_dump_converter:64-sql-statement
CREATE UNIQUE INDEX business_role_role_name_key ON cads.business_role USING btree (role_name);

-- changeset pg_dump_converter:65-sql-statement
CREATE UNIQUE INDEX business_user_username_key ON cads.business_user USING btree (username);

-- changeset pg_dump_converter:66-create-index-idx_partition_log_level
CREATE INDEX idx_partition_log_level ON cads.partition_log USING btree (log_level);

-- changeset pg_dump_converter:67-create-index-idx_partition_log_table
CREATE INDEX idx_partition_log_table ON cads.partition_log USING btree (schema_name, table_name);

-- changeset pg_dump_converter:68-create-index-idx_partition_log_timestamp
CREATE INDEX idx_partition_log_timestamp ON cads.partition_log USING btree (log_timestamp);

-- changeset pg_dump_converter:69-sql-statement
CREATE UNIQUE INDEX partition_table_list_schema_name_table_name_key ON cads.partition_table_list USING btree (schema_name, table_name);

-- changeset pg_dump_converter:70-sql-statement
CREATE UNIQUE INDEX user_bu_map_pk ON cads.user_bu_map USING btree (user_identifier, bu_identifier);

-- changeset pg_dump_converter:71-create-function-automate_search_index_creation
CREATE OR REPLACE FUNCTION cads.automate_search_index_creation()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    r RECORD;

-- changeset pg_dump_converter:72-sql-statement
index_name TEXT;

-- changeset pg_dump_converter:73-sql-statement
sql_command TEXT;

-- changeset pg_dump_converter:74-sql-statement
schema_name TEXT := 'cads';

-- changeset pg_dump_converter:75-sql-statement
BEGIN
    RAISE NOTICE 'Starting index automation process...';

-- changeset pg_dump_converter:76-sql-statement
BEGIN
        CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- changeset pg_dump_converter:77-sql-statement
RAISE NOTICE 'pg_trgm extension ensured.';

-- changeset pg_dump_converter:78-sql-statement
EXCEPTION WHEN duplicate_object THEN
        RAISE NOTICE 'pg_trgm extension already exists.';

-- changeset pg_dump_converter:79-sql-statement
END;

-- changeset pg_dump_converter:80-sql-statement
FOR r IN
        SELECT lower(esf.collection_name) AS table_name,
               lower(esf.field_name) AS column_name,
               lower(esf.field_type) AS column_type,
               esf.regex_enabled
        FROM cads.enhanced_search_fields esf
        JOIN cads.gui_label gl ON esf.gui_identifier = gl.gui_identifier
        WHERE esf.is_active = 'Y'
        
        
    LOOP
        RAISE NOTICE 'Processing table: %, column: %, type: %, regex_enabled: %',
                     quote_ident(r.table_name), quote_ident(r.column_name), r.column_type, r.regex_enabled;

-- changeset pg_dump_converter:81-sql-statement
IF NOT EXISTS (
            SELECT 1 FROM information_schema.columns
            WHERE table_schema = schema_name 
              AND table_name = r.table_name
              AND column_name = r.column_name
        ) THEN
            RAISE WARNING 'Skipping index creation: Table %.% or column % does not exist in schema %.',
                          quote_ident(r.table_name), quote_ident(r.column_name), quote_ident(r.column_name), quote_ident(schema_name);

-- changeset pg_dump_converter:82-sql-statement
CONTINUE;

-- changeset pg_dump_converter:83-sql-statement
END IF;

-- changeset pg_dump_converter:84-sql-statement
IF r.column_type IN ('int', 'date') THEN
            
            index_name := format('idx_btree_%s_%s', r.table_name, r.column_name);

-- changeset pg_dump_converter:85-sql-statement
sql_command := format(
                'CREATE INDEX IF NOT EXISTS %I ON %I.%I (%I);',
                index_name,            
                schema_name,           
                r.table_name,          
                r.column_name          
            );

-- changeset pg_dump_converter:86-sql-statement
RAISE NOTICE 'Executing: %', sql_command;

-- changeset pg_dump_converter:87-sql-statement
EXECUTE sql_command;

-- changeset pg_dump_converter:88-sql-statement
RAISE NOTICE 'B-Tree index % created or already exists.', index_name;

-- changeset pg_dump_converter:89-sql-statement
ELSIF r.column_type IN ('string', 'regex') THEN
             
            index_name := format('idx_gin_trgm_%s_%s', r.table_name, r.column_name);

-- changeset pg_dump_converter:90-sql-statement
sql_command := format(
                'CREATE INDEX IF NOT EXISTS %I ON %I.%I USING GIN (%I gin_trgm_ops);',
                index_name,            
                schema_name,           
                r.table_name,          
                r.column_name          
            );

-- changeset pg_dump_converter:91-sql-statement
RAISE NOTICE 'Executing: %', sql_command;

-- changeset pg_dump_converter:92-sql-statement
EXECUTE sql_command;

-- changeset pg_dump_converter:93-sql-statement
RAISE NOTICE 'GIN (pg_trgm) index % created or already exists.', index_name;

-- changeset pg_dump_converter:94-sql-statement
ELSE
            RAISE WARNING 'Unsupported column_type % for column %.% - No index created.',
                          r.column_type, quote_ident(r.table_name), quote_ident(r.column_name);

-- changeset pg_dump_converter:95-sql-statement
END IF;

-- changeset pg_dump_converter:96-sql-statement
END LOOP;

-- changeset pg_dump_converter:97-sql-statement
RAISE NOTICE 'Index automation process finished.';

-- changeset pg_dump_converter:98-sql-statement
END;

-- changeset pg_dump_converter:99-sql-statement
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

-- changeset pg_dump_converter:100-sql-statement
END;

-- changeset pg_dump_converter:101-sql-statement
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

-- changeset pg_dump_converter:102-sql-statement
END;

-- changeset pg_dump_converter:103-sql-statement
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

-- changeset pg_dump_converter:104-sql-statement
END;

-- changeset pg_dump_converter:105-sql-statement
$function$


CREATE OR REPLACE FUNCTION cads.get_partition_cron_job_status()
 RETURNS TABLE(jobid bigint, schedule text, command text, nodename text, nodeport integer, database text, username text, active boolean, jobname text)
 LANGUAGE plpgsql
AS $function$
DECLARE
    _pg_cron_installed BOOLEAN;

-- changeset pg_dump_converter:106-sql-statement
BEGIN
    SELECT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') INTO _pg_cron_installed;

-- changeset pg_dump_converter:107-sql-statement
IF _pg_cron_installed THEN
        RETURN QUERY SELECT * FROM cron.job WHERE jobname = 'pg_partman_maintenance';

-- changeset pg_dump_converter:108-sql-statement
ELSE
        RAISE NOTICE 'pg_cron extension is not installed.';

-- changeset pg_dump_converter:109-sql-statement
RETURN QUERY SELECT * FROM cron.job WHERE false;

-- changeset pg_dump_converter:110-sql-statement
END IF;

-- changeset pg_dump_converter:111-sql-statement
END;

-- changeset pg_dump_converter:112-sql-statement
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

-- changeset pg_dump_converter:113-sql-statement
END;

-- changeset pg_dump_converter:114-sql-statement
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

-- changeset pg_dump_converter:115-sql-statement
END;

-- changeset pg_dump_converter:116-sql-statement
$function$


CREATE OR REPLACE FUNCTION cads.setup_schema_partitions(p_schema_name text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    _config RECORD;

-- changeset pg_dump_converter:117-sql-statement
_parent_table TEXT;

-- changeset pg_dump_converter:118-sql-statement
_column_exists BOOLEAN;

-- changeset pg_dump_converter:119-sql-statement
_pg_partman_installed BOOLEAN;

-- changeset pg_dump_converter:120-sql-statement
_pg_cron_installed BOOLEAN;

-- changeset pg_dump_converter:121-sql-statement
_is_partitioned BOOLEAN;

-- changeset pg_dump_converter:122-sql-statement
_partition_key TEXT;

-- changeset pg_dump_converter:123-sql-statement
_sql TEXT;

-- changeset pg_dump_converter:124-sql-statement
_job_id BIGINT;

-- changeset pg_dump_converter:125-sql-statement
_job_exists BOOLEAN := FALSE;

-- changeset pg_dump_converter:126-sql-statement
_cron_schedule TEXT;

-- changeset pg_dump_converter:127-sql-statement
_maintenance_job_name TEXT := 'pg_partman_maintenance';

-- changeset pg_dump_converter:128-sql-statement
BEGIN
    RAISE NOTICE '

    
    SELECT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_partman') INTO _pg_partman_installed;
    IF NOT _pg_partman_installed THEN
        INSERT INTO cads.partition_log (log_level, message, details) VALUES ('ERROR', 'pg_partman extension not installed.', 'Install with CREATE EXTENSION pg_partman;

-- changeset pg_dump_converter:129-sql-statement
');
        RAISE EXCEPTION 'pg_partman extension is not installed. Aborting. Install with CREATE EXTENSION pg_partman;

-- changeset pg_dump_converter:130-sql-statement
';
    END IF;
    RAISE NOTICE 'CHECK: pg_partman extension found.';

    SELECT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') INTO _pg_cron_installed;
    IF NOT _pg_cron_installed THEN
        INSERT INTO cads.partition_log (log_level, message, details) VALUES ('WARNING', 'pg_cron extension not installed.', 'Automatic scheduling via pg_cron will not be configured.');
        RAISE WARNING 'pg_cron extension not installed. Automatic scheduling will not be configured.';
        
    ELSE
        RAISE NOTICE 'CHECK: pg_cron extension found.';
    END IF;

    
    FOR _config IN
        SELECT * FROM cads.partition_table_list
        WHERE schema_name = p_schema_name AND enabled = true
        ORDER BY table_name 
    LOOP
        _parent_table := format('%I.%I', _config.schema_name, _config.table_name);
        RAISE NOTICE 'Processing table: %', _parent_table;
        INSERT INTO cads.partition_log (schema_name, table_name, log_level, message)
            VALUES (_config.schema_name, _config.table_name, 'INFO', 'Starting processing for table ' || _parent_table);

        BEGIN 

            
            IF NOT EXISTS (
                SELECT 1 FROM information_schema.tables
                WHERE table_schema = _config.schema_name AND table_name = _config.table_name
            ) THEN
                RAISE WARNING 'Table % not found. Skipping.', _parent_table;
                INSERT INTO cads.partition_log (schema_name, table_name, log_level, message)
                    VALUES (_config.schema_name, _config.table_name, 'WARNING', 'Table not found. Skipping.');
                UPDATE cads.partition_table_list SET last_run_status = 'ERROR: Table not found', last_run_timestamp = now()
                    WHERE id = _config.id;
                CONTINUE; 
            END IF;

            
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

                    _sql := format('ALTER TABLE %I.%I ADD COLUMN %I %s DEFAULT NULL;

-- changeset pg_dump_converter:131-sql-statement
',
                                   _config.schema_name, _config.table_name, _config.partition_column, _config.partition_column_type);
                    RAISE NOTICE 'Executing: %', _sql;
                    EXECUTE _sql;

                    IF _config.create_partition_column_index THEN
                         _sql := format('CREATE INDEX IF NOT EXISTS idx_%s_%s ON %I.%I(%I);

-- changeset pg_dump_converter:132-sql-statement
',
                                       _config.table_name, _config.partition_column, _config.schema_name, _config.table_name, _config.partition_column);
                         RAISE NOTICE 'Executing: %', _sql;
                         EXECUTE _sql;
                         INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                            VALUES (_config.schema_name, _config.table_name, 'INFO', 'Index created on partition column.', format('Column: %s', _config.partition_column));
                    END IF;
                     
                     _column_exists := TRUE;
                ELSE
                    RAISE WARNING '[%] Partition column "%" is missing. Manual intervention required (add column and backfill data) or set add_partition_column_if_missing=true.',
                        _parent_table, _config.partition_column;
                    INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                        VALUES (_config.schema_name, _config.table_name, 'ERROR', 'Partition column missing. Manual intervention required.', format('Column: %s', _config.partition_column));
                    UPDATE cads.partition_table_list SET last_run_status = format('ERROR: Partition column %s missing', _config.partition_column), last_run_timestamp = now()
                        WHERE id = _config.id;
                    CONTINUE; 
                END IF;
            ELSE
                 RAISE NOTICE '[%] Partition column "%" exists.', _parent_table, _config.partition_column;
                 
                 IF _config.create_partition_column_index AND NOT EXISTS (
                     SELECT 1
                     FROM pg_index idx
                     JOIN pg_class t ON t.oid = idx.indrelid
                     JOIN pg_attribute a ON a.attrelid = t.oid AND a.attname = _config.partition_column AND a.attnum = ANY(idx.indkey) 
                     JOIN pg_class i ON i.oid = idx.indexrelid
                     JOIN pg_namespace n ON n.oid = t.relnamespace
                     WHERE n.nspname = _config.schema_name
                       AND t.relname = _config.table_name
                       AND i.relname LIKE 'idx_%'  
                 ) THEN
                     _sql := format('CREATE INDEX IF NOT EXISTS idx_%s_%s ON %I.%I(%I);

-- changeset pg_dump_converter:133-sql-statement
',
                                    _config.table_name, _config.partition_column, _config.schema_name, _config.table_name, _config.partition_column);
                     RAISE NOTICE '[%] Creating missing index on partition column: %', _parent_table, _sql;
                     EXECUTE _sql;
                     INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                        VALUES (_config.schema_name, _config.table_name, 'INFO', 'Creating missing index on existing partition column.', format('Column: %s', _config.partition_column));
                 END IF;
            END IF; 

            
            SELECT p.partstrat IS NOT NULL, a.attname
            INTO _is_partitioned, _partition_key
            FROM pg_class c
            JOIN pg_namespace n ON n.oid = c.relnamespace
            LEFT JOIN pg_partitioned_table p ON p.partrelid = c.oid
            LEFT JOIN pg_attribute a ON a.attrelid = c.oid AND a.attnum = ANY(p.partattrs)
            WHERE n.nspname = _config.schema_name AND c.relname = _config.table_name AND c.relkind IN ('p', 'r'); 

            IF _is_partitioned AND _partition_key IS DISTINCT FROM _config.partition_column THEN
                 RAISE WARNING '[%] Table is already partitioned by "%", but config expects "%". Skipping pg_partman setup.',
                     _parent_table, _partition_key, _config.partition_column;
                 INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                     VALUES (_config.schema_name, _config.table_name, 'ERROR', 'Table partitioned by wrong column.', format('Expected: %s, Found: %s', _config.partition_column, _partition_key));
                 UPDATE cads.partition_table_list SET last_run_status = format('ERROR: Partitioned by wrong column (%s)', _partition_key), last_run_timestamp = now()
                     WHERE id = _config.id;
                 CONTINUE; 
            END IF;

            
            
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
                    _config.partition_column, _config.schema_name, _config.table_name, 
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

            
            IF _config.retention_interval IS NOT NULL THEN
                RAISE NOTICE '[%] Setting retention policy: interval=%, keep_table=%, keep_index=%',
                             _parent_table, _config.retention_interval, _config.retention_keep_table, _config.retention_keep_index;
                UPDATE partman.part_config
                   SET retention = _config.retention_interval,
                       retention_keep_table = _config.retention_keep_table,
                       retention_keep_index = _config.retention_keep_index,
                       infinite_time_partitions = true 
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

             
            UPDATE cads.partition_table_list SET last_run_status = 'SUCCESS', last_run_timestamp = now()
                WHERE id = _config.id;
            RAISE NOTICE '[%] Successfully processed.', _parent_table;

        EXCEPTION WHEN OTHERS THEN
            
            RAISE WARNING '[%] ERROR during processing: % (%)', _parent_table, SQLERRM, SQLSTATE;
            INSERT INTO cads.partition_log (schema_name, table_name, log_level, message, details)
                VALUES (_config.schema_name, _config.table_name, 'ERROR', SQLERRM, format('SQLSTATE: %s', SQLSTATE));
            UPDATE cads.partition_table_list SET last_run_status = format('ERROR: %s', SQLERRM), last_run_timestamp = now()
                WHERE id = _config.id;
            
        END; 

    END LOOP; 

    
    IF _pg_cron_installed THEN
        
        SELECT cron_schedule INTO _cron_schedule
        FROM cads.partition_table_list
        WHERE enabled = true AND schema_name = p_schema_name AND cron_schedule IS NOT NULL
        ORDER BY id
        LIMIT 1;

        _cron_schedule := COALESCE(_cron_schedule, '0 2 * * *'); 

        
        SELECT EXISTS (SELECT 1 FROM cron.job WHERE jobname = _maintenance_job_name) INTO _job_exists;

        IF NOT _job_exists THEN
            RAISE NOTICE 'Setting up pg_cron job "%" with schedule "%" to run partman.run_maintenance_proc().', _maintenance_job_name, _cron_schedule;
            _sql := format('SELECT cron.schedule(%L, %L, %L)',
                            _maintenance_job_name,
                            _cron_schedule,
                            'SELECT partman.run_maintenance_proc();

-- changeset pg_dump_converter:134-sql-statement
');
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
            RAISE NOTICE 'pg_cron job "%" already exists. Ensure schedule is appropriate. Current schedule can be checked via SELECT schedule FROM cron.job WHERE jobname = %L;

-- changeset pg_dump_converter:135-sql-statement
', _maintenance_job_name, _maintenance_job_name;
            
            
            
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
    END IF; 

    RAISE NOTICE '

END;

-- changeset pg_dump_converter:136-sql-statement
$function$


CREATE OR REPLACE PROCEDURE cads.unpartition_all_cads_tables()
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    parent_rec RECORD;

-- changeset pg_dump_converter:137-sql-statement
child_rec RECORD;

-- changeset pg_dump_converter:138-sql-statement
temp_table_name TEXT;

-- changeset pg_dump_converter:139-sql-statement
original_table_schema TEXT := 'cads';

-- changeset pg_dump_converter:140-sql-statement
quoted_parent_table TEXT;

-- changeset pg_dump_converter:141-sql-statement
quoted_temp_table TEXT;

-- changeset pg_dump_converter:142-sql-statement
parent_oid oid;

-- changeset pg_dump_converter:143-sql-statement
child_drop_commands TEXT[];

-- changeset pg_dump_converter:144-sql-statement
child_drop_cmd TEXT;

-- changeset pg_dump_converter:145-sql-statement
BEGIN
    RAISE NOTICE '

    
    FOR parent_rec IN
        SELECT
            c.oid,
            n.nspname AS schema_name,
            c.relname AS table_name
        FROM pg_catalog.pg_class c
        JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
        WHERE n.nspname = original_table_schema
          AND c.relkind = 'p' 
    LOOP
        parent_oid := parent_rec.oid;
        quoted_parent_table := pg_catalog.quote_ident(parent_rec.schema_name) || '.' || pg_catalog.quote_ident(parent_rec.table_name);

        RAISE NOTICE 'Processing table: %', quoted_parent_table;

        
        IF EXISTS (SELECT 1 FROM pg_catalog.pg_inherits WHERE inhparent = parent_oid) THEN

            
            temp_table_name := parent_rec.table_name || '_unpartitioned_temp_' || md5(random()::text);
            quoted_temp_table := pg_catalog.quote_ident(parent_rec.schema_name) || '.' || pg_catalog.quote_ident(temp_table_name);

            RAISE NOTICE 'Consolidating data from % into temporary table %...', quoted_parent_table, quoted_temp_table;
            BEGIN 

                
                RAISE NOTICE 'Creating temporary table %s and copying data...', quoted_temp_table;
                EXECUTE format('CREATE TABLE %s AS SELECT * FROM %s', quoted_temp_table, quoted_parent_table);
                RAISE NOTICE 'Data consolidation complete for %s.', quoted_parent_table;

                
                RAISE NOTICE 'Detaching partitions from %s...', quoted_parent_table;
                child_drop_commands := '{}'; 
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
                    
                    child_drop_commands := array_append(child_drop_commands, format('DROP TABLE %s.%s;

-- changeset pg_dump_converter:146-sql-statement
',
                                                                   pg_catalog.quote_ident(child_rec.partition_schema),
                                                                   pg_catalog.quote_ident(child_rec.partition_name)));
                END LOOP;
                RAISE NOTICE 'All partitions detached for %s.', quoted_parent_table;

                
                RAISE NOTICE 'Dropping the original partitioned table %s...', quoted_parent_table;
                EXECUTE format('DROP TABLE %s', quoted_parent_table);
                RAISE NOTICE 'Original partitioned table %s dropped.', quoted_parent_table; 

                
                RAISE NOTICE 'Renaming %s to %.%...', quoted_temp_table, parent_rec.schema_name, parent_rec.table_name;
                EXECUTE format('ALTER TABLE %s RENAME TO %I', quoted_temp_table, parent_rec.table_name);
                RAISE NOTICE 'Table %.% unpartitioning core steps finished.', parent_rec.schema_name, parent_rec.table_name;

                
                
                RAISE NOTICE '*** IMPORTANT for %s: This procedure did NOT recreate indexes, constraints (PK, FK, UNIQUE, CHECK), defaults, triggers, permissions, or comments.', quoted_parent_table;
                RAISE NOTICE '*** You MUST manually recreate these objects on the new %s table.', quoted_parent_table;
                
                RAISE NOTICE '*** The following DROP TABLE commands for detached partitions were collected:';
                FOREACH child_drop_cmd IN ARRAY child_drop_commands LOOP
                    RAISE NOTICE '    %s', child_drop_cmd; 
                END LOOP;
                RAISE NOTICE '*** Execute these commands to drop the old partition tables.';


            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Error processing table %s: %', quoted_parent_table, SQLERRM;
                    
                    
                    
                    
            END; 
        ELSE
             RAISE NOTICE 'Table %s is marked as partitioned but has no attached partitions. Skipping.', quoted_parent_table;
        END IF;

    END LOOP; 

    RAISE NOTICE '
    RAISE NOTICE 'Remember to perform manual post-processing steps for all tables processed (recreate objects, drop detached partitions).';

-- changeset pg_dump_converter:147-sql-statement
END;

-- changeset pg_dump_converter:148-sql-statement
$procedure$



















INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'ID', 'int', 1, 'enhsearch_alert_id', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'Y', 'alert_mst', 'N');

-- changeset pg_dump_converter:149-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'SOURCE_SYSTEM', 'string', 2, 'enhsearch_application_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'N');

-- changeset pg_dump_converter:150-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'OWNER', 'string', 3, 'enhsearch_assigned_to', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'Y', 'alert_mst', 'N');

-- changeset pg_dump_converter:151-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'OWNER_GROUP', 'string', 4, 'enhsearch_assigned_to_group', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'Y', 'alert_mst', 'N');

-- changeset pg_dump_converter:152-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'CREATED_DATE', 'date', 5, 'enhsearch_creation_date/time', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'Y', 'alert_mst', 'N');

-- changeset pg_dump_converter:153-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'DUE_TIME', 'string', 6, 'enhsearch_cut_off_time', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'Y');

-- changeset pg_dump_converter:154-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'INQUIRY_TYPE', 'string', 7, 'enhsearch_inquiry_type', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'N');

-- changeset pg_dump_converter:155-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'RULE_SET', 'string', 8, 'enhsearch_ruleset', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'N');

-- changeset pg_dump_converter:156-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'STEP_IDENTIFIER', 'string', 9, 'enhsearch_current_alert_step', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'Y');

-- changeset pg_dump_converter:157-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'SUB_STEP_IDENTIFIER', 'string', 10, 'enhsearch_current_alert_sub_step', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_mst', 'N');

-- changeset pg_dump_converter:158-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Alert Details', 'PP_MESSAGE', 'string', 11, 'enhsearch_transaction_message', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_cstm_attribute', 'N');

-- changeset pg_dump_converter:159-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'BENEFICIARY_CUSTOMER_NAME_ADDRESS_59', 'string', 1, 'enhsearch_59_beneficiary_customer_name_address', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:160-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'ENRICH_BENEFICIARY_CUST_NAME_ADDR_59', 'string', 2, 'enhsearch_59_enrich_beneficiary_customer_name_address', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:161-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'BENEFICIARY', 'string', 3, 'enhsearch_beneficiary', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:162-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'BENEFICIARY_NAME', 'string', 4, 'enhsearch_beneficiary_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:163-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'CDTR_NAME', 'string', 5, 'enhsearch_cdtr_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:164-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'CREDITOR_NAME', 'string', 6, 'enhsearch_creditor_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:165-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'ENRICH_CREDITOR_NAME', 'string', 7, 'enhsearch_enrich_creditor_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:166-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'ENRICH_CREDITOR_NAME_ADDR', 'string', 8, 'enhsearch_enrich_creditor_name_address', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:167-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'ORIGINAL_CREDITOR_NAME', 'string', 9, 'enhsearch_original_creditor_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:168-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'ORIGINAL_CREDITOR_NAME_ADDR', 'string', 10, 'enhsearch_original_creditor_name_address', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:169-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'SEQB_BENEFICIARY_CUST_NAME_ADDR', 'string', 11, 'enhsearch_seq_b_59_beneficiary_customer_name_address', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:170-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY', 'SEQB_ENRICH_BENEFICIARY_CUST_NAME_ADDR', 'string', 12, 'enhsearch_seq_b_59_enrich_beneficiary_customer_nm_addr', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:171-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY ACCOUNT', 'BENEFICIARY_ACCOUNT_ID', 'string', 1, 'enhsearch_beneficiary_account_id', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:172-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY ACCOUNT', 'BENEFICIARY_ACCOUNT_NUMBER', 'string', 2, 'enhsearch_beneficiary_account_number', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:173-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY ACCOUNT', 'CDTR_ACCOUNT_IBAN', 'string', 3, 'enhsearch_cdtr_account_iban', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:174-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('BENEFICIARY ACCOUNT', 'CREDITOR_ACCOUNT_IBAN', 'string', 4, 'enhsearch_creditor_account_iban', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'alert_det', 'N');

-- changeset pg_dump_converter:175-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'COVERAGE_AREA', 'string', 1, 'enhsearch_coverage_area', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');

-- changeset pg_dump_converter:176-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'DEFAULT_TAXONOMY', 'string', 2, 'enhsearch_default_taxonomy', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');

-- changeset pg_dump_converter:177-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'CATEGORY', 'string', 3, 'enhsearch_list_name', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');

-- changeset pg_dump_converter:178-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'HIT_PERCENTAGE', 'string', 4, 'enhsearch_match_accuracy', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');

-- changeset pg_dump_converter:179-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'HIT_NUMBER', 'string', 5, 'enhsearch_match_number', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');

-- changeset pg_dump_converter:180-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'MATCH_ON', 'string', 6, 'enhsearch_match_on', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');

-- changeset pg_dump_converter:181-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'MATCH_PATTERN_VALUE', 'string', 7, 'enhsearch_match_pattern', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');

-- changeset pg_dump_converter:182-insert-data-enhanced_search_fields
INSERT INTO "enhanced_search_fields" ("field_group", "field_name", "field_type", "display_order", "gui_identifier", "created_by", "created_date", "updated_by", "updated_date", "is_active", "partition_date", "is_sortable", "collection_name", "regex_enabled") VALUES ('Match Details', 'MATCH_TEXT', 'string', 8, 'enhsearch_match_text', 'system', '2025-04-09', 'system', '2025-04-09', 'Y', NULL, 'N', 'hit_match_detail', 'N');

-- changeset pg_dump_converter:183-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_alert_id', 'default', 'Alert ID', 'en');

-- changeset pg_dump_converter:184-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_application_name', 'default', 'Application', 'en');

-- changeset pg_dump_converter:185-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_assigned_to', 'default', 'Assigned To', 'en');

-- changeset pg_dump_converter:186-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_assigned_to_group', 'default', 'Assigned To Group', 'en');

-- changeset pg_dump_converter:187-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_creation_date/time', 'default', 'Creation Date/Time', 'en');

-- changeset pg_dump_converter:188-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_cut_off_time', 'default', 'Cut off Time', 'en');

-- changeset pg_dump_converter:189-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_inquiry_type', 'default', 'Inquiry Type', 'en');

-- changeset pg_dump_converter:190-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_ruleset', 'default', 'Ruleset', 'en');

-- changeset pg_dump_converter:191-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_current_alert_step', 'default', 'Step', 'en');

-- changeset pg_dump_converter:192-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_current_alert_sub_step', 'default', 'Sub Step', 'en');

-- changeset pg_dump_converter:193-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_transaction_message', 'default', 'Transaction Message', 'en');

-- changeset pg_dump_converter:194-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_59_beneficiary_customer_name_address', 'default', '59: Beneficiary Customer Name & Address', 'en');

-- changeset pg_dump_converter:195-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_59_enrich_beneficiary_customer_name_address', 'default', '59: Enrich Beneficiary Customer Name & Address', 'en');

-- changeset pg_dump_converter:196-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_beneficiary', 'default', 'Beneficiary', 'en');

-- changeset pg_dump_converter:197-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_beneficiary_name', 'default', 'Beneficiary Name', 'en');

-- changeset pg_dump_converter:198-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_cdtr_name', 'default', 'Cdtr Name', 'en');

-- changeset pg_dump_converter:199-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_creditor_name', 'default', 'Creditor Name', 'en');

-- changeset pg_dump_converter:200-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_enrich_creditor_name', 'default', 'Enrich Creditor Name', 'en');

-- changeset pg_dump_converter:201-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_enrich_creditor_name_address', 'default', 'Enrich Creditor Name & Address', 'en');

-- changeset pg_dump_converter:202-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_original_creditor_name', 'default', 'Original Creditor Name', 'en');

-- changeset pg_dump_converter:203-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_original_creditor_name_address', 'default', 'Original Creditor Name & Address', 'en');

-- changeset pg_dump_converter:204-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_seq_b_59_beneficiary_customer_name_address', 'default', 'Seq B - 59: Beneficiary Customer Name & Address', 'en');

-- changeset pg_dump_converter:205-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_seq_b_59_enrich_beneficiary_customer_nm_addr', 'default', 'Seq B - 59: Enrich Beneficiary Customer Nm & Addr', 'en');

-- changeset pg_dump_converter:206-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_beneficiary_account_id', 'default', 'Beneficiary Account Id', 'en');

-- changeset pg_dump_converter:207-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_beneficiary_account_number', 'default', 'Beneficiary Account Number', 'en');

-- changeset pg_dump_converter:208-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_cdtr_account_iban', 'default', 'Cdtr Account IBAN', 'en');

-- changeset pg_dump_converter:209-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_creditor_account_iban', 'default', 'Creditor Account IBAN', 'en');

-- changeset pg_dump_converter:210-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_coverage_area', 'default', 'Coverage Area', 'en');

-- changeset pg_dump_converter:211-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_default_taxonomy', 'default', 'Default Taxonomy', 'en');

-- changeset pg_dump_converter:212-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_list_name', 'default', 'List Name', 'en');

-- changeset pg_dump_converter:213-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_match_accuracy', 'default', 'Match Accuracy %', 'en');

-- changeset pg_dump_converter:214-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_match_number', 'default', 'Match Number', 'en');

-- changeset pg_dump_converter:215-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_match_on', 'default', 'Match On', 'en');

-- changeset pg_dump_converter:216-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_match_pattern', 'default', 'Match Pattern', 'en');

-- changeset pg_dump_converter:217-insert-data-gui_label
INSERT INTO "gui_label" ("gui_identifier", "role_identifier", "label", "user_language") VALUES ('enhsearch_match_text', 'default', 'Match Text', 'en');

-- changeset pg_dump_converter:218-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (311, '2025-04-04 06:13:05.777886', NULL, NULL, 'WARNING', 'pg_cron extension not installed.', 'Automatic scheduling via pg_cron will not be configured.');

-- changeset pg_dump_converter:219-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (312, '2025-04-04 06:13:05.777886', 'cads', 'alert_attachments', 'INFO', 'Starting processing for table cads.alert_attachments', NULL);

-- changeset pg_dump_converter:220-insert-data-partition_log
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

-- changeset pg_dump_converter:221-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (315, '2025-04-04 06:13:05.777886', 'cads', 'alert_audit', 'INFO', 'Starting processing for table cads.alert_audit', NULL);

-- changeset pg_dump_converter:222-insert-data-partition_log
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

-- changeset pg_dump_converter:223-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (318, '2025-04-04 06:13:05.777886', 'cads', 'alert_details_mst', 'INFO', 'Starting processing for table cads.alert_details_mst', NULL);

-- changeset pg_dump_converter:224-insert-data-partition_log
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

-- changeset pg_dump_converter:225-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (321, '2025-04-04 06:13:05.777886', 'cads', 'alert_mst', 'INFO', 'Starting processing for table cads.alert_mst', NULL);

-- changeset pg_dump_converter:226-insert-data-partition_log
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

-- changeset pg_dump_converter:227-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (323, '2025-04-04 06:13:05.777886', 'cads', 'alert_notes', 'INFO', 'Starting processing for table cads.alert_notes', NULL);

-- changeset pg_dump_converter:228-insert-data-partition_log
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

-- changeset pg_dump_converter:229-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (326, '2025-04-04 06:13:05.777886', 'cads', 'business_on_boarding', 'INFO', 'Starting processing for table cads.business_on_boarding', NULL);

-- changeset pg_dump_converter:230-insert-data-partition_log
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

-- changeset pg_dump_converter:231-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (329, '2025-04-04 06:13:05.777886', 'cads', 'business_role', 'INFO', 'Starting processing for table cads.business_role', NULL);

-- changeset pg_dump_converter:232-insert-data-partition_log
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

-- changeset pg_dump_converter:233-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (332, '2025-04-04 06:13:05.777886', 'cads', 'business_units', 'INFO', 'Starting processing for table cads.business_units', NULL);

-- changeset pg_dump_converter:234-insert-data-partition_log
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

-- changeset pg_dump_converter:235-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (335, '2025-04-04 06:13:05.777886', 'cads', 'business_user', 'INFO', 'Starting processing for table cads.business_user', NULL);

-- changeset pg_dump_converter:236-insert-data-partition_log
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

-- changeset pg_dump_converter:237-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (338, '2025-04-04 06:13:05.777886', 'cads', 'match_notes', 'INFO', 'Starting processing for table cads.match_notes', NULL);

-- changeset pg_dump_converter:238-insert-data-partition_log
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

-- changeset pg_dump_converter:239-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (341, '2025-04-04 06:13:05.777886', 'cads', 'notes_audit', 'INFO', 'Starting processing for table cads.notes_audit', NULL);

-- changeset pg_dump_converter:240-insert-data-partition_log
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

-- changeset pg_dump_converter:241-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (344, '2025-04-04 06:13:05.777886', NULL, NULL, 'WARNING', 'pg_cron not installed, maintenance job not scheduled.', NULL);

-- changeset pg_dump_converter:242-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (345, '2025-04-18 08:50:30.594704', NULL, NULL, 'WARNING', 'pg_cron extension not installed.', 'Automatic scheduling via pg_cron will not be configured.');

-- changeset pg_dump_converter:243-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (346, '2025-04-18 08:50:30.594704', 'cads', 'alert_attachments', 'INFO', 'Starting processing for table cads.alert_attachments', NULL);

-- changeset pg_dump_converter:244-insert-data-partition_log
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

-- changeset pg_dump_converter:245-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (349, '2025-04-18 08:50:30.594704', 'cads', 'alert_audit', 'INFO', 'Starting processing for table cads.alert_audit', NULL);

-- changeset pg_dump_converter:246-insert-data-partition_log
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

-- changeset pg_dump_converter:247-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (352, '2025-04-18 08:50:30.594704', 'cads', 'alert_details_mst', 'INFO', 'Starting processing for table cads.alert_details_mst', NULL);

-- changeset pg_dump_converter:248-insert-data-partition_log
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

-- changeset pg_dump_converter:249-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (355, '2025-04-18 08:50:30.594704', 'cads', 'alert_mst', 'INFO', 'Starting processing for table cads.alert_mst', NULL);

-- changeset pg_dump_converter:250-insert-data-partition_log
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

-- changeset pg_dump_converter:251-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (358, '2025-04-18 08:50:30.594704', 'cads', 'alert_notes', 'INFO', 'Starting processing for table cads.alert_notes', NULL);

-- changeset pg_dump_converter:252-insert-data-partition_log
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

-- changeset pg_dump_converter:253-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (361, '2025-04-18 08:50:30.594704', 'cads', 'business_on_boarding', 'INFO', 'Starting processing for table cads.business_on_boarding', NULL);

-- changeset pg_dump_converter:254-insert-data-partition_log
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

-- changeset pg_dump_converter:255-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (364, '2025-04-18 08:50:30.594704', 'cads', 'business_role', 'INFO', 'Starting processing for table cads.business_role', NULL);

-- changeset pg_dump_converter:256-insert-data-partition_log
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

-- changeset pg_dump_converter:257-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (367, '2025-04-18 08:50:30.594704', 'cads', 'business_units', 'INFO', 'Starting processing for table cads.business_units', NULL);

-- changeset pg_dump_converter:258-insert-data-partition_log
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

-- changeset pg_dump_converter:259-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (370, '2025-04-18 08:50:30.594704', 'cads', 'business_user', 'INFO', 'Starting processing for table cads.business_user', NULL);

-- changeset pg_dump_converter:260-insert-data-partition_log
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

-- changeset pg_dump_converter:261-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (373, '2025-04-18 08:50:30.594704', 'cads', 'match_notes', 'INFO', 'Starting processing for table cads.match_notes', NULL);

-- changeset pg_dump_converter:262-insert-data-partition_log
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

-- changeset pg_dump_converter:263-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (376, '2025-04-18 08:50:30.594704', 'cads', 'notes_audit', 'INFO', 'Starting processing for table cads.notes_audit', NULL);

-- changeset pg_dump_converter:264-insert-data-partition_log
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

-- changeset pg_dump_converter:265-insert-data-partition_log
INSERT INTO "partition_log" ("log_id", "log_timestamp", "schema_name", "table_name", "log_level", "message", "details") VALUES (379, '2025-04-18 08:50:30.594704', NULL, NULL, 'WARNING', 'pg_cron not installed, maintenance job not scheduled.', NULL);

-- changeset pg_dump_converter:266-insert-data-partition_table_list
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

-- changeset pg_dump_converter:267-insert-data-partition_table_list
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

-- changeset pg_dump_converter:268-insert-data-partition_table_list
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

-- changeset pg_dump_converter:269-insert-data-partition_table_list
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

-- changeset pg_dump_converter:270-insert-data-partition_table_list
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

-- changeset pg_dump_converter:271-insert-data-partition_table_list
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

-- changeset pg_dump_converter:272-insert-data-partition_table_list
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

-- changeset pg_dump_converter:273-insert-data-partition_table_list
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

-- changeset pg_dump_converter:274-insert-data-partition_table_list
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

-- changeset pg_dump_converter:275-insert-data-partition_table_list
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

-- changeset pg_dump_converter:276-insert-data-partition_table_list
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

-- changeset pg_dump_converter:277-insert-data-search_config
INSERT INTO "search_config" ("id", "table_name", "column_name", "search_type") VALUES (1, 'products', 'name', 'LIKE');

-- changeset pg_dump_converter:278-insert-data-search_config
INSERT INTO "search_config" ("id", "table_name", "column_name", "search_type") VALUES (2, 'products', 'description', 'LIKE');

-- changeset pg_dump_converter:279-insert-data-search_config
INSERT INTO "search_config" ("id", "table_name", "column_name", "search_type") VALUES (3, 'products', 'price', 'BETWEEN');

-- changeset pg_dump_converter:280-insert-data-search_config
INSERT INTO "search_config" ("id", "table_name", "column_name", "search_type") VALUES (4, 'products', 'category', 'REGEX');

