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

variable "source_stream" {
  type        = string
  description = "Streams with which sink streams will be synced"
}

variable "sink_streams" {
  type        = string
  description = "Comma separated list of streams to which source stream will be synced with."
}
