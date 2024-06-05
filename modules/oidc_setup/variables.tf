variable "circleci_org_id" {
  type        = string
  description = "The UUID formatted Organization ID from CircleCI"
}

variable "circleci_project_id" {
  type        = string
  description = "The UUID formatted Project ID from CircleCI"
}

variable "thumbprints" {
  type        = list(string)
  description = "The OIDC thumbprints used for the OIDC provider (default)"
  default     = ["06B25927C42A721631C1EFD9431E648FA62E1E39"]
}