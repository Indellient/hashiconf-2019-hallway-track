job "hello-world" {
  type = "service"
  datacenters = ["dc1"]

  group "hello-world" {
    count = 1

    task "hello-world-docker" {
      driver = "docker"

      config {
        image = "yonkornilov/golang-habitat-hello-world:latest"

        labels {
          group = "hello-world"
        }
      }

      env {
        "HAB_LICENSE" = "accept"
      }

    }
  }
}