pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_REGION            = 'us-east-1'
        TERRAFORM_VERSION     = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'YOUR_GIT_CREDENTIALS_ID', url: 'https://github.com/clementawsgit/jenkins-terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
                sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
                sudo apt-get update && sudo apt-get install terraform=${TERRAFORM_VERSION} -y
                terraform init
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
            post {
                always {
                    archiveArtifacts artifacts: 'tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                branch 'main'
            }
            input {
                message "Apply Terraform changes?"
                ok "Proceed"
            }
            steps {
                sh 'terraform apply tfplan'
            }
        }

        stage('Terraform Destroy (Optional)') {
            when {
                branch 'destroy'
            }
            input {
                message "Destroy Terraform resources?"
                ok "Proceed"
            }
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
