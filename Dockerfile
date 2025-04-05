# Use a base image with OpenJDK
FROM openjdk:17-jdk

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the target directory (assumes Maven build output is in target/)
COPY target/myfirstproject-0.0.1-SNAPSHOT.jar /app/myfirstproject.jar  # Ensure the lowercase name

# Expose the port that the app will run on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "myfirstproject.jar"]
