#!/bin/bash
# Script for EC2 Instance User Data (for Amazon Linux 2023)

# Create a new user and add the SSH Public Key
# Create a new user
useradd -m user-ssh

# Create the .ssh directory and add the public key
mkdir -p /home/user-ssh/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIAa67ZhywdQKjDS9ImRpEhhrupnn5YwVBSroiSwkSUc alexmaca09@gmail.com" >> /home/user-ssh/.ssh/authorized_keys

# Set the correct permissions:
# -R --> recursive. Ensure everything inside .ssh is owned by the new user
# 700 --> rwx (read, write, execute)
# 600 --> rx (read, write) 
chown -R user-ssh:user-ssh /home/user-ssh/.ssh
chmod 700 /home/user-ssh/.ssh
chmod 600 /home/user-ssh/.ssh/authorized_keys

# Grant passwordless sudo access
echo "user-ssh ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/user-ssh