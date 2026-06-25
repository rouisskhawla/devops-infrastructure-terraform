output "installation_status" {
  value = helm_release.nginx_ingress.status
}