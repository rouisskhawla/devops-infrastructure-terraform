variable "cluster_api_server" {
  type = string
}

variable "cluster_ca_cert" {
  type      = string
  sensitive = true
}

variable "grafana_password" {
  type      = string
  sensitive = true
  default   = "admin"

}