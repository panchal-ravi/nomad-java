job "api" {

  group "api" {
    count = 2
    network {
      port "http" {}
    }

    service {
      provider = "nomad"
      name = "api"
      port = "http"
      tags = ["http"]

      check {
        type     = "http"
        port     = "http"
        path     = "/actuator/health/liveness"
        interval = "5s"
        timeout  = "2s"
      }
    }

    task "api" {
      driver = "java"
      artifact {
        source      = "git::https://github.com/panchal-ravi/nomad-java.git"
        destination = "local/repo"
      }
      template {
        destination = "${NOMAD_TASK_DIR}/repo/api/config/application.properties"
        change_mode = "noop"
        data        = <<EOT
{{- with nomadVar "nomad/jobs/api" -}}
{{- range $k, $v := . }}
{{ $k }}={{ $v }} 
{{- end }}
{{- end }}        
        EOT
      }
      env {
        HOSTNAME = "${NOMAD_ADDR_http}"
      }

      config {
        jar_path = "local/repo/api/api.jar"
        args = ["--server.port=${NOMAD_PORT_http}", "--spring.config.location=file:///${NOMAD_TASK_DIR}/repo/api/config/application.properties"]
      }
    }
  }
}

