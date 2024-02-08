resource "aws_instance" "my-test" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  tags = {
    Name        = "${var.instance_name}-test-bastion-${random_string.ec2_suffix.result}",
    Description = "${var.instance_name}-test-bastion-${random_string.ec2_suffix.result}"
  }

  # the VPC subnet
  subnet_id = aws_subnet.test-public-1.id

  # instance profile
  iam_instance_profile = aws_iam_instance_profile.permissive_ec2.name

  # the security group
  vpc_security_group_ids = [aws_security_group.test-allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.test-key.key_name

  user_data = file("${path.module}/startup.sh")
}

resource "aws_iam_instance_profile" "permissive_ec2" {
  name = "permissive_ec2"
  role = aws_iam_role.permissive_ec2_role.name
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "${var.AWS_REGION}a"
  size              = 20
  type              = "gp2"
  tags = {
    description = "Storage for EC2"
    Name        = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.test.id
}

output "bastion_host_public_ip" {
  value = aws_instance.test.public_ip
}

resource "random_string" "ec2_suffix" {
  length  = 4
  special = false
}
