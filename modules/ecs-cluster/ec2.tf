resource "aws_autoscaling_group" "app" {
  name                = var.name
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = local.subnet_ids

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = var.name
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}

resource "aws_launch_template" "app" {
  name                   = var.name
  instance_type          = "t3a.medium"
  image_id               = data.aws_ami.amazon_linux_ecs.image_id #
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.app.id]

  user_data              = base64encode(templatefile("${path.module}/userdata.sh", {
    CLUSTER = aws_ecs_cluster.app.name,
    BUCKET = aws_s3_bucket.addons.bucket
  }))

  iam_instance_profile {
    arn = aws_iam_instance_profile.app.arn
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_type = "gp3"
      volume_size = var.volume_size
    }
  }
}

resource "aws_security_group" "app" {
  name        = var.name
  description = var.name
  vpc_id      = local.vpc_id

  egress {
    description = "Egress"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
  }
}

data "aws_ami" "amazon_linux_ecs" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-ecs-hvm-2023.*-x86_64"]
  }
}

data "aws_vpcs" "all" {}

data "aws_subnets" "any" {
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
}