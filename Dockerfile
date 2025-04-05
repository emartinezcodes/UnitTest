# Use OpenJDK 17 base image
FROM openjdk:17-jdk

# Set the working directory in the container
WORKDIR /app

# Install dependencies and Maven
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://archive.apache.org/dist/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz && \
    tar -xvzf apache-maven-3.8.1-bin.tar.gz && \
    mv apache-maven-3.8.1 /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Verify Maven installation
RUN mvn -v

# Copy the JAR file from the target directory (assumes Maven build output is in target/)
COPY target/myfirstproject-0.0.1-SNAPSHOT.jar /app/myfirstproject.jar

# Expose the port that the app will run on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "myfirstproject.jar"]


