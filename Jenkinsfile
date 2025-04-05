pipeline {
    agent any

    environment {
        SONARQUBE_URL = 'http://sonarqube:9000'  // Ensure SonarQube is accessible
        SONARQUBE_TOKEN = credentials('sonarqube-token')  // Use Jenkins credentials for SonarQube token
        DOCKER_IMAGE_NAME = '0eliz19/0eliz19-myfirstproject:latest'  // Docker Hub image name (with latest tag)
        DOCKER_CREDENTIALS = 'docker-hub-credentials'  // Docker Hub credentials in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the Java project from GitHub
                git url: 'https://github.com/emartinezcodes/UnitTest.git'
            }
        }

        stage('Build with Java 17') {
            steps {
                script {
                    // Use your custom java17 container for building the project
                    docker.image('java17').inside {
                        sh 'mvn clean install'  // This will compile and build the Java project (JAR file)
                    }
                }
            }
        }

        stage('Test with Java 11') {
            steps {
                script {
                    // Use your custom java11 container for running the unit tests
                    docker.image('java11').inside {
                        sh 'mvn clean test -P java11-tests'  // Run tests with Java 11
                    }
                }
            }
        }

        stage('SonarQube Analysis with Java 8') {
            steps {
                script {
                    // Run SonarQube analysis using Java 8
                    docker.image('maven:3.9.6-eclipse-temurin-8').inside {
                        sh 'mvn clean install -P java8-sonar'  // Run SonarQube analysis with Java 8
                    }
                }
            }
        }

        stage('Verify JAR file') {
            steps {
                // List the files in the target directory to confirm the JAR file is present
                sh 'ls -l target/'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the current directory
                    sh "docker build -t ${DOCKER_IMAGE_NAME} ."
                }
            }
        }

        stage('List Docker Images') {
            steps {
                script {
                    // List all Docker images to verify the image exists
                    sh 'docker images'
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub using credentials stored in Jenkins
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin'
                    }

                    // Tag the Docker image with the repository name
                    sh "docker tag ${DOCKER_IMAGE_NAME} ${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:latest"

                    // Push the Docker image to Docker Hub
                    sh "docker push ${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:latest"
                }
            }
        }
    }
}

