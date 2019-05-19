resource "aws_db_parameter_group" "rds_parameter_group" {
  count       = "${var.use_external_param_group ? 1 : 0}"
  name        = "${var.param_group_name}"
  description = "${var.param_group_description}"
  family      = "${var.param_group_family}"

  parameter   = ["${var.parameters}"]
  tags        = "${merge(var.tags, map("Name", "${var.rds_instance_identifier} RDS Parameter Group"), map("AZ", element(var.az, count.index)), map("Engine", "${var.rds_engine_type}"))}"
}
