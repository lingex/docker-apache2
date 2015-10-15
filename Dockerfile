# Dockerfile for Apache2 within TeamRock
#
# Details:
#  - Apache 2.4
##

# Pull base image.
FROM teamrock/ubuntu:latest

# Maintainer
MAINTAINER TeamRock <devtech@teamrock.com>

# Install Apache2
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends apache2 libapache2-mod-php5 php5-imagick php5-gd php5-intl php5-mcrypt php5-apcu php5-curl php5-mysql acl \
    && rm -rf /var/lib/apt/lists/*

# Remove default VirtualHost
RUN rm -rf /etc/apache2/sites-enabled/000-default.conf /var/www/html

# Enable rewrite module
RUN a2enmod rewrite

# Configure Apache2
ENV APACHE_RUN_USER     www-data
ENV APACHE_RUN_GROUP    www-data
ENV APACHE_LOG_DIR      /var/log/apache2
env APACHE_PID_FILE     /var/run/apache2.pid
env APACHE_RUN_DIR      /var/run/apache2
env APACHE_LOCK_DIR     /var/lock/apache2
env APACHE_LOG_DIR      /var/log/apache2

# Expose ourselves
EXPOSE 80

# Run!
ENTRYPOINT [ "/usr/sbin/apache2", "-DFOREGROUND" ]

