## Project for Learning Jenkins

* The scope of project is learning Jenkins by following the course on Udemy: Jenkins, From Zero to Hero: Become a DevOps Jenkins Master
* Course Link: https://www.udemy.com/course/jenkins-from-zero-to-hero/learn/lecture/19367702#overview


## Issues encountered:

# 1. When rename parent folder - Jenkins reset
* When renaming parent folder of jenkins_home, make sure to update the volume path in docker-compose.yml.
* Or a better fix ==> Use ${PWD} in volume path.
* After updating the path, delete the containers and re-create them with compose down / compose up -d