variable "absolute_paths" {
    type = list(string)
    description = "A list of absolute paths to resources (individual YAML files, or folders containing a kustomization.yaml) with base resources that the overlay should be applied to"
}



variable patches  {
    type = list(object({
      patch = optional(string)
      target = optional(object({
        group               = optional(string)
        version             = optional(string)
        kind                = optional(string)
        name                = optional(string)
        namespace           = optional(string)
        label_selector      = optional(string)
        annotation_selector = optional(string)
      }))
    }))
    default = []
}

variable secret_generators  {
    type = list(object({
      name      = optional(string)
      namespace = optional(string)
      behavior  = optional(string)
      type      = optional(string)
      envs      = optional(list(string))
      files     = optional(list(string))
      literals  = optional(list(string))
      options = optional(object({
        labels                   = optional(map(string))
        annotations              = optional(map(string))
        disable_name_suffix_hash = optional(bool)
      }))
    }))
    default = []
} 

variable "wait_for_workloads" {
    default = false
}

variable "wait_for_workloads_timeout_create" {
    default = "2m"
}

variable "wait_for_workloads_timeout_update" {
    default = "2m"
}
