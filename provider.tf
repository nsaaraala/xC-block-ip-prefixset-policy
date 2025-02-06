terraform {
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.30"
    }
  }
}
provider "volterra" {
  api_p12_file     = "/Users/n.saaraala/terraform-volterra/f5cs-soc.console.ves.volterra.io.api-creds.p12"
  url              = "https://f5cs-soc.console.ves.volterra.io/api"
}