provider "google" {
  #credentials = "${file("terraform-key.json")}"
  project = "idyllic-slice-422610-p1"
  region  = "us-east4"
}

terraform {
  backend "gcs" {
    bucket = "tf-backend-wif"
  #  prefix = "terraform/state"
  }
}