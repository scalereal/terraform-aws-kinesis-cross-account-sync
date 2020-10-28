module "sync" {
  source        = "../"
  sink_streams  = var.sink_streams
  source_stream = var.source_stream
  service_name = var.service_name

  providers = {
    aws      = aws
    aws.sink = aws.sink
  }
}
