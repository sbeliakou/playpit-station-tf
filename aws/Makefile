init:
	terraform init --upgrade

plan:
	terraform plan -var myip="$(shell curl -s ifconfig.io)/32" -out=/tmp/tfplan

up: apply
run: apply
apply: init
	terraform apply -auto-approve -var myip="$(shell curl -s ifconfig.io)/32" 

fmt:
	terraform fmt

doc: fmt
	terraform-docs markdown  ./ > README.md

down: destroy
destroy:
	terraform destroy -auto-approve

