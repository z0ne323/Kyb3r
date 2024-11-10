# Start with a minimal base image
FROM debian:stable-slim

# Set environment variables for non-interactive package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install Tor and Nginx
RUN apt-get update && \
    apt-get install -y tor nginx && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Copy configuration files for Tor and nginx
COPY torrc /etc/tor/torrc
COPY nginx.conf /etc/nginx/nginx.conf

# Delete default nginx file
RUN rm /var/www/html/index.nginx-debian.html

# Copy the files (site content) into /var/www/html
COPY web_server/ /var/www/html

# Create and ensure the Tor directory has proper ownership and permissions for debian-tor user
RUN mkdir -p /var/lib/tor/hidden_service && \
    chown -R debian-tor:debian-tor /var/lib/tor/hidden_service && \
    chmod -R 700 /var/lib/tor/hidden_service

# Expose the necessary ports (HTTP port 80)
EXPOSE 80

# Start Tor, Nginx and display the .onion address
CMD service tor start && \
    service nginx start && \
    echo -n "[+] Tor hidden service is available at (wait 1-2mn): " && \
    cat /var/lib/tor/hidden_service/hostname && \
    tail -f /dev/null
