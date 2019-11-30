variable "kube_token" {}
variable "digitalocean_token" {}
variable "kubernetes_version" {}
variable "secrets_encryption" {}
variable "primary_size" {}
variable "ssh_key_fingerprints" {}
variable "region" {}
variable "cluster_name" {}
variable "digitalocean_ccm_release" {}

data "template_file" "controller" {
  template = "${file("${path.module}/controller.tpl")}"

  vars = {
    kube_token         = "${var.kube_token}"
    do_token           = "${var.digitalocean_token}"
    ccm_version        = "${var.digitalocean_ccm_release}"
    kube_version       = "${var.kubernetes_version}"
    secrets_encryption = "${var.secrets_encryption}"
  }
}

resource "digitalocean_droplet" "k8s_primary" {
  name               = "${var.cluster_name}-primary"
  image              = "ubuntu-18-04-x64"
  size               = "${var.primary_size}"
  region             = "${var.region}"
  backups            = "true"
  private_networking = "true"
  ssh_keys           = "${var.ssh_key_fingerprints}"
  user_data          = "${data.template_file.controller.rendered}"
}
