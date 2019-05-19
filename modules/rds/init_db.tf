resource null_resource "init_db" {
  count     = "${var.init_db ? 1 : 0}"

  connection {
    host         = "${var.bastion}"
    type         = "ssh"
    user         = "ec2-user"
    private_key  = "${var.ssh_key_rsa}"
  }

  triggers {
    build_number = "${timestamp()}"
  }

  provisioner "file" {
    content = "${data.template_file.init_db_script.rendered}"
    destination = "/tmp/init_db.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/sql"
    ]
  }

  provisioner "file" {
    source = "./modules/rds/sql/${var.database_name}_rds_ddl.sql"
    destination = "/tmp/sql/${var.database_name}_rds_ddl.sql"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 755 /tmp/init_db.sh",
      "sudo /tmp/init_db.sh"
    ]
  }

}

data "template_file" "init_db_script" {
  count    = "${var.init_db ? 1 : 0}"
  template = "${file("${path.module}/init_db.sh")}"
  vars {
    pgpwd = "${var.database_password}"
    host = "${element(concat(aws_db_instance.rds.*.endpoint, list("")), 0)}"
    port = "${var.database_port}"
    db = "${var.database_name}"
    db_ddl = "/tmp/sql/${var.database_name}_rds_ddl.sql"
  }
}
