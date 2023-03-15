resource "google_pubsub_schema" "user_creation" {
  name = "user-creation"
  type = "AVRO"
  definition = "{\r\n \"type\" : \"record\",\r\n \"name\" : \"Avro\",\r\n \"fields\" : [\r\n   {\r\n     \"name\": \"id\",\r\n     \"type\": \"long\"\r\n   },\r\n   {\r\n     \"name\" : \"name\",\r\n     \"type\" : \"string\"\r\n   },\r\n   {\r\n     \"name\": \"email\",\r\n     \"type\": \"string\"\r\n   }\r\n ]\r\n}\r\n"
}

resource "google_pubsub_topic" "user_creation" {
  name = "user-creation"

  depends_on = [google_pubsub_schema.user_creation]
  schema_settings {
    schema = "projects/${var.project}/schemas/user-creation"
    encoding = "JSON"
  }
}