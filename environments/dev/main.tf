provider "kubernetes" {
  config_path    = "~/.kube/dev/config"
  config_context = "dev-admin@dev-cluster"
}

provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/dev/config"
    config_context = "dev-admin@dev-cluster"
  }
}

provider "github" {
  owner = "rouisskhawla"
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

module "ingress" {
  source = "../../modules/ingress"
  namespace = "ingress-nginx"
}

resource "github_actions_secret" "kubeconfig_dev" {
  repository      = "reliable-ci-cd-pipeline"
  secret_name     = "KUBECONFIG_DEV"
  plaintext_value = module.github_actions_sa.kubeconfig
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