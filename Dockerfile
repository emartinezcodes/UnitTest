# Use Jenkins LTS image with JDK 17
FROM jenkins/jenkins:lts-jdk17

# Switch to root user to install Docker and Maven
USER root

# Install Docker
RUN apt-get update && \
    apt-get install -y docker.io wget unzip curl

# Install Maven
RUN wget https://archive.apache.org/dist/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz && \
    tar -xvzf apache-maven-3.8.1-bin.tar.gz && \
    mv apache-maven-3.8.1 /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Verify Maven installation
RUN mvn -v

# Switch back to Jenkins user
USER jenkins
