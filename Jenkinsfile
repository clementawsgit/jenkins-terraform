pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1' // Replace with your AWS region
        TF_VERSION = 'latest'      // Or specify a version like '1.5.0'
    }

    tools {
        terraform "${TF_VERSION}"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            options {
                timeout(time: 120, unit: 'MINUTES') // Set timeout to 120 minutes
            }
            steps {
                sh 'terraform plan -out tfplan'
            }
        }

        stage('Terraform Apply') {
            input {
                message 'Approve Terraform Apply?'
            }
            steps {
                sh 'terraform apply tfplan'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        failure {
            echo 'Terraform deployment failed!'
        }
        success {
            echo 'Terraform deployment successful!'
        }
    }
}
