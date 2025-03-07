pipeline {
    agent any

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
                script {
                    
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    
                    sh 'terraform plan -var "region=${TF_VAR_region}"'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    
                    sh 'terraform apply -auto-approve -var "region=${TF_VAR_region}"'
                }
            }
        }
    }

    post {
        always {
            
            cleanWs()
        }
    }
}
