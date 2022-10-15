locals {
  region = "southamerica-east1-a"
}

variable "user" {
  type        = string
  description = "Please, enter user to binding permission"
}

variable "kubernetes_name" {
  type        = string
  description = "Enter your GKE cluster name"
}

variable "output" {
  description = "GKE connection string"
  type        = string
  default     = "TO CONNECT TO KUBERNETES: gcloud container clusters get-credentials <KUBERNETES-NAME> --zone southamerica-east1-a --project poc-from-gke"
}

variable "dashboard_endpoint" {
  description = "Dashboard endpoint"
  type        = string
  default     = "TO CONNECT TO DASHBOARD: kubectl get svc -n lab-dashboard | awk '{print $4}'"
}

variable "prometheus_endpoint" {
  description = "Prometheus endpoint"
  type        = string
  default     = "TO CONNECT TO PROMETHEUS: kubectl port-forward $(kubectl get pods -l=app=prometheus -o name -n lab-monitoring | tail -n1) 9090 -n lab-monitoring"
}

variable "grafana_endpoint" {
  description = "Grafana endpoint"
  type        = string
  default     = "TO CONNECT TO GRAFANA: kubectl port-forward $(kubectl get pods -l=app.kubernetes.io/instance=monitor -o name -n lab-monitoring) 3000 -n lab-monitoring"
}

variable "kibana_endpoint" {
  description = "Kibana endpoint"
  type        = string
  default     = "TO CONNECT TO KIBANA: kubectl port-forward $(kubectl get pods -l=app=kibana -o name -n lab-logging) 5601 -n lab-logging"
}

variable "elasticsearch_endpoint" {
  description = "Elasticsearch endpoint"
  type        = string
  default     = "TO CONNECT TO ELASTICSEARCH: kubectl port-forward $(kubectl get pods -l=app=elasticsearch-master -o name -n lab-logging) 9200 -n lab-logging"
}

variable "jaeger_endpoint" {
  description = "Jaeger endpoint"
  type        = string
  default     = "TO CONNECT TO JAEGER: kubectl port-forward $(kubectl get pods -l=app=jaeger -o name -n lab-observability) 16686 -n lab-observability"
}