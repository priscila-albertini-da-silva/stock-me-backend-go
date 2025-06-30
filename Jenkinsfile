pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Go Mod Tidy') {
            steps {
                dir('cmd') {
                    bat 'go mod tidy'
                }
            }
        }

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

        stage('Build Lambda') {
            steps {
                bat 'go env -w GOOS=linux'
                bat 'go env -w GOARCH=amd64'
                bat 'go build -o main ./cmd'
                bat 'powershell Compress-Archive -Path main -DestinationPath infra/lambda.zip -Force'
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