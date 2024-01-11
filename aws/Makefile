init:
	terraform init --upgrade

plan:
	terraform plan -var myip="$(shell curl -s ifconfig.io)/32" -out=/tmp/tfplan

up: apply
run: apply
apply: init
	terraform apply -auto-approve -var myip="$(shell curl -s ifconfig.io)/32" 

down: destroy
destroy:
	terraform destroy -auto-approve

wait:
	@while [[ ! "$(shell curl -sL -w '%{http_code}' $(shell terraform output -raw service_endpoint) -o /dev/null)" =~ 200|401 ]]; do \
		curl -sL -w '%{http_code}' $(shell terraform output -raw service_endpoint) -o /dev/null; \
		sleep 5; \
  done && echo "It is up and ready now: $(shell terraform output -raw service_endpoint)"

ssh:
	ssh -o StrictHostKeyChecking=no -i ~/.ssh/aws-sbeliakou.pem ubuntu@$(shell terraform output -raw ec2_public_ip)

logs:
	ssh -o StrictHostKeyChecking=no -i ~/.ssh/aws-sbeliakou.pem ubuntu@$(shell terraform output -raw ec2_public_ip) tail -f /var/log/cloud-init-output.log
