output "kubeconfig" {
  value     = local.kubeconfig
  sensitive = true
}
output "environment" {
  value = var.environment
}