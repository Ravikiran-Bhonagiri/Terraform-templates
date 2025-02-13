resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  vpc_security_group_ids = var.security_group_ids

  user_data = var.user_data

  root_block_device {
    volume_size = var.root_block_device[0].volume_size
    volume_type = var.root_block_device[0].volume_type
    encrypted   = var.root_block_device[0].encrypted
  }

  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )
}
