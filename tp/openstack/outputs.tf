output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.mycluster.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.mycluster.endpoint
  description = "GKE Cluster Host"
}

output "redis_floating_ip" {
  value       = openstack_networking_floatingip_v2.redis_ip.address
  description = "Floating IP associated to the VM"
}