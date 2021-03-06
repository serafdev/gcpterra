provider "google" {
 credentials = file("gcp-service-account.json")
 project     = "some-project"
 region      = "us-west1"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "ultra-instinct-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "us-west1-a"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

metadata = {
   ssh-keys = "seraf:${file("~/.ssh/id_rsa.pub")}"
}


// Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; "

 network_interface {
   network = "default"
 }
}
