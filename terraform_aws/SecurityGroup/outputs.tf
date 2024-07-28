output "ssh-access" {
  value       = aws_security_group.ssh-access.id
  description = "ssh-access_id"
}

output "rds_company" {
  value       = aws_security_group.rds_company.id
  description = "rds_company_id"
}
