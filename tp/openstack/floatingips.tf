resource "openstack_networking_floatingip_v2" "redis_ip" {
  pool = "external"
}

resource "openstack_compute_floatingip_associate_v2" "redis_ip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.redis_ip.address
  instance_id = openstack_compute_instance_v2.redis_db.id
}