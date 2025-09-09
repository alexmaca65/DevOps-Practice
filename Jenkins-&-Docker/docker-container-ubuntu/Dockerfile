FROM ubuntu:22.04

# Install OpenSSH server and cleanup apt cache
RUN apt-get update && \
  apt-get install -y openssh-server && \
  rm -rf /var/lib/apt/lists/*

# Create the Runtime directory for OpenSSH server, give root permissions and set ownership to root
RUN mkdir -p /var/run/sshd && \
  chmod 755 /var/run/sshd && \
  chown root:root /var/run/sshd

# Create a new user with home directory and bash shell
RUN useradd remote_user -m -s /bin/bash && \
  echo "remote_user:pass123" | chpasswd

# Create SSH folders and give permissions
RUN mkdir -p /home/remote_user/.ssh && \
  chmod 700 /home/remote_user/.ssh && \
  chown -R remote_user:remote_user /home/remote_user/.ssh

# Copy the Public Key to authorized_keys file inside the container
COPY remote-key.pub /home/remote_user/.ssh/authorized_keys

# Secure authorized_keys and set ownership
RUN chmod 600 /home/remote_user/.ssh/authorized_keys && \
  chown remote_user:remote_user /home/remote_user/.ssh/authorized_keys

# Generate host keys
RUN ssh-keygen -A

CMD /usr/sbin/sshd -D



