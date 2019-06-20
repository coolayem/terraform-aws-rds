variable "rds_instance_class" {
  default = "db.t2.small"
}

variable "rds_instance_count" {
  default = 1
}

variable "rds_engine_type" {
  description = "Database engine type"
}

variable "rds_engine_version" {
  description = "Database engine version"
}

variable "auto_minor_version_upgrade" {
  description = "Allow automated minor version upgrade"
  default     = true
}

variable "allow_major_version_upgrade" {
  description = "Allow major version upgrade"
  default     = false
}

variable "database_name" {
  description = "The name of the database to create"
}

variable "database_user" {
  default = "postgres"
}

variable "database_password" {
  default = ""
}

variable "database_port" {
  default = "5432"
}

variable "db_parameter_group" {
  type        = "map"
  description = "Parameter group used by the DB engine"

  default = {
    postgres = "default.postgres9.6"
    mysql    = "default.mysql5.6"
  }
}

variable "parameter_group_name" {
  description = "Parameter group to use instead of the default"
  default     = ""
}

variable "rds_storage_type" {
  default = "gp2"
}

variable "rds_allocated_storage" {
  default = "128"
}

variable "rds_instance_identifier" {
  description = "Custom name of the instance"
}

variable "rds_vpc_id" {
  description = "VPC to connect to, used for a security group"
  type        = "string"
  default     = ""
}

variable "rds_subnets" {
  description = "List of subnets DB should be available at"
  type        = "list"
  default     = []
}

variable "rds_publicly_accessible" {
  description = "Determines if database is publicly available"
  default     = false
}

variable "skip_final_snapshot" {
  description = "If true, no snapshot will be made before deleting DB"
  default     = false
}

variable "replica_skip_final_snapshot" {
  description = "If true, no snapshot will be made before deleting DB"
  default     = true
}

variable "rds_backup_window" {
  description = "When AWS can run snapshot (UTC)"
  default     = "06:00-10:00"
}

variable "rds_backup_retention_period" {
  type        = "string"
  description = "Backup retention in days"
  default     = 3
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "rds_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' (UTC)"
  default     = "Mon:10:00-Mon:13:00"
}

variable "use_external_param_group" {
  description = "Determines if the RDS instance uses non-default parameter group"
  default     = true
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replica database. Identifier of another Amazon RDS Database to replicate from."
  default     = ""
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group"
  default     = ""
}

#subnet group variables

variable "subnet_group_name" {
  description = "Unique name of the subnet group"
  default     = ""
}

variable "subnet_group_description" {
  default = ""
}

variable "subnet_ids" {
  type        = "list"
  description = "A list of VPC subnet IDs"
  default     = []
}

#parameter group variables

variable "param_group_name" {
  description = "Unique name of the parameter group"
  default     = ""
}

variable "param_group_family" {
  description = "The family of the DB parameter group"
  default     = ""
}

variable "param_group_description" {
  default = ""
}

variable "parameters" {
  description = "A list of DB parameter maps to apply"
  default     = []
}

#replica variables

variable "create_replica" {
  default = false
}

variable "replica_count" {
  default = 0
}

#Enhanced monitoring variables

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the RDS"
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  default     = ""
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
  default     = ""
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  default     = false
}

variable "init_db" {
  description = "True if we need to execute 'init' script for database."
  default     = false
}

variable "cloudwatch_logs_exports" {
  description = "List of log types to be exported to cloudwatch"

  default = ["postgresql", "upgrade"]
}

variable "emails" {
  description = "List of emails to notify about rds event changes"

  default = ["email"]
}
