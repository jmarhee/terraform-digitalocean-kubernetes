module "nodes" {
  source             = "./modules/node_pool"
  cluster_name       = "${var.cluster_name}"
  node_count         = "${var.node_count}"
  size               = "${var.node_size}"
  region             = "${var.region}"
  ssh_keys           = "${var.ssh_key_fingerprints}"
  kubernetes_version = "${var.kubernetes_version}"
  kube_token         = "${module.kube_token_1.token}"
  primary_node_ip    = "${module.controllers.controller_addresses}"
}
