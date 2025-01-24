# Use Ubuntu as the base image
FROM ubuntu:latest

# Update the package list and install apache2
RUN apt-get update && apt-get install -y apache2 && apt-get clean

# Change the Apache port configuration to 8089
RUN sed -i 's/80/8089/' /etc/apache2/ports.conf \
    && sed -i 's/:80/:8089/' /etc/apache2/sites-available/000-default.conf

# Expose port 8089 for external access
EXPOSE 8089

# Start Apache service
CMD ["apachectl", "-D", "FOREGROUND"]
