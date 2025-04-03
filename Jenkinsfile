pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // This will clone your repo from GitHub
                git 'https://github.com/emartinezcodes/UnitTest.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Use the Maven image with Java 17 and Maven pre-installed.
                    // This image will compile, test, and package your project.
                    docker.image('maven:3.9.6-eclipse-temurin-17').inside {
                        sh 'mvn clean package'
                    }
                }
            }
        }
    }
}
