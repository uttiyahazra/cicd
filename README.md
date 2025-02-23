### Important Docker Commands

```bash
docker build -t <IMAGE NAME>:<TAG>
docker images|grep <IMAGE NAME>
docker run image:version # start an image
docker run --net <NETWORK NAME> image # run on a docker network
docker run -e <VARIABLE NAME>=<VARIABLE VALUE> image # enviornment variables
docker run -d image # run in "detatched mode"
docker run -p <HOST's PORT>:<CONTAINER's PORT> image

docker ps # show all containers (running)
docker ps -a # show all running AND not running containers

docker stop <CONTAINER ID> # stop specific container
docker start <CONTAINER ID> # restart specific container

docker images # show all locally saved images

docker rm <CONTAINER ID> # delete a container
docker rmi <IMAGE ID> # delete an image

docker logs <CONTAINER ID> # view a container's logs
docker logs <CONTAINER NAME>
docker logs <CONTAINER ID> # stream the logs live
docker logs <CONTAINER ID> | tail # show just the last part of logs

docker exec -it <CONTAINER ID or CONTAINER NAME> /bin/bash # 'it' means 'interact with terminal' this allows you to use bash on as if you are inside the container's terminal. While inside here, if you execute "env", it prints all the enviornment variables so you can check if things were set correctly. Type "exit" to get out.

# ^^ NOTE: If /bin/bash throws and error, change it to /bin/sh

docker network ls # show already created docker networks
docker network create <NETWORK NAME>

docker-compose -f my_file_name.yaml up # "-f" specifies the file and "up" tells docker to start all the containers in the file
docker-compose -f my_file_name.yaml down # stops all containers in this file.
docker login -u <username> #Login to DockerHub from terminal
docker tag <IMAGE NAME>:<IMAGE TAG> <username>/<IMAGE NAME>:<IMAGE TAG> # ReTag the docker image with username
docker push <username>/<IMAGE NAME>:<IMAGE TAG> # Push Docker image to DockerHub
```