resource "openstack_compute_keypair_v2" "os_kp" {
  name = "os-admin"
}

data "openstack_images_image_v2" "imta" {
  name        = "imta-ubuntu22"
  most_recent = true
}

resource "openstack_compute_instance_v2" "redis_instance" {
  name            = "redis-instance"
  flavor_name     = data.openstack_images_image_v2.imta.name
  image_name      = "m1.small"
  key_pair        = data.openstack_compute_keypair_v2.os_kp.name
  security_groups = ["sg-open"]

  network {
    name = "internal"
  }

  user_data = "DEBIAN_FRONTEND=noninteractive apt-get update -q\nDEBIAN_FRONTEND=noninteractive apt-get install -y redis"
}