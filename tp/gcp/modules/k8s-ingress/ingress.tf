variable "metadata_name" {
  type = string
}
variable "service_name" {
  type = string
}
variable "port" {
  type = number
}

resource "kubernetes_ingress_v1" "ingresses" {
  metadata {
    name = var.metadata_name
  }
  spec {
    default_backend {
      service {
        name = var.service_name
        port {
          number = var.port
        }
      }
    }
  }
}