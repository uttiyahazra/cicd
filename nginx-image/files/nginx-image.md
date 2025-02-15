#### Building and Running Docker Containers

##### Building Docker Images from Dockerfile

###### Create Project Directory

Creating a Docker image with Dockerfile requires setting up a project directory. The directory contains the Dockerfile and stores all other files involved in building the image. In this example folders named _nginx-image_ and _files_ and a file _.dockerignore_ were created:

```bash
mkdir nginx-image && cd nginx-image
mkdir files

touch .dockerignore
```

###### Create a sample index.html & configurations file

Navigate to the _files_ folder and create an _index.html_ file with following content:

```bash
<html>
  <head>
    <title>Dockerfile</title>
  </head>
  <body>
    <div class="container">
      <h1>My App</h1>
      <h2>This is my first app</h2>
      <p>Hello everyone, This is running via Docker container</p>
    </div>
  </body>
</html>
```

Create a file named _default_ with following content:

```bash
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    
    root /usr/share/nginx/html;
    index index.html index.htm;

    server_name _;
    location / {
        try_files $uri $uri/ =404;
    }
}
```

###### Create Dockerfile

Create a Dockerfile in the created _nginx-image_ folder with following contents:

```bash
FROM ubuntu:18.04  
LABEL maintainer="contact@devopscube.com" 
RUN  apt-get -y update && apt-get -y install nginx
COPY files/default /etc/nginx/sites-available/default
COPY files/index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
```

###### Building the Docker Image

With the following command, the image will be build from the previously created Dockerfile in the _files_ directory, upom execution of which the Docker build events can be observed as follows:

```bash
$ docker build -t nginx:1.0 .
[+] Building 84.8s (9/9) FINISHED                                                                                                        docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                     0.0s
 => => transferring dockerfile: 267B                                                                                                                     0.0s 
 => [internal] load metadata for docker.io/library/ubuntu:latest                                                                                         1.0s 
 => [internal] load .dockerignore                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                          0.0s 
 => CACHED [1/4] FROM docker.io/library/ubuntu:latest@sha256:72297848456d5d37d1262630108ab308d3e9ec7ed1c3286a32fe09856619a782                            0.0s 
 => [internal] load build context                                                                                                                        0.0s 
 => => transferring context: 546B                                                                                                                        0.0s 
 => [2/4] RUN  apt-get -y update && apt-get -y install nginx                                                                                            83.0s 
 => [3/4] COPY ./default /etc/nginx/sites-available/default                                                                                              0.1s
 => [4/4] COPY ./index.html /usr/share/nginx/html/index.html                                                                                             0.1s
 => exporting to image                                                                                                                                   0.3s
 => => exporting layers                                                                                                                                  0.3s
 => => writing image sha256:3e23f8757fe0842e983945f7613f6cca72b1b63b1db369d4d75d6532fc1415cc                                                             0.0s 
 => => naming to docker.io/library/nginx:1.0                                                                                                             0.0s 
```

The following command can be used to list the built images:

```bash
docker images
```

###### Test the Docker Image

The following command is used to run the built image:

```bash
docker run -d -p 9090:80 --name nginx-webserver nginx:1.0

4b7cfdf83421   nginx:1.0                   "/usr/sbin/nginx -g …"    29 seconds ago   Up 28 seconds   0.0.0.0:9090->80/tcp   nginx-webserver
```

The container can be checked using below command:

```bash
docker ps
```

###### Pushing Docker Image to Docker Hub

In order to push the docker image to a private DockerHb account, it is necessary to have a DockerHub Personal account as pre-requisite. Afterwards with the credentials the login can be done:

```bash
docker login -u <username>
```

Afterwards with the following command, the docker image can be tagged with Docker username:

```bash
docker tag nginx:1.0 <username>/nginx:1.0
```

Afterwards, the _docker push_ command can be used to push the built image in DockerHub:

```bash
$ docker push <username>/nginx:1.0
The push refers to repository [docker.io/<username>/nginx]
ad9a2d19ee6c: Pushed
35ca001e64dd: Pushed
782a5a6a1c5a: Pushed
4b7c01ed0534: Mounted from library/ubuntu
1.0: digest: sha256:4a413208c29d3a3f8e8fdc86bced7132ac783e9aa7c010f7cdb8652f5c2cabdd size: 1155
```