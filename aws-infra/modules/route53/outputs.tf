output "acm_validation_arn" {
  value = aws_acm_certificate_validation.ecs_project.certificate_arn
}