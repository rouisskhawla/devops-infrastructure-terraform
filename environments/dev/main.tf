provider "kubernetes" {
  config_path    = "~/.kube/dev/config"
  config_context = "dev-admin@dev-cluster"
}

variable "cluster_api_server" {
  type = string
}

variable "cluster_ca_cert" {
  type = string
  sensitive = true
}

module "namespace" {
    source = "../../modules/namespace"
    environment = "dev"
}

module "github_actions_sa" {
  source      = "../../modules/github-actions-sa"
  environment = "dev"
  namespace   = module.namespace.namespace_name
  cluster_api_server = var.cluster_api_server
  cluster_ca_cert   = var.cluster_ca_cert
}

output "environment" {
  value = module.github_actions_sa.environment
  description = "The environment."
}

output "namespace_name" {
  value = module.namespace.namespace_name
}

output "github_actions_kubeconfig" {
  value     = module.github_actions_sa.kubeconfig
  sensitive = true
}