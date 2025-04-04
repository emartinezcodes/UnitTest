pipeline {
    agent any

    environment {
        SONARQUBE = 'sonarqube'  // Name of the SonarQube server from Jenkins config
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
                        sh 'mvn clean install -DskipTests'  // Skip tests during build
                    }
                }
            }
        }

        stage('Test with Java 11') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-11').inside {
                        sh 'mvn clean test -P java11-tests'  // Run unit tests with Java 11
                    }
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    // SonarQube analysis after tests are run
                    withSonarQubeEnv(SONARQUBE) {
                        sh 'mvn sonar:sonar -Dsonar.projectKey=myFirstProject -Dsonar.host.url=http://sonarqube:9000'
                    }
                }
            }
        }
    }
}


