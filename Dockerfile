# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk

# Install Maven
RUN apt-get update && apt-get install -y maven

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY target/myFirstProject-0.0.1-SNAPSHOT.jar /app/myfirstproject.jar

# Expose the port the app will run on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "myfirstproject.jar"]


