output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "ec2_public_ip" {
  value = aws_spot_instance_request.instance.public_ip
}

output "playpit_instance" {
  value = {
    url      = format("https://%s", local.public_fqdn)
    login    = local.basic_auth_login
    password = local.basic_auth_password
  }
}

output "training" {
  value = var.training
}