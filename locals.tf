locals {
  definitions = {
    tags = { ManagedBy = "Terraform" }
    validator_expressions = {

      resource_group_name  = "^.*$"
      virtual_network_name = "^.*$"

    }
    validator_error_messages = {
      resource_group_name  = "The value of \"resource_group_name\" must be a string following the displayed regular expression pattern."
      virtual_network_name = "The value of \"name\" must be a string following the displayed regular expression pattern."
    }
  }
}
