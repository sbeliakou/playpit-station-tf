init:
	terraform init --upgrade

plan:
	terraform plan -var myip="$(shell curl -s ifconfig.io)/32" $(shell test -f terraform.tfvars.override && echo "-var-file=terraform.tfvars.override")

up: apply
run: apply
apply: init
	terraform apply -auto-approve -var myip="$(shell curl -s ifconfig.io)/32"

down: destroy
destroy:
	terraform destroy -auto-approve

fmt:
	terraform fmt

doc: fmt
	terraform-docs markdown  ./ > README.md
