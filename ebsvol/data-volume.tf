resource "aws_ebs_volume" "data-vol" {
 availability_zone = "us-west-2a"
 size = 5
 tags = { 
           Name = "data-volume",
           Server = "mydemo",
           Mounting = "/apps",
           Owner = "appadmin"
        }
}
