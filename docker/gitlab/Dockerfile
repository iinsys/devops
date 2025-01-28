FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    zip \
    bash \
    git \
    vim \
    wget \
    jq \
    tmux \
    lsb-release \
    bash

# Install SDKMAN!
RUN curl -s "https://get.sdkman.io" | bash

# Set the shell to bash and ensure SDKMAN is sourced
SHELL ["/bin/bash", "-c"]

# Ensure SDKMAN is sourced and you can install things like Java
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk install java 21.0.2-open && \
    sdk install sbt 1.8.2 && \
    sdk install scala 2.13.10

WORKDIR /app

CMD ["bash"]
