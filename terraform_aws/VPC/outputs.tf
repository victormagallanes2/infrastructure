output "vpc_id" {
  value       = aws_vpc.main.id
  description = "vpc id"
}
output "vpc_cidr_block" {
  value       = aws_vpc.main.cidr_block
  description = "vpc cidr_block"
}

output "public-eu-west-1a-id" {
  value       = aws_subnet.public-eu-west-1a.id
  description = "public subnet id"
}

output "public-eu-west-1b-id" {
  value       = aws_subnet.public-eu-west-1b.id
  description = "public subnet id"
}

output "private-eu-west-1a-id" {
  value       = aws_subnet.private-eu-west-1a.id
  description = "public subnet id"
}

output "private-eu-west-1b-id" {
  value       = aws_subnet.private-eu-west-1b.id
  description = "public subnet id"
}
