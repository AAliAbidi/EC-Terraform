terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20.0"
    }
  }
}

provider "docker" {}

# Download the image
resource "docker_image" "node-red_image" {
  name = "nodered/node-red:latest"
}

# Start a container
resource "docker_container" "node-red_container" {
  name  = "node-red"
  image = docker_image.node-red_image.latest
  ports {
    internal = 1880
    external = 1880
  }
}

# Conntiner Name
output "instance_name" {
  value       = docker_container.node-red_container.name
  description = "Name of the container"
}


# Output IP ADDR
output "instance_ip_addr" {
  value       = docker_container.node-red_container.ip_address
  description = "IP Address of the container"
}

#Printing IP Address and port
output "ip_and_port" {
  value       = "http://${join(":",  [docker_container.node-red_container.ip_address, docker_container.node-red_container.ports[0].external])}"
  description = "IP Address & Port"
}
