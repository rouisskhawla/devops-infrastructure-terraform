variable "environment" {
  type = string
}

variable "namespace" {
  type = string 
}

variable "cluster_api_server" {
  type = string
}

variable "cluster_ca_cert" {
  type      = string
  sensitive = true
}