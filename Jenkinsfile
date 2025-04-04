pipeline {
    agent any

    environment {
        // Update SonarQube Server URL to the external IP when accessing from outside Docker
        SONARQUBE_SERVER = 'http://127.0.0.1:9000'
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
                            // Update SonarQube URL for external access
                            sh 'mvn sonar:sonar -Dsonar.projectKey=midterm-jenkins-project -Dsonar.branch.name=main -Dsonar.host.url=http://127.0.0.1:9000'
                        }
                    }
                }
            }
        }
    }
}



