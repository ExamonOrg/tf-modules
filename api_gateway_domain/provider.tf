provider "aws" {
  region = "eu-west-1"
  alias  = "eu_west_1"
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
