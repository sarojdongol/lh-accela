module "oidc" {
  source              = "../modules/oidc_setup/"
  circleci_org_id     = "59d58a9e-1d8e-4430-b31f-df1ad3abc3d7"
  circleci_project_id = "26d11f32-fded-45c1-915e-cd8023f53d27"
}