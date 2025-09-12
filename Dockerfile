FROM debian:latest

# Update package repositories and install essential tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    vim \
    nano \
    build-essential \
    sudo \
    ca-certificates \
    gnupg \
    lsb-release \
    less openssl telnet net-tools iputils-ping dnsutils jq procps htop \
    && rm -rf /var/lib/apt/lists/*

# Install Go
ENV GO_VERSION=1.24.3
RUN wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz

# Create a non-root user
RUN useradd -m -s /bin/bash devuser && \
    echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN mv kubectl /usr/local/bin/
RUN chmod +x /usr/local/bin/kubectl

ENV VERSION=v4.47.1
ENV BINARY=yq_linux_amd64

RUN wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY}.tar.gz -O - | tar xz && sudo mv ${BINARY} /usr/local/bin/yq

# Install ocm
RUN export OCM_VERSION="0.29.0" && \
    curl -o /tmp/ocm.tar.gz -sSL https://github.com/open-component-model/ocm/releases/download/v$OCM_VERSION/ocm-$OCM_VERSION-linux-amd64.tar.gz && \
    tar -xzf /tmp/ocm.tar.gz -C /usr/local/bin && \
    rm /tmp/ocm.tar.gz && \
    chmod +x /usr/local/bin/ocm

# Copy and run krew installation script
COPY install-krew.sh /tmp/install-krew.sh
RUN chmod +x /tmp/install-krew.sh

# Set working directory
WORKDIR /home/devuser

# Switch to non-root user
USER devuser

COPY .bash_aliases /home/devuser/.bash_aliases


# Add Go and krew to PATH
ENV PATH="/usr/local/go/bin:${PATH}:/home/devuser/.krew/bin"

# Set default command
CMD ["/bin/bash"]
