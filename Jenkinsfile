pipeline {
    agent any
    options {
        ansiColor('xterm')
    }

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
                bat 'go build -o bootstrap ./cmd'
                bat 'powershell Compress-Archive -Path bootstrap -DestinationPath infra/lambda.zip -Force'
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
                    script {
                        if (params.ACTION == 'apply') {
                            bat 'terraform apply -auto-approve tfplan'
                        } else if (params.ACTION == 'destroy') {
                            bat 'terraform destroy -auto-approve'
                        }
                    }
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