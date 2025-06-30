package main

import (
	"context"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/priscila-albertini-da-silva/stock-me-storage-location/internal/controller"
)

func handler(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	switch req.HTTPMethod {
	case "GET":
		return handleGet(req)
	case "POST":
		return handlePost(req)
	case "PUT":
		return handlePut(req)
	case "DELETE":
		return handleDelete(req)
	default:
		return events.APIGatewayProxyResponse{StatusCode: 405, Body: "Method Not Allowed"}, nil
	}
}

func main() {
	lambda.Start(handler)
}

func handleGet(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return controller.Get(req)
}

func handlePost(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return controller.Post(req)
}

func handlePut(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return controller.Put(req)
}

func handleDelete(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return controller.Delete(req)
}
