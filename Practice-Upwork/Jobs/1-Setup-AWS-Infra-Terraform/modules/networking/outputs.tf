# Output variables

output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}

output "subnet_ids_map" {
  value = {
    public_subnet_a_id  = aws_subnet.public_subnet_a.id
    public_subnet_b_id  = aws_subnet.public_subnet_b.id
    private_subnet_a_id = aws_subnet.private_subnet_a.id
    private_subnet_b_id = aws_subnet.private_subnet_b.id
  }
}
