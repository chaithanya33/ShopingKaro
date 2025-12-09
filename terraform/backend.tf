terraform {
  backend "s3" {
    bucket       = "ct-s3-state-backend"
    key          = "shopingkaro-terraform"
    region       = "eu-north-1"
    use_lockfile = true
  }
}