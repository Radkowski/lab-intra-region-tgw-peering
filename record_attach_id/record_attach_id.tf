data "aws_ec2_transit_gateway_peering_attachment" "attachment" {
  filter {
    name   = "local-owner-id"
    values = [var.HubAccountID]
  }
  filter {
    name   = "remote-owner-id"
    values = [var.SpokeAccountID]
  }
  filter {
    name   = "state"
    values = ["pendingAcceptance"]
  }
}


resource "aws_ssm_parameter" "record_attachment_id" {
  name  = join("", ["/custom/tgwpeering/", var.SpokeAccountID, "/", var.tgw_id])
  type  = "String"
  value = data.aws_ec2_transit_gateway_peering_attachment.attachment.id
}
