terraform {
  backend "s3" {
    bucket       = "practise-ecs-tf-statefile"
    key          = "ECS/tf-statefiles"
    region       = "eu-west-2"
    use_lockfile = true
  }
}