terraform {
  backend "consul" {
    address = "192.168.1.14:8500"
    scheme  = "http"
    path    = "terraform/prod"
    lock    = true
  }
}