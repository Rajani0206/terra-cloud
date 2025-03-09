#security group
resource "aws_security_group" "webserver_access" {
        name = "webserver_access"
        description = "allow ssh and http"

        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }


}

resource "aws_instance" "ourfirst" {
  ami           = "ami-07d2649d67dbe8900"
  availability_zone = "us-west-1a"
  instance_type = "t2.micro"
  user_data = filebase64("install_apache.sh")
  vpc_security_group_ids = [aws_security_group.webserver_access.id]  # Correct reference
  key_name               = "aksmr-tf"
  
  tags = {
    Name      = "ec2-test"
    Location  = "N.california"
  }
}

output "ec2_public_ip" {
  value = aws_instance.ourfirst.public_ip
  description = "Public IP of the EC2 instance"
}
