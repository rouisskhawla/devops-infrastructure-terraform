output "namespace_name" {
    description = "namespace created"
    value = kubernetes_namespace_v1.env.metadata[0].name
}