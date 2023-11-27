locals {
  network_name = "internal"
  sec_group    = "sg-open"
  db_user      = "lab-tf"
  db_password  = "lab-tf"
}

variable "db_user" {
  type        = string
  description = "OpenStack wordpress DB username"
}

variable "db_password" {
  type        = string
  description = "OpenStack wordpress DB password"
}

provider "openstack" {
  user_name   = "y21periq"
  tenant_name = "fila3-terraform-project1-04"
  auth_url    = "https://openstack.imt-atlantique.fr:13000"
  region      = "Brest1"
}

data "openstack_compute_keypair_v2" "os_kp" {
  name = "os-admin"
}

# Image to boot the VM. Predefined by Brest's team.
data "openstack_images_image_v2" "imta" {
  name        = "imta-ubuntu22"
  most_recent = true
}

resource "openstack_compute_instance_v2" "wp_app" {
  name            = "wordpress-app"
  image_name      = data.openstack_images_image_v2.imta.name
  flavor_name     = "m1.small"
  key_pair        = data.openstack_compute_keypair_v2.os_kp.name
  security_groups = [ "sg-open" ]
  network {
    name = "internal"
  }
  user_data = templatefile("${path.module}/install-wordpress.sh", {
        db_name     = "wordpress"
        db_user     = var.db_user
        db_password = var.db_password
        db_host     = openstack_compute_instance_v2.wp_db.access_ip_v4
  })
}

resource "openstack_compute_instance_v2" "wp_db" {
  name            = "wordpress-db"
  image_name      = data.openstack_images_image_v2.imta.name
  flavor_name     = "m1.small"
  key_pair        = data.openstack_compute_keypair_v2.os_kp.name
  security_groups = [ "sg-open" ]
  network {
    name = "internal"
  }
  user_data = templatefile("${path.module}/install-mariadb.sh", {
    db_rootpassword = "root"
    db_user     = var.db_user
    db_password = var.db_password
    db_name         = "wordpress"
  })
}

# Floating IP
resource "openstack_networking_floatingip_v2" "wp_ip" {
  pool = "external"
}
resource "openstack_compute_floatingip_associate_v2" "wp_ip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.wp_ip.address
  instance_id = openstack_compute_instance_v2.wp_app.id
}

# Outputs
output "wp_floating_ip" {
  value       = openstack_networking_floatingip_v2.wp_ip.address
  description = "Floating IP associated to the VM"
}