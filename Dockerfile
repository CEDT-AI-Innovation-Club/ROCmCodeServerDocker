# Base Image: ROCm Ubuntu 24.04 with full AMD GPU support
FROM rocm/pytorch:rocm6.3.2_ubuntu24.04_py3.12_pytorch_release_2.4.0

# Install dependencies (skip GPU drivers as they are already installed)
RUN apt update && apt install -y --no-install-recommends \
    curl sudo unzip git bash && \
    rm -rf /var/lib/apt/lists/*

# Set up Code-Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set working directory
WORKDIR /root/project

# Copy entrypoint script and ensure execution permissions
COPY --chmod=755 entrypoint.sh /entrypoint.sh

# Run the entrypoint script first, then start Code-Server
ENTRYPOINT ["/entrypoint.sh"]
