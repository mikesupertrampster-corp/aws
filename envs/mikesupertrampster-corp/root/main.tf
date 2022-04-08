locals {
  scp = {
    root = {
      DenyUserCreation = [
        {
          effect    = "Deny"
          actions   = ["iam:CreateUser"]
          resources = ["*"]
        }
      ]
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}

resource "aws_organizations_organization" "org" {
  aws_service_access_principals = ["sso.amazonaws.com"]
  enabled_policy_types          = ["SERVICE_CONTROL_POLICY", "TAG_POLICY"]
}

data "aws_iam_policy_document" "scp" {
  for_each = local.scp.root

  dynamic "statement" {
    for_each = each.value
    content {
      effect    = statement.value["effect"]
      actions   = statement.value["actions"]
      resources = statement.value["resources"]
    }
  }
}

resource "aws_organizations_policy" "scp" {
  for_each = data.aws_iam_policy_document.scp
  name     = each.key
  content  = each.value.json
}

resource "aws_organizations_policy" "tag" {
  name     = "Mandatory"
  type     = "TAG_POLICY"
  content  = jsonencode({
    "tags": {
      "Environment": {
        "tag_key": {
          "@@assign": "Environment"
        },
        "tag_value": {
          "@@assign": concat(keys(var.accounts), ["root"])
        },
        "enforced_for": {
          "@@assign": [
            "amplifyuibuilder:component",
            "amplifyuibuilder:theme",
            "apigateway:apikeys",
            "apigateway:domainnames",
            "apigateway:restapis",
            "apigateway:stages",
            "appmesh:*",
            "appconfig:application",
            "appconfig:configurationprofile",
            "appconfig:deployment",
            "appconfig:deploymentstrategy",
            "appconfig:environment",
            "athena:*",
            "auditmanager:assessment",
            "auditmanager:assessmentControlSet",
            "auditmanager:assessmentFramework",
            "auditmanager:control",
            "backup:backupPlan",
            "backup:backupVault",
            "backup-gateway:gateway",
            "backup-gateway:hypervisor",
            "backup-gateway:vm",
            "batch:job",
            "batch:job-definition",
            "batch:job-queue",
            "bugbust:event",
            "acm:*",
            "acm-pca:certificate-authority",
            "chime:app-instance",
            "chime:app-instance-user",
            "chime:channel",
            "cloud9:environment",
            "cloudfront:*",
            "cloudtrail:*",
            "cloudwatch:*",
            "events:*",
            "logs:log-group",
            "codebuild:*",
            "codecommit:*",
            "codeguru-reviewer:association",
            "codepipeline:*",
            "codestar-connections:connection",
            "codestar-connections:host",
            "cognito-identity:*",
            "cognito-idp:*",
            "comprehend:*",
            "config:*",
            "connect:contact-flow",
            "connect:integration-association",
            "connect:queue",
            "connect:quick-connect",
            "connect:routing-profile",
            "connect:user",
            "dlm:policy",
            "directconnect:*",
            "dms:*",
            "dynamodb:*",
            "ec2:capacity-reservation",
            "ec2:client-vpn-endpoint",
            "ec2:customer-gateway",
            "ec2:dhcp-options",
            "ec2:elastic-ip",
            "ec2:fleet",
            "ec2:fpga-image",
            "ec2:host-reservation",
            "ec2:image",
            "ec2:instance",
            "ec2:internet-gateway",
            "ec2:launch-template",
            "ec2:natgateway",
            "ec2:network-acl",
            "ec2:network-interface",
            "ec2:reserved-instances",
            "ec2:route-table",
            "ec2:security-group",
            "ec2:snapshot",
            "ec2:spot-instance-request",
            "ec2:subnet",
            "ec2:traffic-mirror-filter",
            "ec2:traffic-mirror-session",
            "ec2:traffic-mirror-target",
            "ec2:volume",
            "ec2:vpc",
            "ec2:vpc-endpoint",
            "ec2:vpc-endpoint-service",
            "ec2:vpc-peering-connection",
            "ec2:vpn-connection",
            "ec2:vpn-gateway",
            "elasticfilesystem:*",
            "elastic-inference:accelerator",
            "eks:cluster",
            "elasticbeanstalk:application",
            "elasticbeanstalk:applicationversion",
            "elasticbeanstalk:configurationtemplate",
            "elasticbeanstalk:platform",
            "ecr:repository",
            "ecs:cluster",
            "ecs:service",
            "ecs:task-set",
            "elasticache:cluster",
            "es:domain",
            "elasticloadbalancing:*",
            "elasticmapreduce:cluster",
            "elasticmapreduce:editor",
            "firehose:*",
            "frauddetector:detector",
            "frauddetector:detector-version",
            "frauddetector:model",
            "frauddetector:rule",
            "frauddetector:variable",
            "fsx:*",
            "globalaccelerator:accelerator",
            "greengrass:bulkDeployment",
            "greengrass:connectorDefinition",
            "greengrass:coreDefinition",
            "greengrass:deviceDefinition",
            "greengrass:functionDefinition",
            "greengrass:loggerDefinition",
            "greengrass:resourceDefinition",
            "greengrass:subscriptionDefinition",
            "guardduty:detector",
            "guardduty:filter",
            "guardduty:ipset",
            "guardduty:threatintelset",
            "healthlake:datastore",
            "iam:instance-profile",
            "iam:mfa",
            "iam:oidc-provider",
            "iam:policy",
            "iam:saml-provider",
            "iam:server-certificate",
            "inspector2:filter",
            "iotanalytics:*",
            "iotevents:*",
            "iotsitewise:asset",
            "iotsitewise:asset-model",
            "iotfleethub:application",
            "kinesisanalytics:*",
            "kms:*",
            "lambda:*",
            "macie2:custom-data-identifier",
            "mediastore:container",
            "mq:broker",
            "mq:configuration",
            "network-firewall:firewall",
            "network-firewall:firewall-policy",
            "network-firewall:stateful-rulegroup",
            "network-firewall:stateless-rulegroup",
            "organizations:account",
            "organizations:ou",
            "organizations:policy",
            "organizations:root",
            "rbin:rule",
            "rds:cluster-endpoint",
            "rds:cluster-pg",
            "rds:db-proxy",
            "rds:db-proxy-endpoint",
            "rds:es",
            "rds:og",
            "rds:pg",
            "rds:ri",
            "rds:secgrp",
            "rds:subgrp",
            "rds:target-group",
            "redshift:*",
            "ram:*",
            "resource-groups:*",
            "route53:hostedzone",
            "route53resolver:*",
            "s3:bucket",
            "sagemaker:action",
            "sagemaker:app-image-config",
            "sagemaker:artifact",
            "sagemaker:context",
            "sagemaker:experiment",
            "sagemaker:flow-definition",
            "sagemaker:human-task-ui",
            "sagemaker:model-package",
            "sagemaker:model-package-group",
            "sagemaker:pipeline",
            "sagemaker:processing-job",
            "sagemaker:project",
            "sagemaker:training-job",
            "secretsmanager:*",
            "servicecatalog:application",
            "servicecatalog:attributeGroup",
            "servicecatalog:portfolio",
            "servicecatalog:product",
            "sns:topic",
            "sqs:queue",
            "ssm-contacts:contact",
            "states:*",
            "storagegateway:*",
            "ssm:automation-execution",
            "ssm:document",
            "ssm:maintenancewindowtask",
            "ssm:managed-instance",
            "ssm:opsitem",
            "ssm:patchbaseline",
            "ssm:session",
            "transfer:server",
            "transfer:user",
            "transfer:workflow",
            "wellarchitected:workload",
            "wisdom:assistant",
            "wisdom:association",
            "wisdom:content",
            "wisdom:knowledge-base",
            "wisdom:session",
            "worklink:fleet",
            "workspaces:*"
          ]
        }
      }
    }
  })
}

resource "aws_organizations_organizational_unit" "units" {
  for_each  = var.organisation_units
  name      = each.key
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_policy_attachment" "tags" {
  policy_id = aws_organizations_policy.tag.id
  target_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_policy_attachment" "root" {
  for_each  = local.scp.root
  policy_id = aws_organizations_policy.scp[each.key].id
  target_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_account" "accounts" {
  for_each  = var.accounts
  parent_id = aws_organizations_organizational_unit.units[each.value["organisation_unit"]].id
  name      = each.key
  role_name = var.bootstrap_role
  email     = format(var.organisation_email_pattern, each.key)
}