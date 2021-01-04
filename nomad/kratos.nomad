job "kratos" {
  datacenters = ["dc1"]
  type = "service"
  update {
    stagger      = "30s"
    max_parallel = 2
  }
  group "kratos-group" {
    task "kratos-task" {
      driver = "docker"
      config {
        image = "pr1smgg/kratos:latest"
      }
      env {
        DSN = "postgres://kratos-admin:123@kratos-users:5432/database?sslmode=disable&max_conns=20&max_idle_conns=4"
      }
      resources {
        cpu = 500
        memory = 1024
        network {
          port "krts" {}
        }
      }
      service {
        name = "kratos"
        port = "krts"
      }
    }
  }
}
