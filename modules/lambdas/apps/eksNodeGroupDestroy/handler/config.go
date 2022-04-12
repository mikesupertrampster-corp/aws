package handler

import (
	"github.com/vrischmann/envconfig"
	"log"
)

type config struct {
	clusterName   string
	nodeGroupName string
	region        string
}

type cfg struct {
	Region string `envconfig:"default=eu-west-1"`

	Cluster struct {
		Name string `envconfig:"default=EKS"`
	}

	NodeGroup struct {
		Name string `envconfig:"default=PublicNodeGroup"`
	}
}

func NewConfigFromEnv() *config {
	c := new(cfg)
	if err := envconfig.Init(c); err != nil {
		log.Fatal(err)
	}

	return &config{
		clusterName:   c.Cluster.Name,
		nodeGroupName: c.NodeGroup.Name,
		region:        c.Region,
	}
}
