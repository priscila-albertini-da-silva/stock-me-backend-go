pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/priscila-albertini-da-silva/stock-me-backend-go.git'
            }
        }

        stage('Go Test') {
            steps {
                dir('cmd') {
                    sh 'go test ./... -v'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('infra') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('infra') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Deseja aplicar as mudanças?'
                dir('infra') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        failure {
            echo 'Pipeline falhou!'
        }
    }
}
