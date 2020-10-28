# terraform-kinesis-cross-account-sync
Terraform Module to sync kinesis streams across two different AWS accounts


## Providers

| Name | Version |
|------|---------|
| archive | ~> 2.0 |
| aws | ~> 3.12 |
| aws.sink | ~> 3.12 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| sink\_streams | Comma separated list of streams to which source stream will be synced with. | `string` | n/a | yes |
| source\_stream | Streams with which sink streams will be synced | `string` | n/a | yes |

## Outputs

No output.

