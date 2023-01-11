variable "service_tag" {
  type = string
}

job "template-express-ts" {
  datacenters = ["dc1"]

  group "template-express-ts" {
    count = 1
    network {
      port "http" {
        to = 3000
      }
    }

    task "template-express-ts" {
      driver = "docker"
      template {
        data        = <<EOH
{{range ls "app/template-express-ts/env"}}
{{.Key}}={{.Value}}
{{end}}
EOH
        destination = ".env"
        change_mode = "restart"
        env         = true
      }
      resources {
        cpu    = 1000
        memory = 256
      }

      config {
        image      = "USER/template-express-ts:${var.service_tag}"
        force_pull = true
        ports      = ["http"]
      }
      service {
        name     = "template-express-ts"
        port     = "http"
        tags     = ["http"]
        provider = "nomad"
      }
    }
  }
}
