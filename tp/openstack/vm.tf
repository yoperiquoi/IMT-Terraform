resource "openstack_compute_keypair_v2" "os_kp" {
  name = "os-admin"
}

data "openstack_images_image_v2" "imta" {
  name        = "imta-ubuntu22"
  most_recent = true
}

resource "openstack_compute_instance_v2" "redis_db" {
  name            = "redis"
  image_name      = data.openstack_images_image_v2.imta.name
  flavor_name     = "m1.small"
  key_pair        = resource.openstack_compute_keypair_v2.os_kp.name
  security_groups = [ "sg-open" ]
  
  user_data = templatefile("./install-redis.sh", {})

  network {
    name = "internal"
  }
}