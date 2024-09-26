init:
	terraform init --upgrade

plan:
	terraform plan $(shell test -f terraform.tfvars.override && echo "-var-file=terraform.tfvars.override")

up: apply
run: apply
apply: init
	terraform apply -auto-approve

down: destroy
destroy:
	terraform destroy -auto-approve

fmt:
	terraform fmt

doc: fmt
	terraform-docs markdown  ./ > README.md
