Scheme:

db-host container <-- mysql:9.4

jenkins-ansible container <-- Dockerfile(jenkins-ansible-container) image <-- Dockerfile base(base-jenkins-container)

remote-host container <-- Dockerfile(base-jenkins-container) iamge

jenkins-ansible