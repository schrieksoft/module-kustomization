# Simplification of https://github.com/kbst/catalog/blob/master/src/_terraform_module/data_source.tf

data "kustomization_overlay" "this" {
  resources = var.absolute_paths


  dynamic "secret_generator" {
    for_each = var.secret_generators != null ? var.secret_generators : []
    iterator = i
    content {
      name      = i.value["name"]
      namespace = i.value["namespace"]
      behavior  = i.value["behavior"]
      type      = i.value["type"]
      envs      = i.value["envs"]
      files     = i.value["files"]
      literals  = i.value["literals"]
      options {
        labels                   = lookup(i.value, "options") != null ? i.value["options"]["labels"] : null
        annotations              = lookup(i.value, "options") != null ? i.value["options"]["annotations"] : null
        disable_name_suffix_hash = lookup(i.value, "options") != null ? i.value["options"]["disable_name_suffix_hash"] : null
      }
    }
  }
  
  dynamic "patches" {
    for_each = var.patches!= null ? var.patches: []
    iterator = i
    content {
      patch = i.value["patch"]

      dynamic "target" {
        for_each = i.value["target"] != null ? toset([i.value["target"]]) : toset([])
        iterator = j
        content {
          group               = j.value["group"]
          version             = j.value["version"]
          kind                = j.value["kind"]
          name                = j.value["name"]
          namespace           = j.value["namespace"]
          label_selector      = j.value["label_selector"]
          annotation_selector = j.value["annotation_selector"]
        }
      }
    }
  }

}

