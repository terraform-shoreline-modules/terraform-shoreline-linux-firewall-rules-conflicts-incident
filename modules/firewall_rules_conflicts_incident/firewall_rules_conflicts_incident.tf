resource "shoreline_notebook" "firewall_rules_conflicts_incident" {
  name       = "firewall_rules_conflicts_incident"
  data       = file("${path.module}/data/firewall_rules_conflicts_incident.json")
  depends_on = [shoreline_action.invoke_firewall_cleanup]
}

resource "shoreline_file" "firewall_cleanup" {
  name             = "firewall_cleanup"
  input_file       = "${path.module}/data/firewall_cleanup.sh"
  md5              = filemd5("${path.module}/data/firewall_cleanup.sh")
  description      = "Review firewall rules and remove any conflicting or redundant rules."
  destination_path = "/tmp/firewall_cleanup.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_firewall_cleanup" {
  name        = "invoke_firewall_cleanup"
  description = "Review firewall rules and remove any conflicting or redundant rules."
  command     = "`chmod +x /tmp/firewall_cleanup.sh && /tmp/firewall_cleanup.sh`"
  params      = ["PATH_TO_FIREWALL_CONFIG"]
  file_deps   = ["firewall_cleanup"]
  enabled     = true
  depends_on  = [shoreline_file.firewall_cleanup]
}

