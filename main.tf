terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "firewall_rules_conflicts_incident" {
  source    = "./modules/firewall_rules_conflicts_incident"

  providers = {
    shoreline = shoreline
  }
}