variable "metadata_name" {
  type = string
}
variable "label_name" {
  type = string
}
variable "selector_name" {
  type = string
}
variable "type" {
  type = string
}
variable "port" {
  type = number
}
variable "target_port" {
  type = number
}
variable "port_name" {
  type = string
}
variable "node_port" {
  type = string
}
resource "kubernetes_service_v1" "services" {
  metadata {
    name = var.metadata_name
    labels = {
      app = var.label_name
    }
  }
  spec {
    selector = {
      app = var.selector_name
    }
    type = var.type
    port {
      port = var.port
      target_port = var.target_port
      name = var.port_name
      node_port = var.node_port
    }
  }
}