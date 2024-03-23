# Default recipe listing all the available recipes
default:
  just --list

# Install Hauler
install-hauler:
    #!/usr/bin/env bash
    curl -sfL https://get.hauler.dev | bash

# Add example image and chart to Hauler store
add-example-image-and-chart:
    hauler store add image piotrzan/kubectl-comp:latest
    hauler store add chart rancher --repo https://releases.rancher.com/server-charts/stable --version 2.8.2

# Install Arkade
install-arkade:
  #!/usr/bin/env bash
  if ! which arkade > /dev/null; then
    curl -sLS https://dl.get-arkade.dev | sudo sh
  else
      echo "arkade is already installed"
  fi

# Install k3d using Arkade
install-k3d:
    #!/usr/bin/env bash
    if ! command -v k3d &>/dev/null; then arkade get k3d; fi

# Create k3d registry
create-k3d-registry:
  @k3d registry create myregistry.localhost --port 12345

# Create a new cluster with k3d
create-k3d-cluster:
  @k3d cluster create --registry-use k3d-myregistry.localhost:12345

# Package Hauler store
package-hauler-store:
    hauler store save --filename basic-setup.tar.zst

# Serve the Hauler store
serve-hauler-store:
    hauler store serve registry

# Pull image from the Hauler store
pull-image:
    docker pull localhost:5000/piotrzan/kubectl-comp:latest

# Create a Kubernetes deployment for the kubectl-comp image
create-deployment:
    #!/usr/bin/env bash
    cat <<EOF | kubectl apply -f -
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: kubectl-comp-deployment
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: kubectl-comp
      template:
        metadata:
          labels:
            app: kubectl-comp
        spec:
          containers:
          - name: kubectl-comp
            image: k3d-myregistry.localhost:12345/kubectl-comp:latest

    EOF

# Delete k3d cluster
delete-k3d-cluster:
    k3d cluster delete my-cluster
