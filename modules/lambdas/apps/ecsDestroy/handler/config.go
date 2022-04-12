package handler

import (
	"github.com/vrischmann/envconfig"
	"log"
)

type config struct {
	clusterName string
	region      string
}

type cfg struct {
	Region string `envconfig:"default=eu-west-1"`

	Cluster struct {
		Name string `envconfig:"default=dev"`
	}
}

func NewConfigFromEnv() *config {
	c := new(cfg)
	if err := envconfig.Init(c); err != nil {
		log.Fatal(err)
	}

	return &config{
		clusterName: c.Cluster.Name,
		region:      c.Region,
	}
}
