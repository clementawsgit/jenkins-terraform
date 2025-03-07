pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages{
        stage('Checkout SCM'){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/clementawsgit/jenkins-terraform.git']])
                }
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
                sh 'terraform plan -out=tfplan'
            }
            post {
                always {
                    archiveArtifacts artifacts: 'tfplan' //Archive the plan for review
                }
            }
        }

        stage('Terraform Apply') {
            when {
                branch 'main' // Example: Only apply on main branch
            }
            input {
                message "Approve Terraform Apply?"
                ok "Proceed"
                submitterParameter 'APPROVED_BY'
            }
            steps {
                sh 'terraform apply -auto-approve tfplan'
                echo "Terraform Apply completed by ${APPROVED_BY}"
            }
        }

        stage('Terraform Destroy') {
            when {
                branch 'destroy' //Example: Only run destroy on a destroy branch.
            }
            input {
               message "Confirm Terraform Destroy?"
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
