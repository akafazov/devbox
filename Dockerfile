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
    less openssl telnet net-tools iputils-ping dnsutils jq \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash devuser && \
    echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN mv kubectl /usr/local/bin/
RUN chmod +x /usr/local/bin/kubectl

# Copy and run krew installation script
COPY install-krew.sh /tmp/install-krew.sh
RUN chmod +x /tmp/install-krew.sh

# Set working directory
WORKDIR /home/devuser

# Switch to non-root user
USER devuser

# Install krew as devuser
RUN /tmp/install-krew.sh && sudo rm /tmp/install-krew.sh

# Add krew to PATH
ENV PATH="${PATH}:/home/devuser/.krew/bin"

# Set default command
CMD ["/bin/bash"]
