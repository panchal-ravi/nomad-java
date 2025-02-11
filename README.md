This repository contains two applications that demonstrate how to orchestrate Java Spring Boot applications on Nomad. The application JAR files are pre-built for convenience.

## Application JARs
- **api/api.jar:** A simple Spring Boot REST application that returns a random name.
- **client/client.jar:** Another Spring Boot REST application that interacts with the `api` service. The client application is designed to showcase how service discovery functions within a Nomad environment.

## Nomad job specifications
The repository includes Nomad job specifications for deploying these applications to a Nomad cluster. Ensure at least one Nomad client agent is running Java 17 or later.
- `api.hcl`: Deploys the `api` application on Nomad.
- `client.hcl`: Deploys the `client` application on Nomad.

## Application configuration
The repository provides an `api-config.hcl` file for the `api` application, demonstrating how to externalize application configurations using Nomad variables.