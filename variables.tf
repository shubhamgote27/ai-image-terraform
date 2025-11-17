variable "instance_name" {
  default = "devops-master-server"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "devops-keypair"
}

variable "public_key_path" {
  default = "./devops-keypair.pub"
}
