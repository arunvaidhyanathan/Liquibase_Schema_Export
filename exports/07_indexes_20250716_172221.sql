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
