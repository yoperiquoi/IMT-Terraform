resource "openstack_networking_network_v2" "internal" {
  name           = "internal"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet" {
  name            = "subnet"
  network_id      = openstack_networking_network_v2.internal.id
  cidr            = "192.168.42.0/24"
  ip_version      = 4
  dns_nameservers = ["192.44.75.10", "192.108.115.2"]
}

resource "openstack_networking_secgroup_v2" "sg-open" {
  name        = "sg-open"
  description = "Open security group, allows everything"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_all" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sg-open.id
}

# External network/router
resource "openstack_networking_router_v2" "router" {
  name                = "router"
  admin_state_up      = true
  external_network_id = "8c49bf69-e2ea-48a2-ada1-753a031f402d" # external
}
resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

# Allow SSH ingress to default security group
data "openstack_networking_secgroup_v2" "default" {
  name        = "default"
}
resource "openstack_networking_secgroup_rule_v2" "sg_rule_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = data.openstack_networking_secgroup_v2.default.id
}