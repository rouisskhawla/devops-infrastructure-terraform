resource "helm_release" "flagger" {
  name             = "flagger"
  repository       = "https://flagger.app"
  chart            = "flagger"
  namespace        = "flagger-system"
  create_namespace = true
  version          = "1.38.0"

  set = [
    {
      name  = "metricsServer"
      value = var.prometheus_url
    },
    {
      name  = "meshProvider"
      value = "nginx"
    }
  ]
}