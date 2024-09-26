# Your GCP Project ID
gcp_project = ""

# Check available options here: https://cloud.google.com/compute/docs/regions-zones
# Better to choose something close to training backend in AWS eu-west-1 (Ireland)
gcp_region = ""
gcp_zone   = ""

# Use "default", or put your customly created subnet
gcp_subnet_name = ""

# Let's encrypt may decline certificate issue for this domain
# Please doublecheck with the options with your mentor
domain_name = "gcp.xip.playpit.net"

# Check user_name spelling with your mentor
# Just setting name doesn't allow you to start training!
user_name = "John Snow"

# Your secret passsword to the instance
basic_auth_password = "L3tMeG0PleaseWithMySecretPassword"

# Training name can be "k8s" or "docker"
training = "k8s"