package handler

import (
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ecs"
)

func Create() Handler {
	config := NewConfigFromEnv()

	sess := session.Must(session.NewSession(&aws.Config{
		Region: aws.String(config.region),
	}))
	svc := ecs.New(sess)

	return NewLambdaHandler(svc, config.clusterName)
}
