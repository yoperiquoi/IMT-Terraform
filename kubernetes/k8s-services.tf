resource "kubernetes_service_v1" "redis-leader" {
  metadata {
    name = "redis-leader"
    labels = {
      App = "redis"
      Tier = "backend"
    }
  }
  spec {
    selector = {
      App = "redis"
      Tier = "backend"
    }
    port {
      port = 6379
      target_port = 6379
    }
  }
}

resource "kubernetes_service_v1" "redis-follower" {
  metadata {
    name = "redis-follower"
    labels = {
      App = "redis"
      Tier = "backend"
    }
  }
  spec {
    selector = {
      App = "redis"
      Tier = "backend"
    }
    port {
      port = 6379
    }
  }
}

resource "kubernetes_service_v1" "frontend" {
  metadata {
    name = "frontend"
    labels = {
      App = "guestbook"
      Tier = "frontend"
    }
  }
  spec {
    selector = {
      App = "guestbook"
      Tier = "frontend"
    }
    port {
      port = 8080
      target_port = 80
    }
    type = "NodePort"
  }
}