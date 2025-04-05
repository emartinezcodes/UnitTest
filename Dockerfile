# Use Maven to build the project
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean install

# Use OpenJDK to run the app
FROM openjdk:17-jdk

WORKDIR /app

# Ensure the correct path to the JAR file
COPY --from=build /app/target/myFirstProject-0.0.1-SNAPSHOT.jar /app/myfirstproject.jar

ENTRYPOINT ["java", "-jar", "myfirstproject.jar"]

