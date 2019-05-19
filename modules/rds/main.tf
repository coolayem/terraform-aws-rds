resource "aws_db_instance" "rds" {
  count                           = "${var.rds_instance_count}"
  identifier                      = "${format("${var.rds_instance_identifier}%02d", count.index + 1)}"
  engine                          = "${var.rds_engine_type}"
  engine_version                  = "${var.rds_engine_version}"
  allocated_storage               = "${var.rds_allocated_storage}"
  storage_type                    = "${var.rds_storage_type}"
  instance_class                  = "${var.rds_instance_class}"
  name                            = "${var.database_name}"
  username                        = "${var.database_user}"
  password                        = "${var.database_password}"
  port                            = "${var.database_port}"
  parameter_group_name            = "${var.use_external_param_group ? "${join(",", aws_db_parameter_group.rds_parameter_group.*.id)}" : lookup(var.db_parameter_group, var.rds_engine_type)}"
  allow_major_version_upgrade     = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade      = "${var.auto_minor_version_upgrade}"
  apply_immediately               = "${var.apply_immediately}"
  maintenance_window              = "${var.rds_maintenance_window}"
  publicly_accessible             = "${var.rds_publicly_accessible}"
  monitoring_interval             = "${var.monitoring_interval}"
  monitoring_role_arn             = "${coalesce(var.monitoring_role_arn, join("", aws_iam_role.enhanced_monitoring.*.arn))}"
  replicate_source_db             = "${var.replicate_source_db}"
  skip_final_snapshot             = "${var.skip_final_snapshot}"
  backup_retention_period         = "${var.rds_backup_retention_period}"
  backup_window                   = "${var.rds_backup_window}"
  enabled_cloudwatch_logs_exports = ["${var.cloudwatch_logs_exports}"]
  availability_zone               = "${element(var.az, count.index)}"
  vpc_security_group_ids          = ["${aws_security_group.rds.id}"]
  db_subnet_group_name            = "${aws_db_subnet_group.rds.id}"
  final_snapshot_identifier       = "${format("${var.rds_instance_identifier}%02d", count.index + 1)}-${var.database_name}-${md5(timestamp())}"
  tags                            = "${merge(var.tags, map("Name", "${format("${var.rds_instance_identifier}%02d", count.index + 1)}"), map("AZ", element(var.az, count.index)), map("Engine", "${var.rds_engine_type}"))}"

  // So the password can be changed manually after init
  lifecycle {
    ignore_changes = ["password"]
  }
}

resource "aws_route53_record" "rds_cname" {
  count   = "${var.rds_instance_count}"
  zone_id = "${var.private_zone_id}"
  name    = "${var.rds_instance_identifier}-master"
  type    = "CNAME"
  ttl     = "5"
  records = ["${element(aws_db_instance.rds.*.address, count.index)}"]
}
