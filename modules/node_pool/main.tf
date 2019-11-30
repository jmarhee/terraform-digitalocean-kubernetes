variable cluster_name {}
variable node_count {}
variable size {}
variable region {}
variable ssh_keys {}
variable kubernetes_version {}
variable kube_token {}
variable primary_node_ip {}

data "template_file" "node" {
  template = "${file("${path.module}/node.tpl")}"

  vars = {
    kube_token      = "${var.kube_token}"
    primary_node_ip = "${var.primary_node_ip}"
    kube_version    = "${var.kubernetes_version}"
  }
}

resource "digitalocean_droplet" "k8s_node" {
  name               = "${format("${var.cluster_name}-node-%02d", count.index)}"
  image              = "ubuntu-18-04-x64"
  count              = "${var.node_count}"
  size               = "${var.size}"
  region             = "${var.region}"
  private_networking = true
  ipv6               = true
  ssh_keys           = "${var.ssh_keys}"
  user_data          = "${data.template_file.node.rendered}"
}
