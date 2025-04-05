# Stage 1: Use Maven to build the project (with Java 17)
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the project using Maven (creates the JAR file)
RUN mvn clean install

# Stage 2: Use OpenJDK to run the app
FROM openjdk:17-jdk

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage (from the Maven build container)
COPY --from=build /app/target/myFirstProject-0.0.1-SNAPSHOT.jar /app/myfirstproject.jar

# Expose the port the app will run on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "myfirstproject.jar"]

