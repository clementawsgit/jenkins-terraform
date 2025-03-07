pipeline {
    agent any

    tools {
        terraform 'v1.11.1' // Specify your Terraform version
    }

    environment {
        TF_VAR_region = 'us-east-1'
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/clementawsgit/jenkins-terraform.git']])
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
            steps {
                sh 'terraform plan -var "region=${TF_VAR_region}" -out=tfplan' // Added -out=tfplan
            }
            post {
                always {
                    archiveArtifacts artifacts: 'tfplan' //Archive the plan for review
                }
            }
        }

        stage('Terraform Apply') {
            input {
                message "Approve Terraform Apply?"
                ok "Proceed"
                submitterParameter 'APPROVED_BY'
            }
            steps {
                sh 'terraform apply -auto-approve tfplan' // Apply the plan from the file
                echo "Terraform Apply completed by ${APPROVED_BY}"
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
