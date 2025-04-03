pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/emartinezcodes/UnitTest.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-17').inside {
                        sh 'ls -la'
                        sh 'mvn clean package'
                    }
                }
            }
        }
    }
}
