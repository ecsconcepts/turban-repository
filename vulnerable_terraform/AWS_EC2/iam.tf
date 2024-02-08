resource "aws_iam_role" "permissive_ec2_role" {
  name               = "permissive_ec2_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    description = "an overly permissive EC2 role"
    name        = "overly_permissive_ec2_role"
  }
}

resource "aws_iam_role_policy" "ec2_allow_all" {
  name = "ec2_allow_all"
  role ="${aws_iam_role.permissive_ec2_role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
