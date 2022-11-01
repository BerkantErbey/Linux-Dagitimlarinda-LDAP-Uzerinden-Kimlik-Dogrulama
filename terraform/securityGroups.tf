resource "aws_default_vpc" "myVPC" {
  # Bu kaynak aws tarafından içe aktarılacak.
}

resource "aws_security_group" "mySecurityGroup" {
  name        = "mySecGroup"
  description = "Allow SSH & LDAP"
  vpc_id      = aws_default_vpc.myVPC.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group_rule" "allowLDAP" {
  type        = "ingress"
  from_port   = 389
  to_port     = 389
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.mySecurityGroup.id
}

resource "aws_security_group_rule" "allowSSH" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.mySecurityGroup.id
}
