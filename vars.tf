variable "aws_region" {
  type        = string
  description = "AWS region in which resources will be provisioned"
}

variable "source_aws_profile" {
  type        = string
  description = "AWS profile with which resources will be provisioned"
}

variable "sink_aws_profile" {
  type        = string
  description = "AWS profile with which resources will be provisioned in the sink account"
}
