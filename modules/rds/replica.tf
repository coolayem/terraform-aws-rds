locals {
  replica = "${var.rds_instance_identifier}-replica"
}

resource "aws_db_instance" "rdsreplica" {
  count                  = "${var.create_replica ? var.replica_count : 0}"
  identifier             = "${format("${var.rds_instance_identifier}%02d", count.index + 2)}"
  engine                 = "${var.rds_engine_type}"
  instance_class         = "${var.rds_instance_class}"
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  replicate_source_db    = "${aws_db_instance.rds.id}"
  skip_final_snapshot    = "${var.replica_skip_final_snapshot}"
  tags                   = "${merge(var.tags, map("Name", "${format("${var.rds_instance_identifier}%02d", count.index + 2)}"), map("AZ", element(var.az, count.index)), map("Engine", "${var.rds_engine_type}"))}"
}

resource "aws_route53_record" "rdsreplica_cname" {
  count   = "${var.create_replica ? var.replica_count: 0}"
  zone_id = "${var.private_zone_id}"
  name    = "${format("${local.replica}%02d", count.index + 1)}"
  type    = "CNAME"
  ttl     = "5"
  records = ["${element(aws_db_instance.rdsreplica.*.address, count.index)}"]
}

