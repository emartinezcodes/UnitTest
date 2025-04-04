pipeline {
    agent any

    environment {
        // Define SonarQube URL (set this to your SonarQube container's IP and port)
        SONARQUBE_URL = 'http://172.20.0.3:9000'
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
                        sh 'mvn clean install -DskipTests' // Skip tests during build
                    }
                }
            }
        }

        stage('Test with Java 11') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-11').inside {
                        sh 'mvn clean test -P java11-tests'
                    }
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('sonarqube') {
                        sh "mvn sonar:sonar -Dsonar.host.url=${SONARQUBE_URL}"
                    }
                }
            }
        }

        // Optional: Add additional stages like artifact deployment, if needed
    }
}

