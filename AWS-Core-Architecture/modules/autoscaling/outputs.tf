# Output variables

output "ami_amazon_linux_2023" {
  value = data.aws_ami.ami_amazon_linux_2023.id
}