# Dockerfile
FROM mysql:8.0-bullseye

# Install mysql-client
RUN apt-get update \
    && apt-get install -y mysql-client

# Clean up
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*
