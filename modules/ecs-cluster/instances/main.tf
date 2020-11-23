resource "aws_key_pair" "user" {
  key_name   = var.name
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_launch_configuration" "ec2_for_ecs" {
  name_prefix          = "ecs_instances-${terraform.workspace}"
  image_id             = var.image_id != "" ? var.image_id : data.aws_ami.ecs.id
  instance_type        = var.instance_type
  iam_instance_profile = var.instance_profile_arn
  user_data            = data.template_file.user_data.rendered
  security_groups      = var.security_group_ids
  key_name             = aws_key_pair.user.key_name
  associate_public_ip_address = false

  lifecycle {
    create_before_destroy = true
  }
}

