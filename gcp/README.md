# Playpit Compute Instance on GCP

## Description
This Terraform code provisions an Playpit environment on a Google Cloud Platform (GCP) Compute Engine instance.

### Provision details:

- Creates a GCP Compute Engine instance with the specified configuration.
- Sets instance name, hostname, and other attributes.
- Configures metadata, including labels, machine type, access rules, and tags.
- Defines instance-specific metadata, such as login credentials, startup script, etc.
- Configures scheduling options for preemptible instances.
- Defines boot disk details, including auto-delete, image, size, and mode.
- Configures network interface details, such as network, subnetwork, and access configuration.
- The startup script installs the Playpit stack, configures SSL with Let's Encrypt and sets Basic AUTH by the provided settings (username/password)

The code incorporates dynamic values through Terraform variables (`variables.tf` and `override.tf`).

To define your stack configuration, the following steps should be done:

1. Create a new file `override.tf` from current `variables.tf` or update `terraform.tfvars`
2. Define your settings corresponding to your GCP project, training specification and set up the proper Student's name, define a password for Basic AUTH
3. Create GCP compute instance with `make up` command
4. Destroy compute instance with `make down` command

The current configuration doesn't cover:

- Network and subnet creation - the existing names should be provided in `override.tf` or `terraform.tfvars` file

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.6.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.11.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.11.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_instance.vm_instance_public](https://registry.terraform.io/providers/hashicorp/google/5.11.0/docs/resources/compute_instance) | resource |
| [random_id.instance_id](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | `""` | no |
| <a name="input_gcp_credentials_file"></a> [gcp\_credentials\_file](#input\_gcp\_credentials\_file) | n/a | `string` | `""` | no |
| <a name="input_gcp_project"></a> [gcp\_project](#input\_gcp\_project) | n/a | `string` | `""` | no |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | n/a | `string` | `""` | no |
| <a name="input_gcp_zone"></a> [gcp\_zone](#input\_gcp\_zone) | n/a | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"c2d-highcpu-4"` | no |
| <a name="input_loglevel"></a> [loglevel](#input\_loglevel) | n/a | `string` | `""` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | n/a | `string` | `""` | no |
| <a name="input_training"></a> [training](#input\_training) | n/a | `string` | `"docker"` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | n/a | `string` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | vpc name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_endpoint"></a> [service\_endpoint](#output\_service\_endpoint) | n/a |
| <a name="output_vm_public_ip"></a> [vm\_public\_ip](#output\_vm\_public\_ip) | n/a |
