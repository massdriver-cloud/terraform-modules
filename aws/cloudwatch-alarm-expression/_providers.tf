terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    massdriver = {
      source = "massdriver-cloud/massdriver"
    }
  }
}
