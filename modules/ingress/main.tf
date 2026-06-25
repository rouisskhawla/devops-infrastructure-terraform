resource "kubernetes_namespace" "ingress" {
    metadata {
        name = var.namespace
    }
}

resource "helm_release" "nginx_ingress" {
    name = "ingress-nginx"
    repository = "https://kubernetes.github.io/ingress-nginx"
    chart = "ingress-nginx"
    version = var.chart_version
    namespace = kubernetes_namespace.ingress.metadata[0].name
    create_namespace = false

    values = [
        yamlencode({
            controller = {
                hostNetwork = true
                dnsPolicy = "ClusterFirstWithHostNet"
                service = {
                    enabled = true
                    type    = "ClusterIP"
                }
                admissionWebhooks = {
                    enabled = true
                }
            }
        })
    ]
}
