# Paths and other constants
INIT_SCRIPT       := ./scripts/init.sh
UNIT_SCRIPT       := ./scripts/unit.sh
DESTROY_SCRIPT    := ./scripts/destroy.sh
TERRAFORM_DIR     := zz-IaC/Terraform/AWS
DOCKER_IMAGE      := lambda-eventbridge-concurency-tests  # Change this to your desired Docker image name

# General targets
.PHONY: all lint init test destroy help
all: init test destroy
lint:
	flake8 src tests
init:
	@bash $(INIT_SCRIPT)
test:
	@bash $(UNIT_SCRIPT)
destroy:
	@bash $(DESTROY_SCRIPT)

help:
	@echo "Makefile targets:"
	@echo "  General:"
	@echo "    init         - Run init script"
	@echo "    test         - Run unit tests"
	@echo "    destroy      - Run destroy script"
	@echo "    lint         - Run linters on src and tests"
	@echo "    all          - Run init, test, and destroy scripts"
	@echo "    help         - Display this help message"
	@echo ""
	@echo "  Docker:"
	@echo "    docker-build - Build Docker image"
	@echo "    docker-run   - Run Docker container"
	@echo "    docker-all   - Build and run Docker container"
	@echo ""
	@echo "  Terraform:"
	@echo "    terraform-test    - Run Terraform tests"
	@echo "    terraform-plan    - Plan Terraform changes"
	@echo "    terraform-cost    - Show cost breakdown of Terraform plan"
	@echo "    terraform-deploy  - Apply Terraform changes"
	@echo "    terraform-destroy - Destroy Terraform infrastructure"
	@echo ""
	@echo "  Git:"
	@echo "    git-commit   - Add all changes and commit with a message 'automated'"


# Terraform targets
.PHONY: terraform-test terraform-plan terraform-cost terraform-deploy terraform-destroy
terraform-test:
	cd $(TERRAFORM_DIR)/tests && go test -v
terraform-plan:
	cd $(TERRAFORM_DIR) && terraform init && terraform plan -out=tfplan.out
terraform-cost: terraform-plan
	cd $(TERRAFORM_DIR) && infracost breakdown --path . --format json --out-file infracost-base.json
	cd $(TERRAFORM_DIR) && infracost output --path infracost-base.json --format html --out-file latest-cost.html
	open $(TERRAFORM_DIR)/latest-cost.html
terraform-deploy: terraform-plan
	cd $(TERRAFORM_DIR) && terraform apply tfplan.out
terraform-destroy:
	cd $(TERRAFORM_DIR) && terraform destroy

# Docker targets
.PHONY: docker-build docker-run docker-all docker-copy-requirements
docker-build:
	docker build -t $(DOCKER_IMAGE) .
docker-run:
	docker run -it --rm $(DOCKER_IMAGE)
docker-all: docker-build docker-run
docker-copy-requirements:
	docker cp  # Add your complete `docker cp` command here

# Git target
.PHONY: git-commit
git-commit:
	git add .
	git commit -m "automated"
