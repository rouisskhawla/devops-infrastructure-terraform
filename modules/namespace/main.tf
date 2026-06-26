resource "kubernetes_namespace_v1" "env" {
    metadata {
        name = var.environment
        labels = {
            environment = var.environment 
            managed_by = "terraform"
        }
    }
}
