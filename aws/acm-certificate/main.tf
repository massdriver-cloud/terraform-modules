resource "aws_acm_certificate" "main" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = var.subject_alternative_names
}

data "aws_route53_zone" "lookup" {
  name         = var.domain_name
  private_zone = var.private_zone
}

resource "aws_route53_record" "validation" {
  for_each = { for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => dvo }

  allow_overwrite = true
  name            = each.value.resource_record_name
  records         = [each.value.resource_record_value]
  ttl             = 60
  type            = each.value.resource_record_type
  zone_id         = data.aws_route53_zone.lookup.zone_id
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}
