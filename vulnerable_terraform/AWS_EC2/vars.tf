variable "AWS_REGION" {
  type        = string
  description = "the AWS region to deploy to"
}

variable "PATH_TO_PRIVATE_KEY" {
  default     = "test-key"
  description = "the ssh private key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default     = "test-key.pub"
  description = "the SSH public key"
}

variable "AMIS" {
  type = map(string)
}
variable "INSTANCE_TYPE" {
  type        = string
  description = "type of ec2 instance to deploy onto"
}

variable "CIDR_BLOCK" {
  type        = string
  description = "CIDR block to use for the VPC"
}

variable "instance_name" {
  type        = string
  description = "Name of the EC2 instance"

}
