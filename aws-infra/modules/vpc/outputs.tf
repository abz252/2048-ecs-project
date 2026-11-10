output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_public1_id" {
  value = aws_subnet.public-1.id
}

output "subnet_public2_id" {
  value = aws_subnet.public-2.id
}

output "subnet_private1_id" {
  value = aws_subnet.private-1.id
}

output "subnet_private2_id" {
  value = aws_subnet.private-2.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}


