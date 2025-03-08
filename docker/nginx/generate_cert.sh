#!/bin/bash

# Source the .env file from the parent directory
if [ -f ../../.env ]; then
  set -o allexport
  source ../../.env
  set -o allexport -
else
  echo ".env file not found in the parent directory"
  exit 1
fi

# Check if the CERT_CN variable is set
if [ -z "$CERT_CN" ]; then
  echo "CERT_CN variable is not set in the .env file"
  exit 1
fi

# Create the cert directory if it doesn't exist
mkdir -p cert

echo "Generate CERT for $CERT_CN"

# Generate the auto-signed certificate using the dynamic CN from .env
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout cert/server.key \
    -out cert/server.crt \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=$CERT_CN"
