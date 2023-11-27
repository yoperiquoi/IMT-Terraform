resource "kubernetes_ingress_v1" "vote-ingress" {
  metadata {
    name = "vote-ingress"
  }
  spec {
    default_backend {
      service {
        name = "vote"
        port {
          number = 5000
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "result-ingress" {
  metadata {
    name = "result-ingress"
  }
  spec {
    default_backend {
      service {
        name = "result"
        port {
          number = 5001
        }
      }
    }
  }
}
