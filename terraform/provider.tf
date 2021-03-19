terraform {
  backend "remote" {
    organization = "DevOps-Marathone"

    workspaces {
      name = "terraform"
    }
  }
}