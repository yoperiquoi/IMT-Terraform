resource "docker_image" "result" {
  name = "result"
  build {
    context = "../example-voting-app/result/"
  }
}

resource "docker_image" "seed" {
  name = "seed"
  build {
    context = "../example-voting-app/seed-data/"
  }
}

resource "docker_image" "vote" {
  name = "vote"
  build {
    context = "../example-voting-app/vote/"
  }
}

resource "docker_image" "worker" {
  name = "worker"
  build {
    context = "../example-voting-app/worker/"
  }
}

resource "docker_image" "redis" {
  name = "docker.io/redis:alpine"
}

resource "docker_image" "postgres" {
  name = "docker.io/postgres:15-alpine"
}



