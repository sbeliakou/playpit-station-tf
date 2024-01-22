init:
	terraform init --upgrade

plan:
	terraform plan

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
