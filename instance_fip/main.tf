terraform {
  required_version = ">= 0.11.10"
}

resource "openstack_blockstorage_volume_v2" "test-volume" {
  name        = "instance-fip"
  volume_type = "${var.volume_type}"
  size        = "${var.volume_size}"
  image_id    = "${var.instance_image_id}"
}

resource "openstack_compute_instance_v2" "test-instance" {
  name              = "instance-fip"
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

resource "openstack_networking_floatingip_v2" "myip" {
  pool = "ext-net"
}

resource "openstack_compute_floatingip_associate_v2" "myip" {
  floating_ip = "${openstack_networking_floatingip_v2.myip.address}"
  instance_id = "${openstack_compute_instance_v2.test-instance.id}"
}
