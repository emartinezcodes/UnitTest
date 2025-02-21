pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Build App'
            }
        }
        stage('Test') {
            steps {
                echo 'Test App'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploy App'
            }
        }
    }
    
    post {
        always {
            mail(
                to: "emartinez545@toromail.csudh.edu",
                subject: "Pipeline Status",
                body: "Summary of the pipeline execution."
            )
        }
    }
}
