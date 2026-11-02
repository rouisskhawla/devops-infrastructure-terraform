variable "cluster_api_server" {
  type        = string
  description = "The API server endpoint of the Kubernetes cluster."
}

variable "cluster_ca_cert" {
  type      = string
  sensitive = true
}

variable "grafana_password" {
  type      = string
  sensitive = true
}