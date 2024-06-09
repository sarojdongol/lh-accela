variable "circleci_org_id" {
  type        = string
  description = "The UUID formatted Organization ID from CircleCI"
  default     = "59d58a9e-1d8e-4430-b31f-df1ad3abc3d7"
}

variable "circleci_project_id" {
  type        = string
  description = "The UUID formatted Project ID from CircleCI"
  default     = "26d11f32-fded-45c1-915e-cd8023f53d27"
}

variable "thumbprints" {
  type        = list(string)
  description = "The OIDC thumbprints used for the OIDC provider (default)"
  default     = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
}