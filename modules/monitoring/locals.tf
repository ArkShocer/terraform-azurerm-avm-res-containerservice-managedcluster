locals {
  aks_cluster_name                           = basename(var.aks_cluster_id)
  msprom_data_collection_legacy_name         = "MSProm-${var.location}-${local.aks_cluster_name}"
  msprom_data_collection_name                = length(local.msprom_data_collection_legacy_name) <= 44 ? local.msprom_data_collection_legacy_name : local.msprom_data_collection_truncated_name
  msprom_data_collection_name_prefix         = "MSProm-${var.location}-"
  msprom_data_collection_truncated_name      = "${local.msprom_data_collection_name_prefix}${local.msprom_data_collection_truncated_name_part}-${local.name_hash}"
  msprom_data_collection_truncated_name_part = trimsuffix(substr(local.aks_cluster_name, 0, max(1, 44 - length(local.msprom_data_collection_name_prefix) - 1 - length(local.name_hash))), "-")
  name_hash                                  = substr(sha1(local.aks_cluster_name), 0, 8)
  data_collection_parent_id                  = coalesce(var.data_collection_parent_id, var.parent_id)
  dce_msprom_name                            = coalesce(var.data_collection_endpoint_name, local.msprom_data_collection_name)
  dcr_msprom_name                            = coalesce(var.data_collection_rule_name, local.msprom_data_collection_name)
  dcr_msci_name                              = coalesce(var.container_insights_data_collection_rule_name, "MSCI-${var.location}-${basename(var.aks_cluster_id)}")
}
