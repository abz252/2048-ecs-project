output "aws_lb_alb_id" {
  value = aws_lb.alb.id

}

output "aws_lb_tg_ip_id" {
  value = aws_lb_target_group.ip.id

}

output "aws_lb_listener_2048_id" {
  value = aws_lb_listener.game_2048.id

}

output "aws_lb_dns_name" {
  value = aws_lb.alb.dns_name

}

output "target_group_arn" {
  value = aws_lb_target_group.ip.arn
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.alb.zone_id
}

output "aws_lb_alb_suffix_arn" {
  value = aws_lb.alb.arn_suffix

}