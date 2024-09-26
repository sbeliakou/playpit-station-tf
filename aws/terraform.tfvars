# Check available options here: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html
# Better to choose something close to training backend in AWS eu-west-1 (Ireland)
aws_region            = ""
aws_availability_zone = ""
aws_ec2_sshkey_name   = ""

# Use your customly created VPC
aws_vpc_name = ""

# Let's encrypt may decline certificate issue for this domain
# Please doublecheck with the options with your mentor
domain_name = "aws.xip.playpit.net"

# Check user_name spelling with your mentor
# Just setting name doesn't allow you to start training!
user_name = "John Snow"

# Your secret passsword to the instance
basic_auth_password = "L3tMeG0PleaseWithMySecretPassword"

# Training name can be "k8s" or "docker"
training = "k8s"