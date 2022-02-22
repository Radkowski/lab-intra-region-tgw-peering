resource "aws_ec2_transit_gateway" "SpokeTGW" {
  description = "TypeDTGW"
}


resource "aws_ec2_transit_gateway_peering_attachment" "tgwpeerattach" {
  peer_account_id         = var.HubAccountID
  peer_region             = var.DeploymentRegion
  peer_transit_gateway_id = var.HubTGWID
  transit_gateway_id      = aws_ec2_transit_gateway.SpokeTGW.id

  tags = {
    Name = join("", ["Intra-Region-peering-to-", var.HubAccountID])
  }
}


output "tgw_id" {
  value = aws_ec2_transit_gateway.SpokeTGW.id
}


output "tgw_attach_id" {
  value = aws_ec2_transit_gateway_peering_attachment.tgwpeerattach.id
}
