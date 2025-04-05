# Use Jenkins LTS image with JDK 17
FROM jenkins/jenkins:lts-jdk17

# Switch to root user to install Docker and Docker Compose
USER root

# Install Docker
RUN apt-get update && \
    apt-get install -y docker.io

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Switch back to Jenkins user
USER jenkins
