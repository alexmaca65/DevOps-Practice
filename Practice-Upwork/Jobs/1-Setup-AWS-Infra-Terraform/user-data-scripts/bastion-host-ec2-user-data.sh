#!/bin/bash
# Script for EC2 Instance User Data (for Amazon Linux 2023)

#  Create a new user
useradd -m user-bastion-host

# Create the .ssh directory and add the public key
mkdir -p /home/user-bastion-host/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIAa67ZhywdQKjDS9ImRpEhhrupnn5YwVBSroiSwkSUc alexmaca09@gmail.com" >> /home/user-bastion-host/.ssh/authorized_keys

# Set the correct permissions:
# -R --> recursive. Ensure everything inside .ssh is owned by the new user
# 700 --> rwx (read, write, execute)
# 600 --> rx (read, write) 
chown -R user-bastion-host:user-bastion-host /home/user-bastion-host/.ssh
chmod 700 /home/user-bastion-host/.ssh
chmod 600 /home/user-bastion-host/.ssh/authorized_keys

# Grant passwordless sudo access
echo "user-bastion-host ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/user-bastion-host