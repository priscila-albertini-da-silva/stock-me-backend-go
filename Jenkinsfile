pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Go Test') {
            steps {
                dir('cmd') {
                    bat 'go test ./... -v'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('infra') {
                    bat 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('infra') {
                    bat 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Deseja aplicar as mudanças?'
                dir('infra') {
                    bat 'terraform apply -auto-approve tfplan'
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