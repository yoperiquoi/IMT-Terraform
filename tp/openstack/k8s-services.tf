resource "kubernetes_service_v1" "db" {
  metadata {
    name = "db"
    labels = {
      app = "db"
    }
  }
  spec {
    selector = {
      app = "db"
    }
    type = "ClusterIP"
    port {
      port = 5432
      target_port = 5432
      name = "db-service"
    }
  }
}

resource "kubernetes_service_v1" "redis" {
  metadata {
    name = "redis"
    labels = {
      app = "redis"
    }
  }
  spec {
    selector = {
      app = "redis"
    }
    type = "ClusterIP"
    port {
      port = 6379
      target_port = 6379
      name = "redis-service"
    }
  }
}

resource "kubernetes_service_v1" "result" {
  metadata {
    name = "result"
    labels = {
      app = "result"
    }
  }
  spec {
    selector = {
      app = "result"
    }
    type = "NodePort"
    port {
      port = 5001
      target_port = 80
      node_port = 31001
      name = "result-service"
    }
  }
}

resource "kubernetes_service_v1" "vote" {
  metadata {
    name = "vote"
    labels = {
      app = "vote"
    }
  }
  spec {
    selector = {
      app = "vote"
    }
    type = "NodePort"
    port {
      port = 5000
      target_port = 80
      node_port = 31000
      name = "vote-service"
    }
  }
}