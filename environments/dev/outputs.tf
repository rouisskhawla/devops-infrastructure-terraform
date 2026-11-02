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