resource "aws_security_group" "rds" {
  name        = "${var.rds_instance_identifier}"
  vpc_id      = "${var.vpc_id}"
  description = "RDS Security Group"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.tags, map("Name", "${var.rds_instance_identifier} RDS Security Group"), map("AZ", element(var.az, count.index)), map("Engine", "${var.rds_engine_type}"))}"
}
