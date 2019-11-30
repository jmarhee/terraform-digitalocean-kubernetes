module "controllers" {
  source = "./modules/controller_pool"

  kube_token               = "${module.kube_token_1.token}"
  digitalocean_token       = "${var.digitalocean_token}"
  kubernetes_version       = "${var.kubernetes_version}"
  secrets_encryption       = "${var.secrets_encryption}"
  primary_size             = "${var.primary_size}"
  ssh_key_fingerprints     = "${var.ssh_key_fingerprints}"
  region                   = "${var.region}"
  cluster_name             = "${var.cluster_name}"
  digitalocean_ccm_release = "${var.digitalocean_ccm_release}"
}