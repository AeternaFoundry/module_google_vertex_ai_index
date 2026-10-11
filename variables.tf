variable "vertex_ai_indices" {
  description = <<EOT
Map of vertex_ai_indices, attributes below
Required:
    - display_name
    - metadata (block):
        - config (required, block):
            - algorithm_config (optional, block):
                - brute_force_config (optional, block):
                - tree_ah_config (optional, block):
                    - leaf_node_embedding_count (optional)
                    - leaf_nodes_to_search_percent (optional)
            - approximate_neighbors_count (optional)
            - dimensions (required)
            - distance_measure_type (optional)
            - feature_norm_type (optional)
            - shard_size (optional)
        - contents_delta_uri (optional)
        - is_complete_overwrite (optional)
Optional:
    - deletion_policy
    - description
    - index_update_method
    - labels
    - project
    - region
    - encryption_spec (block):
        - kms_key_name (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    display_name        = string
    deletion_policy     = optional(string)
    description         = optional(string)
    index_update_method = optional(string)
    labels              = optional(map(string))
    project             = optional(string)
    region              = optional(string)
    metadata = object({
      config = object({
        algorithm_config = optional(object({
          brute_force_config = optional(object({
          }))
          tree_ah_config = optional(object({
            leaf_node_embedding_count    = optional(number)
            leaf_nodes_to_search_percent = optional(number)
          }))
        }))
        approximate_neighbors_count = optional(number)
        dimensions                  = number
        distance_measure_type       = optional(string)
        feature_norm_type           = optional(string)
        shard_size                  = optional(string)
      })
      contents_delta_uri    = optional(string)
      is_complete_overwrite = optional(bool)
    })
    encryption_spec = optional(object({
      kms_key_name = string
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
}

