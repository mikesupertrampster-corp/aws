package handler

import (
	"context"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/service/ecs"
	"log"
)

type Handler interface {
	Run(ctx context.Context) error
}

type lambdaHander struct {
	svc         *ecs.ECS
	clusterName string
}

func NewLambdaHandler(svc *ecs.ECS, clusterName string) *lambdaHander {
	return &lambdaHander{
		clusterName: clusterName,
		svc:         svc,
	}
}

func (h lambdaHander) Run(ctx context.Context) error {
	input := &ecs.DeleteClusterInput{
		Cluster: aws.String(h.clusterName),
	}

	result, err := h.svc.DeleteClusterWithContext(ctx, input)
	if err != nil {
		if aerr, ok := err.(awserr.Error); ok {
			switch aerr.Code() {
			case ecs.ErrCodeResourceInUseException:
				log.Print(ecs.ErrCodeResourceInUseException, aerr.Error())
			case ecs.ErrCodeResourceNotFoundException:
				log.Print(aerr.Error())
				return nil
			case ecs.ErrCodeClientException:
				log.Print(ecs.ErrCodeClientException, aerr.Error())
			case ecs.ErrCodeServerException:
				log.Print(ecs.ErrCodeServerException, aerr.Error())
			default:
				log.Print(aerr.Error())
			}
		} else {
			err = err.(awserr.Error)
		}

		return err
	}

	log.Print(result)

	return nil
}
