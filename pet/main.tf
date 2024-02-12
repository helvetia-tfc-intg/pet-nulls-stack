# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
}

variable "prefix" {
  type = string
}

resource "random_pet" "this" {
  prefix = var.prefix
  length = 3
}

resource "null_resource" "owner" {
  provisioner "remote-exec" {
    command = "echo \"hello world\""
  }

  triggers = {
    pet = random_pet.this.id
  }
}

output "name" {
  value = random_pet.this.id
}
