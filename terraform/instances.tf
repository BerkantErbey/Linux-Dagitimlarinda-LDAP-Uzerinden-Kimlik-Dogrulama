terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "terraformUser"
}

resource "aws_key_pair" "myKey" {
  key_name   = "mySSHKey"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICT1k5NTCYPbi19DKDUvJQ8V9pkVFvCK8FZaXhv8bJty berkant@ryzen"
}

resource "aws_instance" "ldap" {
  ami                    = "ami-09a41e26df464c548"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mySecurityGroup.id]
  key_name               = aws_key_pair.myKey.key_name

  tags = {
    Name = "LDAPServer"
  }
}

resource "aws_instance" "test02" {
  ami                    = "ami-09a41e26df464c548"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mySecurityGroup.id]
  key_name               = aws_key_pair.myKey.key_name

  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "test03" {
  ami                    = "ami-09a41e26df464c548"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mySecurityGroup.id]
  key_name               = aws_key_pair.myKey.key_name

  tags = {
    Name = "testDeb11"
  }
}

output "ldapServerPublicIP" {
  value = "${aws_instance.ldap.public_ip}"
}

output "clientPublicIP" {
  value = "${aws_instance.test03.public_ip}"
}

output "ldapServerPrivateIP" {
  value = "${aws_instance.ldap.private_ip}"
}

output "clientPrivateIP" {
  value = "${aws_instance.test03.private_ip}"
}