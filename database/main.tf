terraform {
  required_version = ">= 0.11.10"
}

resource "openstack_db_instance_v1" "postgresql-test" {
  region    = "RegionOne"
  name      = "postgresql-test"
  flavor_id = "df3c499a-044f-41d2-8612-d303adc613cc"
  size      = 10

  network {
    uuid = "991220d7-d4c2-4a79-9855-bf6e54a44b12"
  }

  datastore {
    version = "11"
    type    = "postgresql"
  }
}
