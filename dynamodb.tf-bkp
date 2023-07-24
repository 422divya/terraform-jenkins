resource "aws_dynamodb_table" "db" {
   name = "state-db"
   billing_mode = "PAY_PER_REQUEST"
   hash_key = "LOCK_ID"

 attribute {
     name = "LOCK_ID"
     type= "S"
}

}
