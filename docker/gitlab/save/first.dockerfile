# Use the official lightweight Ubuntu image as the base
FROM ubuntu:20.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential tools and utilities
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    unzip \
    wget \
    jq \
    vim \
    less \
    mysql-client \
    postgresql-client \
    redis-tools \
    nmap \
    netcat \
    tree \
    htop \
    tmux \
    lsb-release \
    bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install SDKMAN! for managing different SDK versions
RUN curl -s "https://get.sdkman.io" | bash

# Set up working directory
WORKDIR /workspace

# Clean up unnecessary packages and files to reduce image size
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Ensure SDKMAN is sourced correctly by modifying the .bashrc file for bash
RUN echo "source /root/.sdkman/bin/sdkman-init.sh" >> /root/.bashrc

# Set bash as the default shell for the container
ENTRYPOINT ["/bin/bash", "-c", "source /root/.bashrc && exec /bin/bash"]


