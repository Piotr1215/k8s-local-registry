# Local Registry with Hauler and k3d

This project demonstrates how to set up and use local registries for Kubernetes development with Hauler and k3d. It covers the entire workflow from installing necessary tools, adding images to Hauler, setting up a local k3d registry, creating a Kubernetes cluster, and deploying an application using images from the local registry.

## Project Setup

### Tools Used

- **Hauler**: A tool for managing container images and Helm charts, allowing for the creation of a local store and registry for Kubernetes resources.
- **k3d**: A utility to run K3s (a lightweight Kubernetes distribution) in Docker, making it simple to spin up a Kubernetes cluster on your local machine.
- **Arkade**: A CLI for downloading and installing Kubernetes CLI tools and applications, used here to install k3d.
- **Just**: A command runner that allows you to save and run project-specific commands defined in a `justfile`.

### Workflow

1. **Install Hauler**: Sets up Hauler on your machine, enabling local storage and serving of container images and Helm charts.
2. **Add Images and Charts to Hauler Store**: Demonstrates adding an example container image and a Helm chart to the Hauler store.
3. **Install Arkade and k3d**: Utilizes Arkade to install k3d, facilitating the creation and management of local Kubernetes clusters.
4. **Create a k3d Registry**: Establishes a k3d-managed registry to allow for seamless image transfers within the local Kubernetes environment.
5. **Create a Kubernetes Cluster with k3d**: Spins up a new Kubernetes cluster integrated with the local k3d registry.
6. **Serve the Hauler Store**: Illustrates serving the Hauler store as a registry, making it accessible for Kubernetes deployments.
7. **Pull Image from Hauler Store**: Pulls a specified image from the Hauler store, showcasing the interaction between Docker and the local registry.
8. **Deploy an Application**: Deploys a Kubernetes application using the image stored in the local registry, validating the end-to-end workflow.

### Getting Started

To begin using this project, ensure Docker is installed on your machine. Then, follow the recipes defined in the `justfile` to sequentially set up your development environment:

```bash
# List all available recipes
just

# Install necessary tools and create a cluster
just install-hauler
just add-example-image-and-chart
just install-arkade
just install-k3d
just create-k3d-registry
just create-k3d-cluster

# Package the Hauler store, serve it, and pull an image
just package-hauler-store
just serve-hauler-store
just pull-image

# Deploy an application to your cluster
just create-deployment

# Clean up
just delete-k3d-cluster
```

### Purpose

This project aims to provide a practical example of using local registries with Kubernetes, specifically focusing on development and testing environments. It facilitates a better understanding of container management, local Kubernetes cluster creation, and deployment processes, making it an invaluable resource for developers working with Kubernetes.
