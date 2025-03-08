FROM nginx:latest

# Create a non-root user
RUN groupadd -g 1000 appuser && \
    useradd -r -u 1000 -g appuser appuser

# Set permissions for NGINX directories
RUN mkdir -p /var/www /var/cache/nginx /var/run /var/log/nginx && \
    chown -R appuser:appuser /var/www /var/cache/nginx /var/run /var/log/nginx

# Copy configuration files and certificates
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./cert /etc/nginx/cert
COPY ./nginx.conf /etc/nginx/nginx.conf

# Switch to the non-root user
USER appuser

WORKDIR /var/www