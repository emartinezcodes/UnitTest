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
                    docker.image('openjdk:17-jdk').inside('--user root') {
                        sh '''
                            apt-get update
                            apt-get install -y maven
                            mvn clean package
                        '''
                    }
                }
            }
        }
    }
}

