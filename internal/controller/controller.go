package controller

import (
	"github.com/aws/aws-lambda-go/events"
)

func Get(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{StatusCode: 200, Body: "Controller GET"}, nil
}

func Post(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{StatusCode: 201, Body: "Controller POST"}, nil
}

func Put(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{StatusCode: 200, Body: "Controller PUT"}, nil
}

func Delete(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{StatusCode: 204, Body: "Controller DELETE"}, nil
}
