
data "aws_ec2_transit_gateway" "tgw_spoke" {
  id = var.tgw_id
}


resource "aws_ec2_transit_gateway_route" "route_to_hub" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = var.tgw_attach_id
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway.tgw_spoke.association_default_route_table_id
}
