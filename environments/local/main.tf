provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

module "namespace" {
    source = "../../modules/namespace"
    environment = "local"
}

output "namespace_name" {
    description = "namespace created"
    value = module.namespace.namespace_name
}