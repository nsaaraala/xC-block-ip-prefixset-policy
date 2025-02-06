data "local_file" "ips" {
  filename = "ips.txt"
}

locals {
  ip_list       = [for ip in split("\n", trimspace(data.local_file.ips.content)) : "${ip}/32"]
  chunk_size    = 1024
  chunked_ips   = [for i in range(0, length(local.ip_list), local.chunk_size) : slice(local.ip_list, i, min(i + local.chunk_size, length(local.ip_list)))]

  # Correct list comprehension to generate prefix set names
  prefix_set_names = [for i in range(0, length(local.chunked_ips)) : format("terraform-denylist-%d-prefix-set", i)]
}

resource "volterra_ip_prefix_set" "example" {
  for_each = { for i, chunk in local.chunked_ips : i => chunk }

  name      = format("terraform-denylist-%d-prefix-set", each.key)
  namespace = "naveen"
  prefix    = each.value
}

resource "volterra_service_policy" "blocked" {
  
  name      = "terraform-ip-block-service-policy"
  namespace = "naveen"
  algo      = "FIRST_MATCH"
  deny_list {
    
    # Dynamically reference all prefix set names using a loop
    dynamic "ip_prefix_set" {
      for_each = toset(local.prefix_set_names)
      content {
        name = ip_prefix_set.value
      }
    }
    
  }
}
