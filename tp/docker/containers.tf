resource "docker_container" "result" {
    name  = "result"
    image = docker_image.result.name
    ports {
        internal = 80
        external = 5001
    }
    ports {
        ip = "127.0.0.1"
        internal = 9229
        external = 9229
    }
    volumes {
        container_path = "../exemple-voting-app/result:/usr/local/app"
    }
    entrypoint = ["nodemon", "--inspect=0.0.0.0", "server.js"]
    restart = "always"
    depends_on = [ docker_container.db ]
    networks_advanced {
        name = docker_network.back-tier.name
    }
    networks_advanced {
        name = docker_network.front-tier.name
    } 
}

resource "docker_container" "worker" {
    name  = "worker"
    image = docker_image.worker.name
    depends_on = [ docker_container.redis, docker_container.db ]
    restart = "always"
    networks_advanced {
        name = docker_network.back-tier.name
    }
}

resource "docker_container" "vote" {
    name  = "vote"

    image = docker_image.vote.name
    ports {
        internal = 80
        external = 4999
    }
    volumes {
        container_path = "../exemple-voting-app/vote:/usr/local/app"
    }
    healthcheck {
        test = ["CMD", "curl", "-f", "http://localhost"]
        interval = "10s"
        timeout = "5s"
        retries = 3
        start_period = "10s"
    }
    depends_on = [docker_container.redis]
    restart = "always"
    networks_advanced {
        name = docker_network.back-tier.name
    }
    networks_advanced {
        name = docker_network.front-tier.name
    } 
}

resource "docker_container" "db" {
    name  = "db"
    image = docker_image.postgres.name
    volumes {
        container_path = "../exemple-voting-app/db-data:/var/lib/postgresql/data"
    }
    volumes {
        container_path = "../exemple-voting-app/healthchecks:/healthchecks"
    }
    healthcheck {
        test = ["../exemple-voting-app/healthchecks/postgres.sh"]
        interval = "5s"
    }
    env = ["POSTGRES_PASSWORD=postgres","POSTGRES_USER=postgres"]
    restart = "always"
    networks_advanced {
        name = docker_network.back-tier.name
    }
}
resource "docker_container" "redis" {
    name  = "redis"
    image = docker_image.redis.name
    volumes {
        container_path = "../exemple-voting-app/healthchecks:/healthchecks"
    }
    healthcheck {
        test = ["../exemple-voting-app/healthchecks/redis.sh"]
        interval = "5s"
    }
    networks_advanced {
        name = docker_network.back-tier.name
    }
}

resource "docker_container" "seed" {
    count = var.create_seed_resource ? 1 : 0
    name  = "seed"
    image = docker_image.seed.name
    depends_on = [ docker_container.vote]
    restart = "no"
    networks_advanced {
        name = docker_network.front-tier.name
    }
}

variable "create_seed_resource" {
  description = "Indicates whether to create the seed resource"
  default     = false
}