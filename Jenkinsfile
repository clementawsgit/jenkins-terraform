pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_REGION = 'us-east-1' 
        TF_VERSION = 'latest'
    }
    tools {
        terraform "${TF_VERSION}"
    }
    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -var-file=terraform.tfvars' # optional var file.
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve -var-file=terraform.tfvars' # optional var file.
            }
        }
    }
    post {
        always {
            echo "Terraform execution complete."
        }
    }
}
