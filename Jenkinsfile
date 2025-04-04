pipeline {
    agent any

    environment {
        // Update SonarQube Server URL to match your accessible IP or service name in Docker Compose
        SONARQUBE_SERVER = 'http://sonar:9000'  // Updated to use the Sonar service name in Docker Compose
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/emartinezcodes/UnitTest.git'
            }
        }

        stage('Build with Java 17') {
            steps {
                script {
                    // Use Java 17 container for build
                    docker.image('maven:3.9.6-eclipse-temurin-17').inside {
                        sh 'mvn clean install -DskipTests'
                    }
                }
            }
        }

        stage('Test with Java 11') {
            steps {
                script {
                    // Use Java 11 container for testing
                    docker.image('maven:3.9.6-eclipse-temurin-11').inside {
                        sh 'mvn test -P java11-tests'
                    }
                }
            }
        }

        stage('SonarQube Analysis with Java 8') {
            steps {
                script {
                    // Use Java 8 container for SonarQube analysis
                    docker.image('maven:3.9.6-jdk-8').inside {
                        withSonarQubeEnv('sonarqube') {
                            echo "Running SonarQube analysis with Java 8..."
                            // Ensure SonarQube URL matches the Docker Compose service name (http://sonar:9000)
                            sh 'mvn sonar:sonar -Dsonar.projectKey=midterm-jenkins-project -Dsonar.branch.name=main -Dsonar.host.url=http://sonar:9000'
                        }
                    }
                }
            }
        }
    }
}

