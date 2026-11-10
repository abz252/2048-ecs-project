resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.aws_security_group_alb_id]
  subnets            = var.public_subnets_ids
  tags               = var.tags
}

resource "aws_lb_target_group" "ip" {
  name        = var.tg_name
  port        = var.tg_port
  protocol    = var.tg_protocol
  target_type = var.tg_target_type
  vpc_id      = var.vpc_id
  health_check {
    enabled           = true
    healthy_threshold = var.healthy_threshold
    interval          = var.health_check_interval
    matcher           = var.health_check_matcher
    protocol          = var.tg_protocol
    port              = var.tg_port
    path              = var.health_check_path
    timeout           = var.health_check_timeout

  }

}

resource "aws_lb_listener" "game_2048" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  ssl_policy        = var.listener_ssl_policy
  certificate_arn   = var.acm_validation_arn

  default_action {
    type             = var.listener_protocol_type
    target_group_arn = aws_lb_target_group.ip.arn
  }
  tags = var.tags
}



