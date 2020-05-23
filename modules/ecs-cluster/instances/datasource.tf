data "aws_ami" "ecs" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

data "template_file" "user_data" {
  template = file(var.user_data_path)
  vars     = {
     ecs_cluster = var.ecs_cluster
     additional_user_data_script = var.additional_user_data_script
     log_group = var.log_group
     cluster_name = "${var.cluster_name}-${terraform.workspace}"
  }
}