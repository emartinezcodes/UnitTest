pipeline {
    agent any

    environment {
        // Ensure SONARQUBE_SERVER is set if needed for other purposes
        SONARQUBE_SERVER = 'http://172.22.0.2:9000'
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

        // Removed the SonarQube analysis stages for Java 11 and Java 17

        stage('SonarQube Analysis with Java 8') {
            steps {
                script {
                    docker.image('maven:3.9.6-jdk-8').inside {
                        withSonarQubeEnv('sonarqube') {
                            echo "Running SonarQube analysis with Java 8..."
                            sh 'mvn sonar:sonar -Dsonar.projectKey=midterm-jenkins-project -Dsonar.branch.name=main'
                        }
                    }
                }
            }
        }
    }
}


