variable "instance_name" {
  description = "The name of the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch the EC2 instance in."
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the EC2 instance."
  type        = list(string)
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance."
  type        = string
}

variable "user_data" {
  description = "The user data to provide when launching the EC2 instance."
  type        = string
  default     = ""
}

variable "root_block_device" {
  description = "Configuration for the root block device."
  type = list(object({
    volume_size = number
    volume_type = string
    encrypted   = bool
  }))
  default = [{
    volume_size = 8
    volume_type = "gp2"
    encrypted   = true
  }]
}

variable "tags" {
  description = "A map of tags to assign to the EC2 instance."
  type        = map(string)
  default     = {}
}
