resource "aws_eip" "mydemo" {
    vpc = true
    tags = {
       "Name" = "mydemo"
       "Application" = "vpsa"
       }
    }
