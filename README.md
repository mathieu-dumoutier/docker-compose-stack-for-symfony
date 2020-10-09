# Docker-compose stack for Symfony 5.x with nginx, php 7.4, MySQL 8

## Configuration

* Configure environment variable for your usage in .env
* Create docker network for your project with command `docker network create $DOCKER_PROJECT_NAME` (replace $DOCKER_PROJECT_NAME by the value of your .env file)
* Add all files of this repository on your project directory (be careful to merge .env file if you have already one)

If you are on linux system :
* `sudo chmod 777 var/ -R`
* If not already started : `docker run -d --name docker-hostmanager --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /etc/hosts:/hosts d3tdistribution/docker-hostmanager`

The image and the container docker-hostmanager permit to you to access to your project with a "human" host. (ex: `http://my-project.docker/`)

On Mac OSX and Windows, you can access to your project on the "localhost" host on the port configure in .env for variable `DOCKER_WEBSERVER_PORT`. 

## Launch

* Execute `make up` (Images is building... wait... and containers is launching...)
* Execute install command : `make install`
* Execute clear-cache command : `make clear-cache`
* Go to [your-project.docker](http://your-project.docker) with your browser (for Linux user) or http://localhost:DOCKER_WEBSERVER_PORT for others (replace DOCKER_WEBSERVER_PORT by the value configure in .env)

## Other commands

For informations on others commands available with make tool use ```make help``` command.