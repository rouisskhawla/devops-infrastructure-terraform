module "namespace" {
  source      = "../../modules/namespace"
  environment = "dev"
}

module "github_actions_sa" {
  source             = "../../modules/github-actions-sa"
  environment        = "dev"
  namespace          = module.namespace.namespace_name
  cluster_api_server = var.cluster_api_server
  cluster_ca_cert    = var.cluster_ca_cert
}

module "ingress" {
  source    = "../../modules/ingress"
  namespace = "ingress-nginx"
}

resource "github_actions_secret" "kubeconfig_dev" {
  repository  = "reliable-ci-cd-pipeline"
  secret_name = "KUBECONFIG_DEV"
  value       = module.github_actions_sa.kubeconfig
}

module "monitoring" {
  source           = "../../modules/monitoring"
  grafana_password = var.grafana_password
}

module "flagger" {
  source         = "../../modules/flagger"
  prometheus_url = module.monitoring.prometheus_url
}