module "vote-ingress"{
  source = "./modules/k8s-ingress/"

  metadata_name= "vote-ingress"
  service_name = "vote"
  port         = 5000
}

module "result-ingress"{
  source = "./modules/k8s-ingress/"

  metadata_name= "result-ingress"
  service_name = "result"
  port         = 5001
}