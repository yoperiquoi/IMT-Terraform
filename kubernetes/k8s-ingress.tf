resource "kubernetes_ingress_v1" "frontend-ingess" {
  metadata {
    name = "frontend-ingress"
  }
  spec {
    default_backend {
      service {
        name = "frontend"
        port {
          number = 8080
        }
      }
    }
  }
}