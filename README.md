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

