output "controller_addresses" {
  description = "Kubernetes Controller IP Addresses"
  value       = "${digitalocean_droplet.k8s_primary.ipv4_address_private}"
}