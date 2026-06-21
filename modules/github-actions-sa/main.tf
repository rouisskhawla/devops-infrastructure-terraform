resource "kubernetes_service_account" "github_actions" {
  metadata {
    name      = "github-actions"
    namespace = var.namespace
  }
}

resource "kubernetes_cluster_role" "deployer" {
  metadata {
    name = "github-actions-${var.environment}-deployer"
  }

  rule {
    api_groups = ["", "apps", "networking.k8s.io"]
    resources  = ["pods", "deployments", "services", "configmaps", "secrets", "ingresses", "namespaces"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

resource "kubernetes_role_binding" "deployer" {
  metadata {
    name      = "github-actions-deployer-binding"
    namespace = var.namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.deployer.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.github_actions.metadata[0].name
    namespace = var.namespace
  }
}

resource "kubernetes_secret" "token" {
  metadata {
    name      = "github-actions-token"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.github_actions.metadata[0].name
    }
  }
  type = "kubernetes.io/service-account-token"
}

locals {
  kubeconfig = yamlencode({
    apiVersion = "v1"
    kind       = "Config"

    clusters = [{
      name = "${var.environment}-cluster"
      cluster = {
        server = var.cluster_api_server
        certificate-authority-data = var.cluster_ca_cert
      }
    }]

    users = [{
      name = "github-actions"
      user = {
        token = kubernetes_secret.token.data["token"]
      }
    }]

    contexts = [{
      name = "github-actions@${var.environment}"
      context = {
        cluster   = "${var.environment}-cluster"
        user      = "github-actions"
        namespace = var.namespace
      }
    }]

    current-context = "github-actions@${var.environment}"
  })
}