module "policies" {
  source = "./policies"
  environment = var.environment
}

module "groups" {
  source = "./groups"
  environment = var.environment
}
