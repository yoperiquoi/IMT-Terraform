resource "kubernetes_deployment_v1" "db" {
  metadata {
    name = "db"
    labels = {
      app = "db"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "db"
      }
    }
    template {
      metadata {
        labels = {
          app = "db"
        }
      }
      spec {
        container {
          name  = "postgres"
          image = "postgres:15-alpine"
          env {
            name = "POSTGRES_USER"
            value = "postgres"
          }
          env {
            name = "POSTGRES_PASSWORD"
            value = "postgres"
          }
          port {
            container_port = 5432
            name = "postgres"
          }
          volume_mount {
            name = "db-data"
            mount_path = "/var/lib/postgresql/data"
          }
        }
        volume {
          name = "db-data"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_deployment_v1" "redis" {
  metadata {
    name = "redis"
    labels = {
      app = "redis"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "redis"
      }
    }
    template {
      metadata {
        labels = {
          app = "redis"
        }
      }
      spec {
        container {
          name  = "redis"
          image = "redis:alpine"
          port {
            container_port = 6379
            name = "redis"
          }
          volume_mount {
            name = "redis-data"
            mount_path = "/data"
          }
        }
        volume {
          name = "redis-data"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_deployment_v1" "result" {
  metadata {
    name = "result"
    labels = {
      app = "result"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "result"
      }
    }
    template {
      metadata {
        labels = {
          app = "result"
        }
      }
      spec {
        container {
          name  = "result"
          image = "dockersamples/examplevotingapp_result"
          port {
            container_port = 80
            name = "result"
          }
        }
      }
    }
  }
}


resource "kubernetes_deployment_v1" "vote" {
  metadata {
    name = "vote"
    labels = {
      app = "vote"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "vote"
      }
    }
    template {
      metadata {
        labels = {
          app = "vote"
        }
      }
      spec {
        container {
          name  = "vote"
          image = "dockersamples/examplevotingapp_vote"
          port {
            container_port = 80
            name = "vote"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment_v1" "worker" {
  metadata {
    name = "worker"
    labels = {
      app = "worker"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "worker"
      }
    }
    template {
      metadata {
        labels = {
          app = "worker"
        }
      }
      spec {
        container {
          name  = "worker"
          image = "dockersamples/examplevotingapp_worker"
        }
      }
    }
  }
}