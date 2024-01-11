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

wait:
	@while [[ ! "$(shell curl -sL -w '%{http_code}' $(shell terraform output -raw service_endpoint) -o /dev/null)" =~ 200|401 ]]; do \
		curl -sL -w '%{http_code}' $(shell terraform output -raw service_endpoint) -o /dev/null; \
		sleep 5; \
  done && echo "It is up and ready now: $(shell terraform output -raw service_endpoint)"