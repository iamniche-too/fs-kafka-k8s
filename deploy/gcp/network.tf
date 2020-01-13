resource "google_compute_network" "vpc_network" {
  name = "kafka-cluster-vpc"
  auto_create_subnetworks = "false"
}

# https://www.terraform.io/docs/providers/google/r/compute_subnetwork.html
resource "google_compute_subnetwork" "vpc_subnetwork" {
  # The name of the resource, provided by the client when initially creating
  # the resource. The name must be 1-63 characters long, and comply with
  # RFC1035. Specifically, the name must be 1-63 characters long and match the
  # regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the first
  # character must be a lowercase letter, and all following characters must be
  # a dash, lowercase letter, or digit, except the last character, which
  # cannot be a dash.
  #name = "default-${var.gcp_cluster_region}"
  name = "kafka-cluster-vpc-subnet" 

  ip_cidr_range = "10.0.16.0/20" 

  # The network this subnet belongs to. Only networks that are in the
  # distributed mode can have subnetworks.
  network = "kafka-cluster-vpc"

  # Configurations for secondary IP ranges for VM instances contained in this
  # subnetwork. The primary IP of each VM must belong to the primary ipCidrRange
  # of the subnetwork. The alias IPs may belong to either primary or secondary
  # ranges.
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.16.0.0/12"
  }
  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.1.0.0/20" 
  }

  # When enabled, VMs in this subnetwork without external IP addresses can
  # access Google APIs and services by using Private Google Access. This is
  # set explicitly to prevent Google's default from fighting with Terraform.
  private_ip_google_access = true

  depends_on = [
    google_compute_network.vpc_network,
  ]
}
