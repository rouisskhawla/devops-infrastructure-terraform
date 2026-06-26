resource "kubernetes_namespace_v1" "ingress" {
    metadata {
        name = var.namespace
    }
}

resource "helm_release" "nginx_ingress" {
    name = "ingress-nginx"
    repository = "https://kubernetes.github.io/ingress-nginx"
    chart = "ingress-nginx"
    version = var.chart_version
    namespace = kubernetes_namespace_v1.ingress.metadata[0].name
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
