pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-17').inside {
                        sh 'mvn clean package'
                    }
                }
            }
        }
    }
}
