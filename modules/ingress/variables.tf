variable "namespace" {
  description = "Namespace where ingress-nginx will be installed"
  type        = string
  default     = "ingress-nginx"
}

variable "chart_version" {
  description = "Ingress NGINX Helm chart version"
  type        = string
  default     = "4.13.2"
}