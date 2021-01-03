job "PR1SM-ID" {
  datacenters = ["dc1"]

  group "kratos" {

    task "kratos-raw" {
      driver = "docker"

      config {
        image = "pr1smgg/kratos:latest"

        args = [
          "-e",
          "DSN=memory"
        ]
      }
      resources {
        cpu = 500
        memory = 1000
      }

    }


    // volume "kratos-db" {
    //   type      = "host"
    //   source    = "kratos-pgdata"
    //   read_only = false
    // }
    // task "db" {
    //   driver = "docker"

    //   config {
    //     image = "postgres:13-alpine"

    //     args = [
    //       "-e",
    //       "POSTGRES_USER=kratos-admin",
    //       "-e",
    //       "POSTGRES_PASSWORD=123",
    //       "-e",
    //       "POSTGRES_DB=kratos-users",
    //       "-e",
    //       "PGDATA=/etc/.kratos/pgdata"
    //     ]
    //   }

    //   volume_mount {
    //     volume      = "kratos-db"
    //     destination = "/etc/.kratos"
    //   }

    //   resources {
    //     cpu    = 500 
    //     memory = 128 
    //     network {
    //       mbits = 10

    //       port "http" {
    //         static = "5678"
    //       }
    //     }
    //   }
    // }
  }
}
