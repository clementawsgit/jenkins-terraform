pipeline {
    agent any
    tools {
      terraform 'Terraform'
    }
    environment {
      TF_IN_AUTOMATION = "TRUE"
      AWS_ACCESS_KEY_ID = credentials('aws_access_key')
      AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
    }
    stages {
        stage('Terraform Init'){
            steps{
                dir(postgres/dev){
                    sh 'terraform init'
                }
                
            }
        }
        stage('Terraform Apply'){
            steps{
                dir(postgres/dev){
                    sh 'terraform apply'
                }
            }
        }
    }
}
