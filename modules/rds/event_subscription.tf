resource "aws_sns_topic" "rds-events" {
  name = "${var.rds_instance_identifier}-events-topic"
}

resource "null_resource" "rds-sns-subscription" {
  depends_on = ["aws_sns_topic.rds-events"]

  triggers = {
    sns_topic_arn = "${aws_sns_topic.rds-events.arn}"
  }

  count = "${length(var.emails)}"

  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${aws_sns_topic.rds-events.arn} --protocol email --notification-endpoint ${element(var.emails, count.index)} --profile ${var.env_name} --region ${var.aws_region}"
  }
}

resource "aws_db_event_subscription" "rds-events-subscription" {
  name      = "${var.rds_instance_identifier}-events-subscription"
  sns_topic = "${aws_sns_topic.rds-events.arn}"

  source_type = "db-instance"
  source_ids = ["${aws_db_instance.rds.*.id}"]
  
  event_categories = [
    "availability",
    "configuration change",
    "deletion",
    "failover",
    "failure",
    "low storage",
    "maintenance",
    "notification",
    "read replica",
    "recovery",
    "restoration",
  ]
}
