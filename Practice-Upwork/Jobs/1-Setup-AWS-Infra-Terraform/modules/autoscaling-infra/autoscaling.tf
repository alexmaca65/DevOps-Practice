# Autoscaling and Load Balancing

// Application Load Balancer
resource "aws_lb" "alb" {
  name     = var.alb_name
  internal = false

  load_balancer_type         = "application"
  enable_deletion_protection = false
  security_groups            = [aws_security_group.sg_alb.id]

  subnets = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]

  tags = {
    Name      = var.alb_name
    ManagedBy = var.managed_by
  }
}

// check nginx server config

// ALB Listener
resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.alb.arn

  protocol = "HTTP"
  port     = 80

  default_action {
    type  = "forward"
    order = 10

    target_group_arn = aws_lb_target_group.target_group_alb_http.arn
  }

  tags = {
    Name      = var.alb_listener_tag_name
    ManagedBy = var.managed_by
  }
}

// ALB Listener Rule
resource "aws_lb_listener_rule" "alb_listener_rule_error" {
  listener_arn = aws_lb_listener.alb_listener_http.arn

  priority = 20

  condition {
    path_pattern {
      values = ["/error"]
    }
  }

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not found. Custom Error!"
      status_code  = "404"
    }
  }

  tags = {
    Name      = var.alb_listener_rule_error_tag_name
    ManagedBy = var.managed_by
  }
}

// Security Group
resource "aws_security_group" "sg_alb" {
  name        = var.sg_alb_name
  description = var.sg_alb_description
  vpc_id      = aws_vpc.custom_vpc.id

  tags = {
    Name      = var.sg_alb_name
    ManagedBy = var.managed_by
  }
}

resource "aws_security_group" "sg_lt_webserver" {
  name        = var.sg_lt_webserver_name
  description = var.sg_lt_webserver_description
  vpc_id      = aws_vpc.custom_vpc.id

  tags = {
    Name      = var.sg_lt_webserver_name
    ManagedBy = var.managed_by
  }
}

// Security Group Ingress Rules
resource "aws_vpc_security_group_ingress_rule" "allow_http_traffic_alb" {
  description       = var.sg_ingress_alb_http_description
  security_group_id = aws_security_group.sg_alb.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  tags = {
    Name = var.sg_ingress_alb_http_tag_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_traffic_lt_webserver" {
  description       = var.sg_ingress_lt_http_description
  security_group_id = aws_security_group.sg_lt_webserver.id

  referenced_security_group_id = aws_security_group.sg_alb.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  tags = {
    Name = var.sg_ingress_lt_http_tag_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_traffic_lt_webserver" {
  description       = var.sg_ingress_lt_ssh_description
  security_group_id = aws_security_group.sg_lt_webserver.id

  cidr_ipv4   = var.ssh_allowed_ip
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  tags = {
    Name = var.sg_ingress_lt_ssh_tag_name
  }
}

// AutoScaling Group
resource "aws_autoscaling_group" "autoscaling_webserver" {
  name = var.autoscaling_group_name

  min_size         = 1
  max_size         = 4
  desired_capacity = 2

  health_check_type   = "ELB"
  vpc_zone_identifier = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
  target_group_arns   = [aws_lb_target_group.target_group_alb_http.arn]

  launch_template {
    id      = aws_launch_template.launch_template_webserver.id
    version = "$Latest"
  }
}

// Launch Template
resource "aws_launch_template" "launch_template_webserver" {
  name          = var.launch_template_name
  description   = var.launch_template_description
  image_id      = data.aws_ami.ami_amazon_linux_2023.id
  instance_type = var.ec2_instance_type

  vpc_security_group_ids = [aws_security_group.sg_lt_webserver.id]

  user_data = filebase64("./user-data-scripts/nginx-webserver-ec2-user-data.sh")

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name      = var.launch_template_ec2_webserver_tag_name
      ManagedBy = var.managed_by
    }
  }
}

// Target Group
resource "aws_lb_target_group" "target_group_alb_http" {
  name        = var.target_group_alb_name
  vpc_id      = aws_vpc.custom_vpc.id
  target_type = "instance"
  slow_start  = 30

  port     = 80
  protocol = "HTTP"

  tags = {
    Name      = var.target_group_alb_name
    ManagedBy = var.managed_by
  }
}