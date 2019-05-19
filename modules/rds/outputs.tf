output "rds_instance_id" {
  value = "${aws_db_instance.rds.*.id}"
}

output "rds_instance_address" {
  value = "${aws_db_instance.rds.*.address}"
}

output "rds_instance_endpoint" {
  value = "${aws_db_instance.rds.*.endpoint}"
}

output "rds_cname" {
  value = "${aws_route53_record.rds_cname.*.fqdn}"
}

output "rds_subnet_group_id" {
  description = "The subnet parameter group id"
  value       = "${aws_db_subnet_group.rds.id}"
}

output "rds_parameter_group_id" {
  description = "The db parameter group id"
  value       = "${ join(",", aws_db_parameter_group.rds_parameter_group.*.id) }"
}

output "rdsreplica_instance_id" {
  value = "${ join(",", aws_db_instance.rdsreplica.*.id) }"
}

output "rdsreplica_instance_address" {
  value = "${ join(",", aws_db_instance.rdsreplica.*.address) }"
}

output "rdsreplica_instance_endpoint" {
  value = "${ join(",", aws_db_instance.rdsreplica.*.endpoint) }"
}

output "rdsreplica_cname" {
  value = "${ join(",", aws_route53_record.rdsreplica_cname.*.fqdn) }"
}

output "rdsiamrole_id" {
  value = "${aws_iam_role.enhanced_monitoring.*.id}"
}
