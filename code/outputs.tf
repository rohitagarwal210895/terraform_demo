# Display ELB IP address

output "elb_dns_name" {
  value = aws_elb.Demo-elb.dns_name
}
