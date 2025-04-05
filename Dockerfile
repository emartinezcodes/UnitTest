# Use Jenkins LTS image with JDK 17
FROM jenkins/jenkins:lts-jdk17

# Switch to root user to install Docker
USER root

# Install Docker
RUN apt-get update && \
    apt-get install -y docker.io

# Switch back to Jenkins user
USER jenkins
