# AWS RDS Terraform module

Terraform module which creates RDS resources on AWS. Module is designed in a way that a single subclassing via source = "modules/rds" with the appropriate config passed is possible.

The module supports the following types of resources

* rds-db-instance
* db-subnet
* db-security-group
* parameter-group
* iam-role (for enhanced-monitoring)
* sns-topic (for rds event subscriptions)
* read-only-replicas


# Usage

#### Sample 1 - RDS Instance with all default configs.

```
module default_rds {
  source                   = "modules/rds"
  rds_instance_identifier  = "db-identifier"
  rds_instance_class       = "${var.rds_instance_class}"
  rds_engine_type          = "postgres"
  rds_engine_version       = "9.6"
  database_name            = "dbtest"
  use_external_param_group = false

  // Pass in values from your network for subnet, az, vpc & private zone
  subnet_id                = ""
  env_name                 = "${var.env_name}"
  aws_region               = "${var.aws_region}"
  tags                     = "${merge(local.tags, var.tags)}"
  az                       = ""
  vpc_id                   = ""
  private_zone_id          = ""
}
```

#### Sample 2 - RDS Instance with custom parameter group, enhanced monitoring enabled & with 1 replica.

```
module custom_rds {
  source                   = "modules/rds"
  rds_instance_identifier  = "db-identifier"
  rds_instance_class       = "${var.rds_instance_class}"
  rds_engine_type          = "postgres"
  rds_engine_version       = "9.6"
  database_name            = "dbname"
  param_group_name         = "dbname-parameter-group"
  param_group_description  = "Parameter group for custom db"
  param_group_family       = "postgres9.6"
  create_monitoring_role   = true
  monitoring_interval      = 60
  rds_allocated_storage    = "${var.rds_allocated_storage}"
  create_replica           = true
  replica_count            = 1
  parameters = [
    {
      name="max_wal_senders"
      value = "25"
      apply_method="pending-reboot"
    },
    {
       name="autovacuum"
       value = "1"
       apply_method="pending-reboot"
    },
    {
       name="autovacuum_max_workers"
       value = "5"
       apply_method="pending-reboot"
    },
    {
       name="autovacuum_freeze_max_age"
       value = "1250000000"
       apply_method="pending-reboot"
    },
    {
       name="autovacuum_multixact_freeze_max_age"
       value = "400000000"
       apply_method="pending-reboot"
    }
   ]
   // Pass in values from your network for subnet, az, vpc & private zone
  subnet_id                = ""
  env_name                 = "${var.env_name}"
  aws_region               = "${var.aws_region}"
  tags                     = "${merge(local.tags, var.tags)}"
  az                       = ""
  vpc_id                   = ""
  private_zone_id          = ""
}
```

