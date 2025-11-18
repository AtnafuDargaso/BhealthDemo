init:
	@for env in dev staging prod; do \
		cd envs/$$env && terraform init; \
	done

plan:
	@for env in dev staging prod; do \
		cd envs/$$env && terraform plan; \
	done

apply:
	@for env in dev staging prod; do \
		cd envs/$$env && terraform apply -auto-approve; \
	done

clean:
	find . -type d -name ".terraform" -exec rm -rf {} +
	rm -f envs/*/.terraform.lock.hcl
