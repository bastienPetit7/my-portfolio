# Stage 1: Build Image
FROM node:16-slim

# Définir le répertoire de travail
WORKDIR /var/www

# Définir des valeurs par défaut pour PUID et PGID
ARG PUID=${PUID}
ARG PGID=${PGID}

# Créer un utilisateur non-root et installer les paquets nécessaires dans une seule couche
RUN groupadd -g ${PGID} appgroup && \
    useradd --system -u ${PUID} -g appgroup -s /usr/sbin/nologin appuser && \
    apt-get update && \
    apt-get install -y \
      git \
      build-essential \
      python3 \
      libjpeg-dev && \
    rm -rf /var/lib/apt/lists/* && \
    chown -R appuser:appgroup /var/www

# Copier les fichiers de dépendances dans le répertoire de travail
COPY package*.json ./

# Passer à l'utilisateur non-root
USER appuser
