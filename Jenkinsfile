pipeline {
    agent any

    environment {
        // Ensure SONARQUBE_SERVER is set if you need it for other purposes, 
        // but the SonarQube plugin will use its own settings from Jenkins.
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

        stage('SonarQube Analysis') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-11').inside {
                        // Ensure the SonarQube environment configuration name matches the one in Jenkins
                        withSonarQubeEnv('sonarqube') {
                            sh 'mvn sonar:sonar'
                        }
                    }
                }
            }
        }
    }
}



