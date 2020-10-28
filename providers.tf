provider "aws" {
  region  = var.aws_region
  profile = var.source_aws_profile
}

provider "aws" {
  alias   = "sink"
  region  = var.aws_region
  profile = var.sink_aws_profile
}