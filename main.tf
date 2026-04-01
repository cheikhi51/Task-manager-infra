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
