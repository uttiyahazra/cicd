#### Create a minimal Node.js app

A new directory was created _~/cicd/init_ and following content was copied into Node.js app and was saved as _main.js_  in the directory:

```js
const express = require("express");

const app = express();

app.get("/", (req, res) => {
	res.send("Node.js demo app using Express.");
});

app.listen(3000, () => {
	console.log("App is listening.");
});
```
The app starts an Express web server on port 3000. It serves a single route (/) that sends a basic message in its response.


#### Install Dependencies with npm package manager
The following command was run to install the Express dependency in the project using npm:

```bash
$ npm install express

added 69 packages in 2s

14 packages are looking for funding
  run `npm fund` for details
```

#### Initialize the artifacts using _docker init_ 
Afterwards, the _docker init_ command was executed in order to initialize the artifacts within the working directory:

```bash
$ docker init

Welcome to the Docker Init CLI!

This utility will walk you through creating the following files with sensible defaults for your project:
  - .dockerignore
  - Dockerfile
  - compose.yaml
  - README.Docker.md

Let's get started!

? What application platform does your project use? Node
? What version of Node do you want to use? (18.16.0)

? What version of Node do you want to use? 18.16.0
? Which package manager do you want to use? npm
? What command do you want to use to start the app? [tab for suggestions] node main.js

? What command do you want to use to start the app? node main.js
? What port does your server listen on? 3000

? What port does your server listen on? 3000

✔ Created → .dockerignore
✔ Created → Dockerfile
✔ Created → compose.yaml
✔ Created → README.Docker.md

→ Your Docker files are ready!
  Review your Docker files and tailor them to your application.
  Consult README.Docker.md for information about using the generated files.

What's next?
  Start your application by running → docker compose up --build
  Your application will be available at http://localhost:3000
```

#### Building Docker Image and Run the Container using _docker compose_

Next, the _docker compose_ command was used to build the Docker image and run the container immediately:

```bash
$ docker compose up -d
[+] Building 29.9s (12/12) FINISHED                                                                                                      docker:desktop-linux
 => [server internal] load build definition from Dockerfile                                                                                              0.0s
 => => transferring dockerfile: 1.21kB                                                                                                                   0.0s 
 => [server] resolve image config for docker-image://docker.io/docker/dockerfile:1                                                                       2.7s 
 => CACHED [server] docker-image://docker.io/docker/dockerfile:1@sha256:93bfd3b68c109427185cd78b4779fc82b484b0b7618e36d0f104d4d801e66d25                 0.0s
 => [server internal] load metadata for docker.io/library/node:18.16.0-alpine                                                                            4.8s
 => [server internal] load .dockerignore                                                                                                                 0.0s
 => => transferring context: 663B                                                                                                                        0.0s 
 => [server stage-0 1/4] FROM docker.io/library/node:18.16.0-alpine@sha256:9036ddb8252ba7089c2c83eb2b0dcaf74ff1069e8ddf86fe2bd6dc5fecc9492d             17.8s
 => => resolve docker.io/library/node:18.16.0-alpine@sha256:9036ddb8252ba7089c2c83eb2b0dcaf74ff1069e8ddf86fe2bd6dc5fecc9492d                             0.0s 
 => => sha256:9036ddb8252ba7089c2c83eb2b0dcaf74ff1069e8ddf86fe2bd6dc5fecc9492d 1.43kB / 1.43kB                                                           0.0s 
 => => sha256:5e7724fe034d5693ffd3a2f925d6b1feea3f86096a414891c99e5de16aefc931 1.16kB / 1.16kB                                                           0.0s 
 => => sha256:6dcce61929307b8f11b3a7c67feb4e000987f5f3810ea8fd44392ccad2f6497b 6.73kB / 6.73kB                                                           0.0s 
 => => sha256:31e352740f534f9ad170f75378a84fe453d6156e40700b882d737a8f4a6988a3 3.40MB / 3.40MB                                                           0.6s 
 => => sha256:c017600940c61ad955e20e7dacd301feb287dddd442f63d959ad5ac7c273abb0 47.48MB / 47.48MB                                                        11.8s 
 => => sha256:c9f8586f07bd2ca2364211d26e40d5bb881cf547be76e7e0437c18b35c08e254 2.34MB / 2.34MB                                                           4.7s 
 => => extracting sha256:31e352740f534f9ad170f75378a84fe453d6156e40700b882d737a8f4a6988a3                                                                0.1s 
 => => sha256:ee16df044bfcf0a8d28e8a4488c5ee7013f2c49e8d061ddcf1a2b8ce6792ad13 450B / 450B                                                               1.4s
 => => extracting sha256:c017600940c61ad955e20e7dacd301feb287dddd442f63d959ad5ac7c273abb0                                                                5.4s 
 => => extracting sha256:c9f8586f07bd2ca2364211d26e40d5bb881cf547be76e7e0437c18b35c08e254                                                                0.1s 
 => => extracting sha256:ee16df044bfcf0a8d28e8a4488c5ee7013f2c49e8d061ddcf1a2b8ce6792ad13                                                                0.0s 
 => [server internal] load build context                                                                                                                 0.0s 
 => => transferring context: 29.03kB                                                                                                                     0.0s 
 => [server stage-0 2/4] WORKDIR /usr/src/app                                                                                                            0.4s 
 => [server stage-0 3/4] RUN --mount=type=bind,source=package.json,target=package.json     --mount=type=bind,source=package-lock.json,target=package-lo  3.3s 
 => [server stage-0 4/4] COPY . .                                                                                                                        0.1s 
 => [server] exporting to image                                                                                                                          0.1s 
 => => exporting layers                                                                                                                                  0.1s 
 => => writing image sha256:64195df4e572cbb38fef6c9dd71e31745d5abd6581a73fa6b2fab12f7e81f87e                                                             0.0s 
 => => naming to docker.io/library/init-server                                                                                                           0.0s 
 => [server] resolving provenance for metadata file                                                                                                      0.0s 
[+] Running 3/3
 ✔ server                   Built                                                                                                                        0.0s 
 ✔ Network init_default     Created                                                                                                                      0.3s 
 ✔ Container init-server-1  Started                                                                                                                      1.0s 
```
Finally, the up and running container can be verified as follows:

#### Verification of Container status

```bash
$ docker ps|grep -i init-server
ab5fd6049634   init-server                  "docker-entrypoint.s…"    14 minutes ago   Up 14 minutes   0.0.0.0:3000->3000/tcp   init-server-1
```