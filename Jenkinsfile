pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_REGION = 'us-east-1' // Replace with your desired AWS region
        TF_VERSION = 'latest' // Or a specific Terraform version (e.g., '1.3.7')
        TF_VAR_FILE = 'terraform.tfvars' // Optional: Specify a terraform.tfvars file
    }
    tools {
        terraform "${TF_VERSION}"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/clementawsgit/jenkins-terraform.git'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Validate') {
            steps{
                sh 'terraform validate'
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    if (env.TF_VAR_FILE) {
                        sh "terraform plan -var-file=${env.TF_VAR_FILE}"
                    } else {
                        sh 'terraform plan'
                    }
                }
            }
        }
        stage('Terraform Apply') {
            input {
                message "Approve Terraform Apply?"
                ok "Proceed"
            }
            steps {
                script {
                    if (env.TF_VAR_FILE) {
                        sh "terraform apply -auto-approve -var-file=${env.TF_VAR_FILE}"
                    } else {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }
    post {
        always {
            echo "Terraform execution completed."
        }
        failure {
            echo "Terraform execution failed."
        }
    }
}
