provider "kubernetes" {
  config_path    = "~/.kube/prod/config"
  config_context = "prod-admin@prod-cluster"
}

provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/prod/config"
    config_context = "prod-admin@prod-cluster"
  }
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
    environment = "prod"
}

module "github_actions_sa" {
  source      = "../../modules/github-actions-sa"
  environment = "prod"
  namespace   = module.namespace.namespace_name
  cluster_api_server = var.cluster_api_server
  cluster_ca_cert   = var.cluster_ca_cert
}

module "ingress" {
  source = "../../modules/ingress"
  namespace = "ingress-nginx"
}

output "namespace_name" {
  value = module.namespace.namespace_name
}

output "github_actions_kubeconfig" {
  value     = module.github_actions_sa.kubeconfig
  sensitive = true
}

output "ingress_controller_installation_status" {
  value = module.ingress.installation_status
}