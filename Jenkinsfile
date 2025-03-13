pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                checkout scm
            }
        }

        stage('Install Terraform') {
            steps {
                script {
                    // Install Terraform if not already installed
                    sh '''
                    curl -LO https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_linux_amd64.zip
                    unzip terraform_1.3.7_linux_amd64.zip
                    sudo mv terraform /usr/local/bin/
                    terraform -v
                    '''
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Run Terraform plan to preview the changes
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply the Terraform configuration (run if plan is successful)
                    input message: 'Approve Terraform Apply?', ok: 'Apply'
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                branch 'master'
            }
            steps {
                script {
                    // Optionally destroy infrastructure when required
                    input message: 'Destroy Infrastructure?', ok: 'Destroy'
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform changes applied successfully!'
        }

        failure {
            echo 'Terraform failed. Check the logs for errors.'
        }

        always {
            // Clean up any sensitive files if needed
            sh 'rm -f terraform_*.zip'
        }
    }
}
