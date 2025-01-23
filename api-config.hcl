items {
    server.shutdown = "graceful"
    management.endpoints.web.exposure.include = "*"
    management.endpoint.health.probes.enabled = true
    management.health.livenessState.enabled = true
    management.health.readinessState.enabled = true
}

