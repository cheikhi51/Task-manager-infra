terraform {
  # Backend local avec path dynamique
  # Le path sera injecté via -backend-config au moment du init
  backend "local" {}

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

variable "kubeconfig_path" {
  type = string
}

variable "namespace" {}
variable "image_tag" {}

# 1. Namespace
resource "kubernetes_namespace_v1" "ns" {
  metadata {
    name = var.namespace
  }
}
