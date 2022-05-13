# Terraform AWS

AWS Setup via Terraform

[![Snyk Infrastructure as Code](https://github.com/mikesupertrampster-corp/terraform-aws/actions/workflows/snyk.yml/badge.svg)](https://github.com/mikesupertrampster-corp/terraform-aws/actions/workflows/snyk.yml) [![gitleaks](https://github.com/mikesupertrampster-corp/terraform-aws/actions/workflows/gitleaks.yml/badge.svg)](https://github.com/mikesupertrampster-corp/terraform-aws/actions/workflows/gitleaks.yml) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/dc37d227008e41599d57147023f27149)](https://www.codacy.com/gh/mikesupertrampster-corp/terraform-aws/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=mikesupertrampster-corp/terraform-aws&amp;utm_campaign=Badge_Grade) [![Infracost estimate](https://img.shields.io/badge/Infracost-estimate-5e3f62)](https://dashboard.infracost.io/share/dyq8y7axc264g8xoyw2p2b26tdk58sev)

## Cost

Estimate cost generated using [Infracost](https://github.com/Infracost/infracost)

```
 Name                                                            Monthly Qty  Unit                  Monthly Cost 
                                                                                                                 
 aws_lb.alb                                                                                                      
 ├─ Application load balancer                                            730  hours                       $18.40 
 └─ Load balancer capacity units                            Monthly cost depends on usage: $5.84 per LCU         
                                                                                                                 
 aws_route53_record.sub                                                                                          
 ├─ Standard queries (first 1B)                             Monthly cost depends on usage: $0.40 per 1M queries  
 ├─ Latency based routing queries (first 1B)                Monthly cost depends on usage: $0.60 per 1M queries  
 └─ Geo DNS queries (first 1B)                              Monthly cost depends on usage: $0.70 per 1M queries  
                                                                                                                 
 aws_route53_record.verify["*.dev.mikesupertrampster.com"]                                                       
 ├─ Standard queries (first 1B)                             Monthly cost depends on usage: $0.40 per 1M queries  
 ├─ Latency based routing queries (first 1B)                Monthly cost depends on usage: $0.60 per 1M queries  
 └─ Geo DNS queries (first 1B)                              Monthly cost depends on usage: $0.70 per 1M queries  
                                                                                                                 
 aws_route53_zone.sub                                                                                            
 └─ Hosted zone                                                            1  months                       $0.50 
                                                                                                                 
 Project total                                                                                            $18.90 

──────────────────────────────────
Project: mikesupertrampster-corp/terraform-aws/envs/mikesupertrampster-corp/root (/home/mike/Dev/terraform-aws/envs/mikesupertrampster-corp/root)

 Name           Monthly Qty  Unit  Monthly Cost 
                                                
 Project total                            $0.00 

 OVERALL TOTAL                           $18.90 
──────────────────────────────────
44 cloud resources were detected:
∙ 4 were estimated, 2 of which include usage-based costs, see https://infracost.io/usage-file
∙ 30 were free:
  ∙ 6 x aws_route_table_association
  ∙ 6 x aws_subnet
  ∙ 3 x aws_security_group_rule
  ∙ 2 x aws_route_table
  ∙ 1 x aws_acm_certificate
  ∙ 1 x aws_acm_certificate_validation
  ∙ 1 x aws_ecs_cluster
  ∙ 1 x aws_ecs_cluster_capacity_providers
  ∙ 1 x aws_iam_account_alias
  ∙ 1 x aws_iam_account_password_policy
  ∙ 1 x aws_iam_role
  ∙ 1 x aws_iam_role_policy
  ∙ 1 x aws_internet_gateway
  ∙ 1 x aws_lb_listener
  ∙ 1 x aws_route
  ∙ 1 x aws_security_group
  ∙ 1 x aws_vpc
  ∙ 2 x aws_organizations_organizational_unit
  ∙ 2 x aws_organizations_policy
  ∙ 2 x aws_organizations_policy_attachment
  ∙ 1 x aws_organizations_account
  ∙ 1 x aws_organizations_organization
  ∙ 1 x aws_ssoadmin_managed_policy_attachment
  ∙ 1 x aws_ssoadmin_permission_set
```