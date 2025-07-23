terraform {
  required_providers {
    k8s = {
      version = ">= 0.8.0"
      source  = "banzaicloud/k8s"
    }
  }
}

provider "kubernetes" {
  config_path = "C:/Users/91850/.kube/config"
}