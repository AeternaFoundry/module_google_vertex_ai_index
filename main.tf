resource "google_vertex_ai_index" "vertex_ai_indices" {
  for_each = var.vertex_ai_indices

  display_name        = each.value.display_name
  deletion_policy     = each.value.deletion_policy
  description         = each.value.description
  index_update_method = each.value.index_update_method
  labels              = each.value.labels
  project             = each.value.project
  region              = each.value.region

  metadata {
    config {
      dynamic "algorithm_config" {
        for_each = each.value.metadata.config.algorithm_config != null ? [each.value.metadata.config.algorithm_config] : []
        content {
          dynamic "brute_force_config" {
            for_each = algorithm_config.value.brute_force_config != null ? [algorithm_config.value.brute_force_config] : []
            content {
            }
          }
          dynamic "tree_ah_config" {
            for_each = algorithm_config.value.tree_ah_config != null ? [algorithm_config.value.tree_ah_config] : []
            content {
              leaf_node_embedding_count    = tree_ah_config.value.leaf_node_embedding_count
              leaf_nodes_to_search_percent = tree_ah_config.value.leaf_nodes_to_search_percent
            }
          }
        }
      }
      approximate_neighbors_count = each.value.metadata.config.approximate_neighbors_count
      dimensions                  = each.value.metadata.config.dimensions
      distance_measure_type       = each.value.metadata.config.distance_measure_type
      feature_norm_type           = each.value.metadata.config.feature_norm_type
      shard_size                  = each.value.metadata.config.shard_size
    }
    contents_delta_uri    = each.value.metadata.contents_delta_uri
    is_complete_overwrite = each.value.metadata.is_complete_overwrite
  }

  dynamic "encryption_spec" {
    for_each = each.value.encryption_spec != null ? [each.value.encryption_spec] : []
    content {
      kms_key_name = encryption_spec.value.kms_key_name
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

