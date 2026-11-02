provider "kubernetes" {
  config_path    = "~/.kube/dev/config"
  config_context = "dev-admin@dev-cluster"
}

provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/dev/config"
    config_context = "dev-admin@dev-cluster"
  }
}

provider "github" {
  owner = "rouisskhawla"
}