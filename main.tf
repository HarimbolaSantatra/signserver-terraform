terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host     = "ssh://santatra@${var.remote_host}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}


resource "docker_image" "signserver" {
  name         = var.image_name
  keep_locally = true
}

resource "docker_network" "signserver_net" {
  name            = "signserver_net"
  attachable      = false
  check_duplicate = true
  ipam_config {
    subnet = var.network_subnet
  }
}

resource "docker_container" "signserver" {
  name  = var.container_name
  image = docker_image.signserver.name
  env = [
    "DATABASE_JDBC_URL=jdbc:mariadb://${var.db_host}:3306/${var.db_name}?characterEncoding=UTF-8",
    "DATABASE_USER=${var.db_user}",
    "DATABASE_PASSWORD=${var.db_password}",
    "LOG_LEVEL_APP=INFO",
    "LOG_LEVEL_SERVER=INFO",
    "TLS_SETUP_ENABLED=later",
    "PASSWORD_ENCRYPTION_KEY=signserver",
    "CA_KEYSTOREPASS=signserver",
    "signserver_CLI_DEFAULTPASSWORD=signserver",
    "PROXY_HTTP_BIND=${var.container_ip}",
  ]
  memory = 1000
  rm     = false
  networks_advanced {
    name         = docker_network.signserver_net.name
    ipv4_address = var.container_ip
  }
  mounts {
    target    = "/mnt/external/secrets/tls/cas/ManagementCA.crt"
    type      = "bind"
    source    = "/home/santatra/signserver/eqima.pem"
    read_only = true
  }
}
