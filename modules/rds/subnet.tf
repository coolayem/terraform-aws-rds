resource "aws_db_subnet_group" "rds" {
  name        = "${var.rds_instance_identifier}"
  description = "${var.rds_instance_identifier} Subnet Group"
  subnet_ids  = ["${var.subnet_id}"]
  tags        = "${merge(var.tags, map("Name", "${var.rds_instance_identifier} RDS Subnet"), map("AZ", element(var.az, count.index)), map("Engine", "${var.rds_engine_type}"))}"
}
