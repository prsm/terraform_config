job "PR1SM-ID" {
  datacenters = ["dc1"]

  group "kratos" {

    volume "kratos-db" {
      type      = "host"
      source    = "kratos-pgdata"
      read_only = false
    }

    task "kratos-raw" {
      driver = "docker"

      config {
        image = "pr1smgg/kratos:latest"
      }

      env {
        DSN = "postgres://kratos-admin:123@kratos-users:5432/database?sslmode=disable&max_conns=20&max_idle_conns=4"
      }

      resources {
        cpu = 500
        memory = 1000
      }

    }

    task "db" {
      driver = "docker"

      config {
        image = "postgres:13-alpine"

      env {
        POSTGRES_USER = "kratos-admin"
        POSTGRES_PASSWORD = 123
        POSTGRES_DB = "kratos-users"
        PGDATA = "/etc/.kratos/pgdata"
      }

        // args = [
        //   "-e",
        //   "POSTGRES_USER=kratos-admin",
        //   "-e",
        //   "POSTGRES_PASSWORD=123",
        //   "-e",
        //   "POSTGRES_DB=kratos-users",
        //   "-e",
        //   "PGDATA=/etc/.kratos/pgdata"
        // ]
      }

      volume_mount {
        volume      = "kratos-db"
        destination = "/etc/.kratos"
        read_only   = false
      }

      resources {
        cpu    = 500 
        memory = 128 
        network {
          mbits = 10

          port "http" {
            static = "5432"
          }
        }
      }
    }
  }
}
