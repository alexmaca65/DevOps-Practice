# Project for Learning Jenkins
* The scope of project is learning Jenkins by following the course on Udemy: Jenkins, From Zero to Hero: Become a DevOps Jenkins Master
* Course Link: https://www.udemy.com/course/jenkins-from-zero-to-hero/learn/lecture/19367702#overview


# Issues encountered:

## 1. When rename parent folder - Jenkins reset
* When renaming parent folder of jenkins_home, make sure to update the volume path in docker-compose.yml.
* Or a better fix ==> Use ${PWD} in volume path.
* After updating the path, delete the containers and re-create them with compose down / compose up -d

# Section Description:

## S1 - Resources for this course
* Donwload resources

## S2 - Introduction & Installation
* Introduction to Docker basics and commands

## S3 - Getting Started with Jenkins
* Description: Create first job on Jenkins and redirect output to. Execute bash script and add params to the job

## S4 - Jenkins & Docker
* Description: run a Jenkins job on the Docker Remote-Host through SSH
* create a Dockerfile to build a Docker Image for the Remote Jobs
* create docker-compose.yml file
* from jenkins container SSH connect to remote-host container
* install SSH Plugin on Jenkins
* integrate the SSH server with Jenkins and setup SSH connection from UI
* crate a remote-task and add build step execute shell with SSH

## S5 - Jenkins & AWS
* Description: Create a Jenkins job that take a Backup from a MySQL Database (container) and upload it to AWS. Jenkins container --> Remote-Host container --> MySQL container
* create MySQL Docker container using MySQL 9.4 Image
* create a new Database and a new Table and populate with 2 rows
* create a bash script to make the Backup of the DB from MySQL container(db-host) and then upload it to AWS S3 Bucket
* On remote-host container:
  - Install MySQL Client to connect to db-host container
  - Install VIM, Curl then AWS CLI v2
  - add the bash script as Volume of the container
* automate this by creating the Jenkins job to take the Backup and upload it to AWS S3 Bucket

## S6 - Jenkins & Ansible
* Description: 
* 