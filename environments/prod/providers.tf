provider "kubernetes" {
  config_path    = "~/.kube/prod/config"
  config_context = "prod-admin@prod-cluster"
}

provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/prod/config"
    config_context = "prod-admin@prod-cluster"
  }
}

provider "github" {
  owner = "rouisskhawla"
}
