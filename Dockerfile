# Dockerfile for Apache2
#
# Details:
#  - Apache 2.4
##

# Pull base image.
FROM ubuntu:20.04

# Maintainer
MAINTAINER TeamRock <devtech@teamrock.com>

# Install Apache2
RUN DEBIAN_FRONTEND=noninteractive apt update \
    && apt install -y curl apache2 \
    && rm -rf /var/lib/apt/lists/*

# Custom apache2 configuration
COPY conf.d/* /etc/apache2/conf-enabled/
COPY /etc/apache2/mods-available/cgid* /etc/apache2/mods-enabled/

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

