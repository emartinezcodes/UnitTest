pipeline {
    agent any

    environment {
        SONARQUBE_TOKEN = credentials('sonarqube-token')  // Using Jenkins credentials for the token
        SONARQUBE_SERVER = 'http://172.20.0.3:9000'
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
                        sh 'mvn clean install -DskipTests'
                    }
                }
            }
        }

        stage('Test with Java 11') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-11').inside {
                        sh 'mvn test -P java11-tests'
                    }
                }
            }
        }

        // New stage to test connection to SonarQube server
        stage('Test Connection to SonarQube') {
            steps {
                script {
                    echo "Testing connection to SonarQube server..."
                    sh 'curl -f http://172.20.0.3:9000 || echo "Unable to connect to SonarQube"'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-11').inside {
                        withSonarQubeEnv('sonarqube') {
                            echo "Running SonarQube analysis..."
                            sh 'mvn sonar:sonar'
                        }
                    }
                }
            }
        }
    }
}


