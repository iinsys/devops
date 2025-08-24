FROM ubuntu:24.04

# Install Apache
RUN apt-get update && apt-get install -y apache2 && apt-get clean

# Change Apache listen port from 80 to 3000
RUN sed -i 's/80/3000/g' /etc/apache2/ports.conf \
    && sed -i 's/:80/:3000/g' /etc/apache2/sites-available/000-default.conf

# Expose port 3000
EXPOSE 3000

# Start Apache in foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]