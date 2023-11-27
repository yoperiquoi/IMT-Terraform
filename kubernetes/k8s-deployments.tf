module "redis-follower-deployment" {
  source = "./modules/k8s-deployment/"

  metadata_name   = "redis-follower"
  label_app       = "redis"
  label_tier      = "backend"
  container_name  = "follower"
  container_image = "gcr.io/google_samples/gb-redis-follower:v2"
  container_port  = 6379
}

module "redis-leader-deployment" {
  source = "./modules/k8s-deployment/"

  metadata_name   = "redis-leader"
  label_app       = "redis"
  label_tier      = "backend"
  container_name  = "leader"
  container_image = "docker.io/redis:6.0.5"
  container_port  = 6379
}

resource "kubernetes_deployment_v1" "gb-frontend" {
  metadata {
    name = "frontend"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "guestbook"
        Tier = "frontend"
      }
    }
    template {
      metadata {
        labels = {
          App = "guestbook"
          Tier = "frontend"
        }
      }
      spec {
        container {
          name  = "gb-frontend"
          image = docker_image.guestbook-frontend.name
          env {
            name = "GET_HOSTS_FROM"
            value = "dns"
          }
          resources {
            requests = {
              cpu = "100m"
              memory = "100Mi"
            }
          }
          port {
            container_port = 80
          }
        }
      }
    }
  }
}