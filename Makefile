.PHONY: test cover cover-html

test:
	go test ./...

cover:
	go test -cover ./...

cover-html:
	go test -coverprofile=coverage.out ./...
	findstr /V -v "test/" coverage.out | findstr /V -v "internal/domain/" | findstr /V -v "cmd/" | findstr /V -v "internal/handler/routes/" | findstr /V -v "docs/" > coverage.filtered
	go tool cover -html=coverage.filtered

run:
	go run ./cmd/main.go

init :
	cd infra && terraform init	

lambda.zip:
	GOOS=linux GOARCH=amd64 go build -o main ./cmd
	powershell Compress-Archive -Path main -DestinationPath infra/lambda.zip -Force

plan: lambda.zip
	cd infra && terraform plan

apply: lambda.zip
	cd infra && terraform apply