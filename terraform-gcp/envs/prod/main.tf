module "network" {
  source       = "../../modules/network"
  network_name = "prod-vpc"
  subnet_name  = "prod-subnet"
  subnet_cidr  = "10.30.1.0/24"
  region       = var.region
}

module "compute" {
  source        = "../../modules/compute"
  instance_name = "prod-vm"
  machine_type  = "e2-micro"
  zone          = var.zone
  image         = "debian-cloud/debian-12"
  network       = module.network.network_name
  subnetwork    = module.network.subnet_name
}

module "storage" {
  source      = "../../modules/storage"
  bucket_name = "prod-bucket-${var.project_id}"
  location    = var.region
}

module "iam" {
  source        = "../../modules/iam"
  account_id    = "prod-sa"
  display_name  = "Prod Service Account"
}
