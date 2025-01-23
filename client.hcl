job "client" {

  group "client" {
    count = 1
    network {
      port "http" {}
    }

    service {
      provider = "nomad"
      name = "client"
      port = "http"
      tags = ["http"]
    }

    task "client" {
      driver = "java"
      artifact {
        source      = "git::https://github.com/panchal-ravi/nomad-java.git"
        destination = "local/repo"
      }
      template {
        destination = "${NOMAD_TASK_DIR}/repo/client/config/upstream_urls"
        change_mode = "noop"
        env = true
        data        = <<EOT
upstreamServiceUrl={{range $index, $nomadService := nomadService "api"}}{{if ne $index 0}},{{end}}{{ .Address }}:{{ .Port }}{{end}}
        EOT
      }
      config {
        jar_path = "local/repo/client/client.jar"
        args = ["--server.port=${NOMAD_PORT_http}"]
      }
    }
  }
}

