package handler

import (
	"context"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/eks"
	"testing"
)

func TestHandler(t *testing.T) {
	config := NewConfigFromEnv()

	sess := session.Must(session.NewSession(&aws.Config{
		Region: aws.String(config.region),
	}))
	svc := eks.New(sess)

	handler := NewLambdaHandler(svc, config.clusterName)

	err := handler.Run(context.Background())
	if err != nil {
		t.Fatal(err)
	}
}
