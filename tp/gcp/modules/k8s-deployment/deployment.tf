variable "metadata_name" {
  type = string
}

variable "label_app" {
  type = string
}

variable "selector_label" {
  type = string
}
variable "template_metadata" {
  type = string
}
variable "container_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}
variable "port_name" {
  type = string
}
variable "replica" {
  type = number
}
resource "kubernetes_deployment_v1" "vote_and_result" {
  metadata {
    name = var.metadata_name
    labels = {
      app = var.label_app
    }
  }
  spec {
    replicas = var.replica
    selector {
      match_labels = {
        app = var.label_app
      }
    }
    template {
      metadata {
        labels = {
          app = var.template_metadata
        }
      }
      spec {
        container {
          name  = var.container_name
          image = var.container_image
          port {
            container_port = var.container_port
            name = var.port_name
          }
        }
      }
    }
  }
}