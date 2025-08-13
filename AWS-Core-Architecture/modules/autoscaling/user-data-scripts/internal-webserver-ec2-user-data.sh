#!/bin/bash
# Script for EC2 Instance User Data

# Install Apache Webserver (for Amazon Linux 2023)
dnf upgrade --refresh
dnf install -y httpd
systemctl start httpd
systemctl enable httpd

# updated script to make it work with Amazon Linux 2023
CHECK_IMDSV1_ENABLED=$(curl -s -o /dev/null -w "%{http_code}" http://169.254.169.254/latest/meta-data/)
if [[ "$CHECK_IMDSV1_ENABLED" -eq 200 ]]
then
    EC2_AVAIL_ZONE="$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)"
else
    EC2_AVAIL_ZONE="$(TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)"
fi

echo "<h1>Hello world from $(hostname -f) in AZ $EC2_AVAIL_ZONE </h1>" > /var/www/html/index.html

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