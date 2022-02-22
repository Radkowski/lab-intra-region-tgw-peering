module "SPOKETGW" {
  source           = "./spoke-tgw"
  providers        = { aws = aws.spoke }
  HubTGWID         = var.HubTGWID
  HubAccountID     = var.HubAccountID
  SpokeAccountID   = var.SpokeAccountID
  DeploymentRegion = var.DeploymentRegion
}

module "RECORD_ATTACH_ID" {
  source         = "./record_attach_id"
  depends_on     = [module.SPOKETGW]
  HubAccountID   = var.HubAccountID
  SpokeAccountID = var.SpokeAccountID
  tgw_id         = module.SPOKETGW.tgw_id
}


module "HUBTGW" {
  source           = "./hub-tgw"
  depends_on       = [module.RECORD_ATTACH_ID]
  HubAccountID     = var.HubAccountID
  SpokeAccountID   = var.SpokeAccountID
  SpokeCIDR        = var.SpokeCIDR
  HubTGWRouteTable = var.HubTGWRouteTable
  tgw_id           = module.SPOKETGW.tgw_id
}


module "SPOKE-ROUTING" {
  source        = "./spoke-routing"
  providers     = { aws = aws.spoke }
  depends_on    = [module.HUBTGW]
  tgw_attach_id = module.SPOKETGW.tgw_attach_id
  tgw_id        = module.SPOKETGW.tgw_id
}
