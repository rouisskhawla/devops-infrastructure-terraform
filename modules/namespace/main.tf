resource "kubernetes_namespace" "env" {
    metadata {
        name = var.environment
        labels = {
            environment = var.environment 
            managed_by = "terraform"
        }
    }
}
