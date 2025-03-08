pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'YOUR_GIT_CREDENTIALS_ID', url: 'https://github.com/clementawsgit/jenkins-terraform.git', branch: 'main'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=ec2.tfplan'
            }
        }

        stage('Terraform Apply') {
            input {
                message "Approve Terraform Apply?"
                ok "Proceed"
                abort "Abort"
            }
            steps {
                sh 'terraform apply ec2.tfplan'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        failure {
            echo "Pipeline failed!"
        }
        success {
            echo "Pipeline succeeded!"
        }
    }
}
