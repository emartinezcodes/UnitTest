pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                dir('UnitTest') {
                    git 'https://github.com/emartinezcodes/UnitTest.git'
                }
            }
        }
        stage('Build') {
            steps {
                echo '✅ Build stage reached!'
            }
        }
    }
}

