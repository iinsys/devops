#root

module "vpc" {
  source = "./vpc"
  vpc_cidr = "10.0.0.0/16"
  ext_ip = "0.0.0.0/0"
  pb_cidr = "10.0.1.0/24"
}

module "ec2" {
  source = "./web"
  sn = module.vpc.pb_sn
  sg = module.vpc.sg
}
