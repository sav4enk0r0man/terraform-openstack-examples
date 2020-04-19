variable "os_auth_url" {
  default = "https://infra.mail.ru:35357/v3/"
}

variable "os_region" {
  default = "RegionOne"
}

variable "os_user_name" {
  default = "r.savchenko"
}

variable "os_user_password" {
  default = ""
}

variable "os_domain_id" {
  default = "808068cbbad14923bdb64b2889839b3c"
}

variable "availability_zone" {
  default = "DP1"
}

variable "instance_flavor_id" {
  default = "25ae869c-be29-4840-8e12-99e046d2dbd4" # Basic-1-2-20
}

variable "volume_type" {
  default = "dp1"
}

variable "volume_size" {
  default = 20
}

variable "instance_image_id" {
  default = "64995697-2d04-42b0-b5d2-c78dcd4c4b84" # Ubuntu-18.04-Standard
}

variable "keypair_name" {
  default = "id-rsa-S2bGCN1z"
}

variable "instance_network_name" {
  default = "network_9492"
}
