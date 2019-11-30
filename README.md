Kubernetes on DigitalOcean
===

[![Build Status](https://cloud.drone.io/api/badges/packet-labs/packet-multiarch-k8s-terraform/status.svg)](https://cloud.drone.io/packet-labs/packet-multiarch-k8s-terraform)

This is a [Terraform](https://www.terraform.io/docs/providers/digitalocean/index.html) project for deploying Kubernetes on DigitalOcean with an emphasis on node-pool management operations.

This project configures your cluster with the DigitalOcean Cloud Controller Manager and Container Storage Interface.

Node Pool Management
-

To instantiate a new node pool **after initial spinup**, in `3-kube-node.tf1`, define a pool using the node pool module like this:

```hcl
module "nodes_green" {
  source             = "./modules/node_pool"
  cluster_name       = "${var.cluster_name}"
  pool_label         = "green"
  node_count         = "${var.node_count}"
  size               = "${var.node_size}"
  region             = "${var.region}"
  ssh_keys           = "${var.ssh_key_fingerprints}"
  kubernetes_version = "${var.kubernetes_version}"
  kube_token         = "${module.kube_token_1.token}"
  primary_node_ip    = "${module.controllers.controller_addresses}"
}
```
where the label is `green` (rather than the initial pool, `blue`) and then, generate a new `kube_token` (ensure the module name matches the `kube_token` field in the spec above, i.e. `kube_token_2`) by defining this in `1-provider.tf` (or anywhere before the node_pool instantiation):

```hcl
module "kube_token_2" {
  source = "modules/kube-token"
}
```
Generate your new token:
```
terraform apply -target=module.kube_token_2
```
On your controller, [add your new token](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-token/#cmd-token-create), and then apply the new node pool:
```
terraform apply -target=module.node_pool_green
```
At which point, you can either destroy the old pool, or taint/evict pods, etc. once this new pool connects.

Secrets Encryption
-

To enable at-rest `Secret` resource encryption, apply Terraform with the `secrets_encryption` variable set to `"yes"`