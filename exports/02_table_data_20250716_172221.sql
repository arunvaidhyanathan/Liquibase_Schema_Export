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


