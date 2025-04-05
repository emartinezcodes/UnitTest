pipeline {
    agent any

    environment {
        SONARQUBE_URL = 'http://sonarqube:9000'  // Ensure SonarQube is accessible
        SONARQUBE_TOKEN = credentials('sonarqube-token')  // Use Jenkins credentials for SonarQube token
        DOCKER_IMAGE_NAME = '0eliz19/0eliz19-myfirstproject:tagname'  // Docker Hub image name with tag
        DOCKER_CREDENTIALS = 'docker-hub-credentials'  // Docker Hub credentials in Jenkins
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
                    docker.image('maven:3.9.6-eclipse-temurin-17').inside {
                        sh 'mvn clean install'  // Build with Java 17 using Maven
                    }
                }
            }
        }

        stage('Test with Java 11') {
            steps {
                script {
                    docker.image('openjdk:11-jdk').inside {
                        sh 'mvn clean test -P java11-tests'  // Run tests with the Java 11 container
                    }
                }
            }
        }

        stage('SonarQube Analysis with Java 8') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-8').inside {
                        sh 'mvn clean install -P java8-sonar'  // Run SonarQube analysis with Java 8
                    }
                }
            }
        }

        stage('Verify JAR file') {
            steps {
                sh 'ls -l target/'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE_NAME} ."
                }
            }
        }

        stage('List Docker Images') {
            steps {
                script {
                    sh 'docker images'
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin'
                    }

                    sh "docker push ${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}"
                }
            }
        }
    }
}

