module "rgs" {
    source = "../child/Resource_group"
    rg = var.rg
  
}
module "stg" {
    depends_on = [ module.rgs ]
    source = "../child/Storage_account"
    stg = var.stg
  
}
module "vnet" {
    depends_on = [ module.rgs ]
    source = "../child/Vnet"
    vnet = var.vnet
  
}

module "subnet" {
    source = "../child/subnet"
    subnet = var.subnet
    depends_on = [ module.vnet ]
  
}

module "virtual" {
    source = "../child/Virtual_machin"
    virtual = var.virtual
    depends_on = [ module.subnet ]
  
}