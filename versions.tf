terraform {
    required_version = ">= 1.6"

    required_providers {
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = "~> 2.25"
        }

        helm = {
            source  = "hashicorp/helm"
            version = "~> 2.13"
        }
            
        tls = {
            source  = "hashicorp/tls"
            version = "~> 4.0"
        }

        github = {
            source  = "integrations/github"
            version = "~> 6.0"
        }

    }
}