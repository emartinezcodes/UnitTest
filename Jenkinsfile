pipeline {
    agent any

    environment {
        // You can set SONARQUBE_SERVER if needed for other purposes
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

        // Stage to test connection to SonarQube
        stage('Test Connection to SonarQube') {
            steps {
                script {
                    // Ensure Jenkins can reach the SonarQube server
                    echo "Testing connection to SonarQube server..."
                    sh 'curl -f http://172.20.0.3:9000 || echo "Unable to connect to SonarQube"'
                }
            }
        }

        // SonarQube Analysis Stage
        stage('SonarQube Analysis') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-11').inside {
                        // Make sure SonarQube environment configuration name matches the one in Jenkins
                        withSonarQubeEnv('sonarqube') {
                            echo "Running SonarQube analysis..."
                            sh 'mvn sonar:sonar -Dsonar.projectKey=midterm-jenkins-project -Dsonar.branch.name=main'
                        }
                    }
                }
            }
        }
    }
}


