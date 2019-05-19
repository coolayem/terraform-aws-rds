resource "aws_iam_role" "enhanced_monitoring" {
  count = "${var.create_monitoring_role ? 1 : 0}"

  name  = "${var.rds_instance_identifier}-monitoring-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "monitoring.rds.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}  
  EOF
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  count = "${var.create_monitoring_role ? 1 : 0}"

  role       = "${aws_iam_role.enhanced_monitoring.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
