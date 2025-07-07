# DevBox

A Docker-based development environment built on Debian latest with essential development tools and utilities.

## What's Included

- **Base**: Debian latest
- **Development Tools**: git, vim, nano, build-essential
- **Utilities**: curl, wget, sudo, ca-certificates, less, openssl, telnet, net-tools, iputils-ping, dnsutils, jq
- **Kubernetes Tools**: kubectl, krew plugin manager
- **User Setup**: Non-root user `devuser` with sudo privileges

## Quick Start

### Using Pre-built Image

```bash
# Pull and run the latest image from GitHub Container Registry
docker run -it --rm ghcr.io/akafazov/devbox:latest

# With volume mount for persistent workspace
docker run -it --rm -v $(pwd):/home/devuser/workspace ghcr.io/akafazov/devbox:latest
```

### Build the Image Locally

```bash
docker build -t devbox .
```

### Run the Container

```bash
# Interactive shell
docker run -it --rm devbox

# With volume mount for persistent workspace
docker run -it --rm -v $(pwd):/home/devuser/workspace devbox

# With port forwarding (for web development)
docker run -it --rm -p 8080:8080 -v $(pwd):/home/devuser/workspace devbox
```

## Usage Examples

### Development Workflow

```bash
# Start container with current directory mounted
docker run -it --rm -v $(pwd):/home/devuser/workspace ghcr.io/akafazov/devbox:latest

# Inside container
cd workspace
git clone <your-repo>
# Start coding...
```

### Kubernetes Development

```bash
# kubectl is pre-installed and ready to use
kubectl version --client

# krew plugin manager is available
kubectl krew search
```

## Customization

To add additional tools, modify the Dockerfile and rebuild:

```dockerfile
RUN apt-get update && apt-get install -y \
    your-additional-packages \
    && rm -rf /var/lib/apt/lists/*
```

## Features

- ✅ Non-root user setup for security
- ✅ Essential development tools pre-installed
- ✅ Kubernetes tools (kubectl + krew) included
- ✅ Network utilities for debugging
- ✅ Clean package cache to minimize image size
- ✅ Sudo access for additional package installation
- ✅ Automated builds via GitHub Actions
- ✅ Published to GitHub Container Registry
