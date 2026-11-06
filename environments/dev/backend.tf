terraform {
  backend "consul" {
    address = "192.168.56.102:8500"
    scheme  = "http"
    path    = "terraform/dev"
    lock    = true
  }
}