FROM jenkins/jenkins:lts-jdk21

# Switch to root to install packages
USER root

# Install Ansible and dependencies
RUN apt-get update && \
  apt-get install -y python3-venv python3-pip && \
  python3 -m venv /opt/ansible && \
  /opt/ansible/bin/pip install --no-cache-dir ansible && \
  ln -s /opt/ansible/bin/ansible /usr/local/bin/ansible && \
  ln -s /opt/ansible/bin/ansible-playbook /usr/local/bin/ansible-playbook && \
  rm -rf /var/lib/apt/lists/*

# Install Ping
RUN apt-get update && \
  apt-get install -y iputils-ping && \
  rm -rf /var/lib/apt/lists/*

USER jenkins