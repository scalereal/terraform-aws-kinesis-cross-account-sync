variable "service_name" {
  type        = string
  description = "Service name for which streams will be synced"
}

variable "source_stream" {
  type        = string
  description = "Streams with which sink streams will be synced"
}

variable "sink_streams" {
  type        = string
  description = "Comma separated list of streams to which source stream will be synced with."
}
