variable "cluster_api_server" {
  type = string
}

variable "cluster_ca_cert" {
  type      = string
  sensitive = true
}

variable "grafana_password" {
  type        = string
  description = "Grafana admin password"
  sensitive   = true
  default     = "admin"
}