resource "docker_container" "result" {
    name  = "result"
    image = docker_image.result.name
    ports {
        internal = 80
        external = 5001
    }
    volumes {
        container_path = "./result:/usr/local/app"
    }
    command = ["nodemon", "--inspect=0.0.0.0", "server.js"]
    restart = "always"
    depends_on = [ docker_image.postgres ]
}

resource "docker_container" "worker" {
    name  = "worker"
    image = docker_image.worker.name
    depends_on = [ docker_image.redis, docker_image.postgres ]
    restart = "always"
}

resource "docker_container" "vote" {
    name  = "vote"
    image = docker_image.vote.name
    ports {
        internal = 80
        external = 5000
    }
    volumes {
        container_path = "./vote:/usr/local/app"
    }
    healthcheck {
        test = ["CMD", "curl", "-f", "http://localhost"]
        interval = "10s"
        timeout = "5s"
        retries = 3
    }
    depends_on = [ docker_image.redis ]
    restart = "always"
}

resource "docker_container" "postgres" {
    name  = "postgres"
    image = docker_image.postgres.name
    volumes {
        container_path = "./postgres-data:/var/lib/postgresql/data"
    }
    healthcheck {
        test = ["../exemple-voting-app/healthchecks/postgres.sh"]
        interval = "5s"
    }
    env = ["POSTGRES_PASSWORD=postgres","POSTGRES_USER=postgres"]
    restart = "always"
}