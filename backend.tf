terraform {
  backend s3{
    bucket ="jenkins-ansible-terra"
    key = "remote.tfstate"
    region = "ap-south-1"
  }
}
