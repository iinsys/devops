locals {
  # List of server names
  server_names = ["web1", "web2", "web3"]

  # Transform server names to uppercase using 'for' expression
  upper_server_names = [for name in local.server_names : upper(name)]

  # Create a map of server name to index using 'for' with index
  server_map = { for idx, name in local.server_names : name => idx }

  # Example of using for_each with a resource (null_resource for demonstration)
  # Uncomment the following block to use with real resources
  #resource "null_resource" "example" {
  #  for_each = toset(local.server_names)
  #  triggers = {
  #    name = each.key
  #  }
  #}
}

# Example 1: Using 'for' expression
# locals {
#   server_names = ["web1", "web2", "web3"]
#   upper_server_names = [for name in local.server_names : upper(name)]
#   server_map = { for idx, name in local.server_names : name => idx }
# }

# Example 2: Using 'for_each' with null_resource
# resource "null_resource" "server" {
#   for_each = toset(["web1", "web2", "web3"])
#   triggers = {
#     name = each.key
#   }
# }

# Example 3: Using 'count' with null_resource (active example)
resource "null_resource" "server" {
  count = length(["web1", "web2", "web3"])
  triggers = {
    name = ["web1", "web2", "web3"][count.index]
  }
}