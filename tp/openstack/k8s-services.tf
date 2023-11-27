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

resource "kubernetes_service_v1" "redis-service" {
  metadata {
    labels = {
      app = "redis"
    }
    name = "redis"
  }

  spec {
    type = "ExternalName"
    external_name = openstack_networking_floatingip_v2.redis_ip.address
    selector = {
      app = "redis"
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