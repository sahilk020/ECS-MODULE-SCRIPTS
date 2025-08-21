resource "aws_instance" "ecs-mongo-instance" {
  ami                    = "ami-062f0cc54dbfd8ef1"
  instance_type          = "t3.xlarge"
  subnet_id              = "subnet-08418fbf847a33ad0"
  key_name               = "uat-ecs-new-account"
  iam_instance_profile   = "EC2-ECR-Access-Role"
  associate_public_ip_address = false
  ebs_optimized          = true
  disable_api_termination = true

  vpc_security_group_ids = [
    "sg-039a9e2188069e043"
  ]

  tags = {
    Backup = "Daily"
    Env    = "UAT"
    Name   = "ecs-frontend-instance"
  }

  user_data = <<-EOT
    #!/bin/bash
    # set password authentication
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    systemctl restart sshd
  EOT

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count       = 2
    threads_per_core = 2
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  enclave_options {
    enabled = false
  }

  maintenance_options {
    auto_recovery = "default"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }

  private_dns_name_options {
    enable_resource_name_dns_a_record    = false
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    throughput            = 125
    volume_size           = 16
    volume_type           = "gp3"
  }
}
resource "aws_instance" "ecs-mongo-instance" {
  
}
