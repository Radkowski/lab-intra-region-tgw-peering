
data "aws_ssm_parameter" "recorded_attachment_id" {
  name = join("", ["/custom/tgwpeering/", var.SpokeAccountID, "/", var.tgw_id])
}


resource "aws_ec2_transit_gateway_peering_attachment_accepter" "tgwpeeringaccepter" {
  transit_gateway_attachment_id = data.aws_ssm_parameter.recorded_attachment_id.value
  tags = {
    Name = join("", ["Intra-Region-peering-from-", var.SpokeAccountID])
  }
}


resource "aws_ec2_transit_gateway_route" "route_to_spoke" {
  depends_on                     = [aws_ec2_transit_gateway_peering_attachment_accepter.tgwpeeringaccepter]
  destination_cidr_block         = var.SpokeCIDR
  transit_gateway_attachment_id  = data.aws_ssm_parameter.recorded_attachment_id.value
  transit_gateway_route_table_id = var.HubTGWRouteTable
}


resource "aws_ec2_transit_gateway_route_table_association" "associate_route" {
  depends_on                     = [aws_ec2_transit_gateway_route.route_to_spoke]
  transit_gateway_attachment_id  = data.aws_ssm_parameter.recorded_attachment_id.value
  transit_gateway_route_table_id = var.HubTGWRouteTable
}
