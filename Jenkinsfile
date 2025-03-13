pipeline {
    agent any

    environment {
        // Define environment variables for Terraform
        TF_VAR_project = 'my-project'
        TF_VAR_region = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code
                checkout scm
            }
        }

        stage('Initialize Terraform') {
            steps {
                script {
                    // Initialize Terraform working directory
                    sh 'terraform init'
                }
            }
        }

        stage('Plan Terraform Deployment') {
            steps {
                script {
                    // Run Terraform plan to see the changes to be made
                    sh 'terraform plan -var="project=${TF_VAR_project}" -var="region=${TF_VAR_region}"'
                }
            }
        }

        stage('Apply Terraform Deployment') {
            steps {
                script {
                    // Apply the Terraform changes to deploy infrastructure
                    sh 'terraform apply -auto-approve -var="project=${TF_VAR_project}" -var="region=${TF_VAR_region}"'
                }
            }
        }

        stage('Destroy Infrastructure (optional)') {
            steps {
                script {
                    // Destroy infrastructure (used for cleanup or testing)
                    sh 'terraform destroy -auto-approve -var="project=${TF_VAR_project}" -var="region=${TF_VAR_region}"'
                }
            }
        }
    }

    post {
        always {
            // Clean up any Terraform state files after completion
            cleanWs()
        }
    }
}
