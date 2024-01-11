output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "sg_id" {
  value = aws_security_group.playpit_station_access.id
}

output "vpc_id" {
  value = data.aws_vpc.this.id
}

output "subnet_id" {
  value = data.aws_subnets.public.ids[0]
}

output "ec2_public_ip" {
  value = length(aws_spot_instance_request.instance) > 0 ? aws_spot_instance_request.instance[0].public_ip : "unknown"
}

output "service_endpoint" {
  value = length(aws_spot_instance_request.instance) > 0 ? format("https://%s.%s", replace(aws_spot_instance_request.instance[0].public_ip, ".", "-"), var.domain_name) : "unknown"
}