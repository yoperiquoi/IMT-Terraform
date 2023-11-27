module "worker-deployment" {
  source = "./modules/k8s-deployment/"

  metadata_name   = "worker"
  label_app       = "worker"
  replica         = 1
  selector_label  = "worker"
  template_metadata = "worker"
  container_name  = "worker"
  container_image = "dockersamples/examplevotingapp_worker"
 
}
module "result-deployment" {
  source = "./modules/k8s-deployment/"

  metadata_name   = "redis-follower"
  label_app       = "redis"
  label_tier      = "backend"
  container_name  = "follower"
  container_image = "gcr.io/google_samples/gb-redis-follower:v2"
   container_port  = 80
  port_name = "result"
}
module "vote-deployment" {
  source = "./modules/k8s-deployment/"

  metadata_name   = "redis-follower"
  label_app       = "redis"
  label_tier      = "backend"
  container_name  = "follower"
  container_image = "gcr.io/google_samples/gb-redis-follower:v2"
  container_port  = 6379
}