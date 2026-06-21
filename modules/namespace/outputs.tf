output "namespace_name" {
    description = "namespace created"
    value = kubernetes_namespace.env.metadata[0].name
}