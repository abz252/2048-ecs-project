data "aws_route53_zone" "selected" {
  name = var.route53_zone_name
}

resource "aws_route53_record" "ecs_project" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.subdomain}.${data.aws_route53_zone.selected.name}"
  type    = var.record_type

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "ecs_project" {
  domain_name       = "${var.subdomain}.${data.aws_route53_zone.selected.name}"
  validation_method = var.validation_method
}


resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.ecs_project.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.selected.zone_id
}

resource "aws_acm_certificate_validation" "ecs_project" {
  certificate_arn         = aws_acm_certificate.ecs_project.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}

