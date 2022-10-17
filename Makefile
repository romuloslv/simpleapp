all: terraform-login terraform-validation terraform-apply-cluster terraform-apply-pkgs

terraform-login:
	gcloud auth application-default login && gcloud auth application-default set-quota-project $(project_name)
	gcloud auth login && gcloud config set project $(project_name)

terraform-validation:
	terraform init && terraform validate && terraform fmt

terraform-apply-cluster:
	terraform apply -var kubernetes_name=$(cluster_name) \
					-target=google_container_cluster.main \
					-target=google_container_node_pool.general \
					-compact-warnings -auto-approve

terraform-apply-pkgs:
	gcloud container clusters get-credentials $(cluster_name) \
							--zone southamerica-east1-a \
							--project $(project_name)
	terraform apply -var kubernetes_name=$(cluster_name) -auto-approve

terraform-destroy:
	terraform destroy -var kubernetes_name=$(cluster_name) -auto-approve