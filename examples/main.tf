module "sync" {
  source        = "../"
  sink_streams  = var.sink_streams
  source_stream = var.source_stream

  providers = {
    aws      = aws
    aws.sink = aws.sink
  }
}
