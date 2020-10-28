# terraform-kinesis-cross-account-sync
Terraform Module to sync kinesis streams across two different AWS accounts
## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | ~> 3.12 |
| aws.sink | ~> 3.12 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_region | AWS region in which resources will be provisioned | `string` | n/a | yes |
| sink\_aws\_profile | AWS profile with which resources will be provisioned in the sink account | `string` | n/a | yes |
| source\_aws\_profile | AWS profile with which resources will be provisioned | `string` | n/a | yes |

## Outputs

No output.

