# Makefile #

INIT_SCRIPT=./scripts/init.sh
UNIT_SCRIPT=./scripts/unit.sh
DESTROY_SCRIPT=./scripts/destroy.sh
DOCKER_IMAGE=lambda-eventbridge-concurency-tests  # Change this to your desired Docker image name

.PHONY: lint
lint:
	flake8 src tests

.PHONY: init
init:
	@bash $(INIT_SCRIPT)

.PHONY: test
test:
	@bash $(UNIT_SCRIPT)

.PHONY: destroy
destroy:
	@bash $(DESTROY_SCRIPT)

.PHONY: all
all: init test destroy

.PHONY: help
help:
	@echo "Makefile targets:"
	@echo "  init - Run init script"
	@echo "  test - Run unit tests"
	@echo "  destroy - Run destroy script"
	@echo "  docker-build - Build Docker image"
	@echo "  docker-run - Run Docker container"
	@echo "  docker-all - Build and run Docker container"
	@echo "  all - Run all scripts"

.PHONY: terraform-plan terraform-cost

terraform-plan:
	cd zz-IaC/Terraform/AWS && \
	terraform init && \
	terraform plan -out=tfplan.out

terraform-cost: terraform-plan
	cd zz-IaC/Terraform/AWS && \
	infracost breakdown --path . --format json --out-file infracost-base.json && \
	infracost output --path infracost-base.json --format html --out-file latest-cost.html
	open zz-IaC/Terraform/AWS/latest-cost.html

terraform-deploy: terraform-plan
	cd zz-IaC/Terraform/AWS && \
	terraform apply tfplan.out

terraform-destroy:
	cd zz-IaC/Terraform/AWS && \
	terraform destroy

.PHONY: docker-build
docker-build:
	docker build -t $(DOCKER_IMAGE) .

.PHONY: docker-run
docker-run:
	docker run -it --rm $(DOCKER_IMAGE)

docker-copy-requirements:
	docker cp

.PHONY: docker-all
docker-all: docker-build docker-run

##Github, add . commit -m "automated".

.PHONY: git-commit
git-commit:
	git add .
	git commit -m "automated"
