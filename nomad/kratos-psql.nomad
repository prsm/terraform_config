job "kratos-psql" {
  datacenters = ["dc1"]
  type = "service"
  update {
    stagger      = "30s"
    max_parallel = 2
  }
  group "kratos-psql-group" {
    volume "kratos-pgdata" {
      type      = "host"
      source    = "kratos-pgdata"
      read_only = false
    }
    task "kratos-psql-task" {
      driver = "docker"
      config {
        image = "postgres:13-alpine"
      }
      env {
        POSTGRES_USER = "kratos-admin"
        POSTGRES_PASSWORD = 123
        POSTGRES_DB = "kratos-users"
        PGDATA = "/etc/.kratos/pgdata"
      }
      volume_mount {
        volume      = "kratos-pgdata"
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
