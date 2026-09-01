variable "alert_email" {
  type        = string
  default     = null
  description = "The email address to send alerts to."
}

variable "onboard_alerts" {
  type        = bool
  default     = false
  description = "Whether to enable recommended alerts. Set to false to disable alerts even if monitoring is enabled and alert_email is provided."
  nullable    = false

  validation {
    condition     = !var.onboard_alerts || var.alert_email != null
    error_message = "When `onboard_alerts` is true, `alert_email` must be provided."
  }
}

variable "onboard_monitoring" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
Whether to enable monitoring resources. Set to false to disable monitoring even if workspace IDs are provided.
DESCRIPTION

  validation {
    condition     = !var.onboard_monitoring || try(var.addon_profile_oms_agent.config.log_analytics_workspace_resource_id, null) != null
    error_message = "When `onboard_monitoring` is true, enable oms addon and provide `log_analytics_workspace_resource_id`."
  }
}

variable "prometheus_workspace_id" {
  type        = string
  default     = null
  description = <<DESCRIPTION
The monitor workspace resource ID for managed Prometheus.

Make sure to to also specify `var.azure_monitor_profile`,
Ensure that `kube_state_metrics` are configured.
DESCRIPTION
}

variable "data_collection_endpoint_name" {
  type        = string
  default     = null
description = <<DESCRIPTION
Name for the MSProm data collection endpoint. Defaults to the generated name.
DESCRIPTION

  validation {
    condition     = var.data_collection_endpoint_name == null || try(length(var.data_collection_endpoint_name) <= 44, false)
    error_message = "Data collection endpoint names must not exceed 44 characters."
  }
}

variable "data_collection_rule_name" {
  type        = string
  default     = null
  description = <<DESCRIPTION
Name for the MSProm data collection rule. Defaults to the generated name.
DESCRIPTION

  validation {
    condition     = var.data_collection_rule_name == null || try(length(var.data_collection_rule_name) <= 44, false)
    error_message = "Data collection rule names must not exceed 44 characters."
  }
}

variable "container_insights_data_collection_rule_name" {
  type        = string
  default     = null
  description = <<DESCRIPTION
Name for the Container Insights data collection rule. Defaults to the generated name.
DESCRIPTION

  validation {
    condition     = var.container_insights_data_collection_rule_name == null || try(length(var.container_insights_data_collection_rule_name) <= 44, false)
    error_message = "Data collection rule names must not exceed 44 characters."
  }
}