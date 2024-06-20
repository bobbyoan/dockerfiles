FROM ubuntu:latest

# Update package list
RUN apt update -y

# Install nginx
RUN apt install -y nginx

# Remove ufw
RUN apt remove -y ufw

# Install firewalld
RUN apt install -y firewalld

# Enable firewalld service
RUN systemctl enable firewalld

# Add firewall rule to open port 8080
RUN firewall-cmd --permanent --add-port=8080/tcp

# Reload firewall to apply the changes
RUN firewall-cmd --reload

# Create a basic index.html file
RUN echo '<!DOCTYPE html>\
<html lang="en">\
<head>\
    <meta charset="UTF-8">\
    <meta name="viewport" content="width=device-width, initial-scale=1.0">\
    <title>Welcome to Nginx</title>\
</head>\
<body>\
    <h1>Welcome to Nginx on Docker!</h1>\
    <p>This is a basic web page served by Nginx running in a Docker container.</p>\
</body>\
</html>' > /var/www/html/index.html

# Expose the port
EXPOSE 8080

# Copy the script to start services
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set the entrypoint to the start script
ENTRYPOINT ["/start.sh"]

