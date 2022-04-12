package handler

import (
	"context"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/service/eks"
	"log"
)

type Handler interface {
	Run(ctx context.Context) error
}

type lambdaHander struct {
	svc         *eks.EKS
	clusterName string
}

func NewLambdaHandler(svc *eks.EKS, clusterName string) *lambdaHander {
	return &lambdaHander{
		clusterName: clusterName,
		svc:         svc,
	}
}

func (h lambdaHander) Run(ctx context.Context) error {
	input := &eks.DeleteClusterInput{
		Name: aws.String(h.clusterName),
	}

	result, err := h.svc.DeleteClusterWithContext(ctx, input)
	if err != nil {
		if aerr, ok := err.(awserr.Error); ok {
			switch aerr.Code() {
			case eks.ErrCodeResourceInUseException:
				log.Print(eks.ErrCodeResourceInUseException, aerr.Error())
			case eks.ErrCodeResourceNotFoundException:
				log.Print(aerr.Error())
				return nil
			case eks.ErrCodeClientException:
				log.Print(eks.ErrCodeClientException, aerr.Error())
			case eks.ErrCodeServerException:
				log.Print(eks.ErrCodeServerException, aerr.Error())
			case eks.ErrCodeServiceUnavailableException:
				log.Print(eks.ErrCodeServiceUnavailableException, aerr.Error())
			default:
				log.Print(aerr.Error())
			}
		} else {
			err = err.(awserr.Error)
		}

		return err
	}

	log.Print(result)
	return err
}
