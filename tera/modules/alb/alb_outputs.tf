output "alb_target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}

output "tut_cert_lb_dns_name" {
    value = aws_lb.tut_cert_lb.dns_name
}

output "tut_cert_lb_zone_id" {
    value = aws_lb.tut_cert_lb.zone_id
}