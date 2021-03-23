resource "aws_dynamodb_table" "dynamodb_cadabraorders" {
  name           = "tf-CadabraOrders"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "CustomerID"
  range_key      = "OrderID"

  attribute {
    name = "CustomerID"
    type = "N"
  }
  attribute {
    name = "OrderID"
    type = "S"
  }

  tags = local.common_tags
}