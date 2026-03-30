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

# 2. ArgoCD Application
resource "kubernetes_manifest" "argocd_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "task-manager-${var.namespace}"
      namespace = "argocd"
    }

    spec = {
      project = "default"

      source = {
        repoURL        = "https://github.com/cheikhi51/Task-Manager-K8s.git"
        targetRevision = "main"
        path           = "overlays/${var.namespace}"
      }

      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = var.namespace
      }

      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
      }
    }
  }
}