output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "ec2_public_ip" {
  value = aws_spot_instance_request.instance.public_ip
}

output "service_endpoint" {
  value = format("https://%s", local.public_fqdn)
}