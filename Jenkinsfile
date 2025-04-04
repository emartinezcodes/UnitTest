pipeline {
    agent any

    environment {
        // Ensure SONARQUBE_SERVER is set to match your accessible SonarQube server
        SONARQUBE_SERVER = 'http://sonar:9000'
        SONARQUBE_TOKEN = credentials('sonarqube-token')  // Use the Jenkins credentials ID for the SonarQube token
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

        stage('SonarQube Analysis with Java 8') {
            steps {
                script {
                    docker.image('maven:3.9.6-jdk-8').inside {
                        withSonarQubeEnv('sonarqube') {
                            echo "Running SonarQube analysis with Java 8..."
                            // Using the SonarQube token for authentication
                            sh 'mvn sonar:sonar -Dsonar.projectKey=midterm-jenkins-project -Dsonar.branch.name=main -Dsonar.host.url=http://sonar:9000 -Dsonar.login=${SONARQUBE_TOKEN}'
                        }
                    }
                }
            }
        }
    }
}


