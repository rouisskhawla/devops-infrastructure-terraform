terraform {
  backend "local" {
    path = "../../.tfstate/local/terraform.tfstate"
  }
}