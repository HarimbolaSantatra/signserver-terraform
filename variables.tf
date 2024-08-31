variable "remote_host" {
  description = "Remote host"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "Host of the database"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "signserver"
}

variable "db_user" {
  description = "User of the database"
  type        = string
}

variable "db_password" {
  description = "Password of the database"
  type        = string
  sensitive   = true
}

variable "image_name" {
  description = "Name of the image"
  type        = string
  default     = "keyfactor/signserver-ce"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "signserver"
}


variable "network_subnet" {
  description = "CIDR format of the network subnet"
  type        = string
  default     = "172.9.0.0/16"
}

variable "container_ip" {
  description = "IP address of the container"
  type        = string
  default     = "172.9.0.5"
}
