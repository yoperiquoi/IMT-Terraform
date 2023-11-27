resource "google_container_cluster" "mycluster" {
  name     = "${var.project_id}-gke"
  location = var.region

  remove_default_node_pool = false
  initial_node_count       = 1

  network    = google_compute_network.myvpc.name
  subnetwork = google_compute_subnetwork.mysubnet.name
}

data "terraform_remote_state" "gke" {
  backend = "local"

  config = {
    path = "terraform.tfstate"
  }
}

data "google_container_cluster" "my_cluster" {
  name     = data.terraform_remote_state.gke.outputs.kubernetes_cluster_name
  location = var.region
}