variable "gb-frontend-source" {
  type = string
  default = "./gb-frontend/"
  description = "Source directory of Guestbook frontend"
}

resource "docker_image" "guestbook-frontend" {
  name = "europe-west9-docker.pkg.dev/tuto-terraform-yperiquoi/guestbook-app-repo/gb-frontend"
  build {
    context = var.gb-frontend-source
  }
}

resource "docker_registry_image" "guestbook-frontend" {
  name          = docker_image.guestbook-frontend.name
  keep_remotely = true
}

output "gb-frontend-image-name" {
  value = docker_image.guestbook-frontend.name
  description = "Image name of Guestbook frontend container"
}