provider "local" {
  # Configuration options
}


# create a file
resource "local_file" "first" {
  filename = "temp.txt"
  content  = "This is temp file"
}