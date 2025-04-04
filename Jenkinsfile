pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'http://172.20.0.3:9000'
        SONARQUBE_TOKEN = squ_406b840192102c4836c56b80d8753822daf53e11 // Store your token securely
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
                            echo "Running SonarQube analysis to test configuration..."
                            sh 'mvn sonar:sonar -Dsonar.host.url=$SONARQUBE_SERVER -Dsonar.login=$SONARQUBE_TOKEN'
                        }
                    }
                }
            }
        }
    }
}

