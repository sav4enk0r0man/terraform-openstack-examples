terraform {
  required_version = ">= 0.11.10"
}

#provider "openstack" {
#  project_domain_id = "808068cbbad14923bdb64b2889839b3c"
#  user_name         = "${var.os_user_name}"
#  password          = "${var.os_user_password}"
#  auth_url          = "${var.os_auth_url}"

#  user_domain_id    = "users"
#  region            = "${var.os_region}"
#}

resource "openstack_blockstorage_volume_v2" "test-volume" {
  name        = "test-volume"
  volume_type = "${var.volume_type}"
  size        = "${var.volume_size}"
  image_id    = "${var.instance_image_id}"
}

resource "openstack_compute_instance_v2" "test-instance" {
  name              = "test-instance"
  flavor_id         = "${var.instance_flavor_id}"
  key_pair          = "${var.keypair_name}"
  availability_zone = "${var.availability_zone}"
  config_drive      = true

  security_groups = [
    "default",
    "ssh+www",
    "allow_icmp"
  ]

  block_device {
    uuid                  = "${openstack_blockstorage_volume_v2.test-volume.id}"
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  metadata = {
    env = "dev"
  }

  network {
    name = "${var.instance_network_name}"
  }
}
