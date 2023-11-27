
module "db-service"{
  source = "./modules/k8s-service-cluster/"

  metadata_name = "db"
  label_name    = "db"
  selector_name = "db"
  type          = "ClusterIP"
  port          = 5432
  target_port   = 5432
  port_name     = "db-service"
}
module "redis-service" {
  source = "./modules/k8s-service-cluster/"

  metadata_name = "redis"
  label_name    = "redis"
  selector_name = "redis"
  type          = "ClusterIP"
  port          = 6379
  target_port   = 6379
  port_name     = "redis-service"
}

module "result-service"{
 source = "./modules/k8s-service-node/"

  metadata_name = "result"
  label_name    = "result"
  selector_name = "result"
  type          = "NodePort"
  port          = 5001
  target_port   = 80
  port_name     = "result-service"
  node_port     = 31001
}
module "vote-service" {
  source = "./modules/k8s-service-node/"

  metadata_name = "vote"
  label_name    = "vote"
  selector_name = "vote"
  type          = "NodePort"
  port          = 5000
  target_port   = 80
  port_name     = "vote-service"
  node_port     = 31000
}