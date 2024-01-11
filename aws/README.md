# playpit-station-tf

**EC2 Configuration Details:**
- SPOT Instance, double check price for your region
- c5d.xlarge, Ephemeral Disk for better performance and lower cost

**Provisioning:**

1. Create `override.tf`, define your variables
2. Create EC2 Instance: `make up`
3. Destroy EC2 Instance: `make down`