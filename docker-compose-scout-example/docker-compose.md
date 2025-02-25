#### Create the sample JS application

The following code content was copied to _app.js_ file within the working directory _/cicd/docker-compose-example_ :

```js
const express = require("express");
const {createClient: createRedisClient} = require("redis");

(async function () {

    const app = express();

    const redisClient = createRedisClient({
        url: `redis://redis:6379`
    });

    await redisClient.connect();

    app.get("/", async (request, response) => {
        const counterValue = await redisClient.get("counter");
        const newCounterValue = ((parseInt(counterValue) || 0) + 1);
        await redisClient.set("counter", newCounterValue);
        response.send(`Page loads: ${newCounterValue}`);
    });

    app.listen(80);

})();
```
The code uses the Express web server package to create a simple hit tracking application. 

#### Install App Dependencies with NPM

As next step, the app dependencies were installed using _npm install_ command as follows:
```bash
$ npm install express redis

added 79 packages in 10s

FROM node:18-alpine
14 packages are looking for funding
  run `npm fund` for details
```

#### Creating the Dockerfile

```bash
The Dockerfile was then created within the working directory with following content:

FROM node:18-alpine

EXPOSE 80
WORKDIR /app

COPY package.json .
COPY package-lock.json .
RUN npm install

COPY app.js .

ENTRYPOINT ["node", "app.js"]
```

#### Creating the Docker Compose file

The Docker Compose file _docker-compose.yml_ was created with following content in same directory:

```yaml
services:                 # this top level field contains the containers needed for the app
  app:                    # 1st container
    image: app:latest     # image version with tag for 1st container 
    build:
      context: .          # this field is set to tell Compose it can build the image using the working directory (.)
    ports:
      - ${APP_PORT:-80}:80 #the port number given by APP_PORT environment variable will be supplied when  set, with fallback 80
  redis:                  # 2nd container
    image: redis:6        # image version with tag for 2nd container
```
#### Build and Run using Docker Compose

Next, the _docker compose_ command was used to build the Docker image and run the container immediately:

```bash
$ docker compose up -d
[+] Running 10/10
 ✔ redis Pulled                                                                                                                        166.4s 
   ✔ c29f5b76f736 Already exists                                                                                                         0.0s 
   ✔ 65cd9edeec4c Pull complete                                                                                                          2.5s 
   ✔ ee7fe8377b8c Pull complete                                                                                                          3.5s 
   ✔ 12ab41d7efa2 Pull complete                                                                                                          3.8s 
   ✔ a259fb7663b9 Pull complete                                                                                                        156.5s 
   ✔ d81ef77df291 Pull complete                                                                                                        156.5s 
   ✔ 4f4fb700ef54 Pull complete                                                                                                        157.1s 
   ✔ cdc47b6e8883 Pull complete                                                                                                        157.2s 
 ! app Warning              Get "https://registry-1.docker.io/v2/": net/http: request canceled (Client.Timeout exceeded ...             15.3s 
[+] Building 31.0s (12/12) FINISHED                                                                                      docker:desktop-linux
 => [app internal] load build definition from Dockerfile                                                                                 0.1s
 => => transferring dockerfile: 191B                                                                                                     0.0s 
 => [app internal] load metadata for docker.io/library/node:18-alpine                                                                    5.3s
 => [app internal] load .dockerignore                                                                                                    0.1s
 => => transferring context: 2B                                                                                                          0.0s 
 => [app 1/6] FROM docker.io/library/node:18-alpine@sha256:e0340f26173b41066d68e3fe9bfbdb6571ab3cad0a4272919a52e36f4ae56925             15.3s 
 => => resolve docker.io/library/node:18-alpine@sha256:e0340f26173b41066d68e3fe9bfbdb6571ab3cad0a4272919a52e36f4ae56925                  0.0s
 => => sha256:f46e519824fbb18a1df4becc0a40665f5c1cd193e527b3b0e26683d10f140916 1.26MB / 1.26MB                                           2.8s 
 => => sha256:3d8c59f7308dbad7c144c50d7f2b78bdbb5ee2f158009c4c17aa8bdf56d74db0 444B / 444B                                               1.9s 
 => => sha256:e0340f26173b41066d68e3fe9bfbdb6571ab3cad0a4272919a52e36f4ae56925 7.67kB / 7.67kB                                           0.0s 
 => => sha256:b33d7471a6a5106cceb3b6e4368841e06338ff6e5e8b2ff345e2e17f15902d7d 1.72kB / 1.72kB                                           0.0s 
 => => sha256:70649fe1a0d792c12299abc78e1bc691884f8a7b519a294c351caa0748531b7c 6.18kB / 6.18kB                                           0.0s 
 => => sha256:a5cf150cb3746a8af43a656f15a671bb84fa704ac2413cf1e57cc37d12afa838 40.01MB / 40.01MB                                         6.9s 
 => => extracting sha256:a5cf150cb3746a8af43a656f15a671bb84fa704ac2413cf1e57cc37d12afa838                                                6.2s 
 => => extracting sha256:f46e519824fbb18a1df4becc0a40665f5c1cd193e527b3b0e26683d10f140916                                                0.6s 
 => => extracting sha256:3d8c59f7308dbad7c144c50d7f2b78bdbb5ee2f158009c4c17aa8bdf56d74db0                                                0.0s
 => [app internal] load build context                                                                                                    0.1s
 => => transferring context: 32.17kB                                                                                                     0.0s 
 => [app 2/6] WORKDIR /app                                                                                                               0.5s 
 => [app 3/6] COPY package.json .                                                                                                        0.2s 
 => [app 4/6] COPY package-lock.json .                                                                                                   0.1s 
 => [app 5/6] RUN npm install                                                                                                            7.3s 
 => [app 6/6] COPY app.js .                                                                                                              0.1s
 => [app] exporting to image                                                                                                             1.6s 
 => => exporting layers                                                                                                                  1.6s 
 => => writing image sha256:41372890aa9d9f562668c58a72f96a64286763197d9d9d7eee90d2ec69867981                                             0.0s 
 => => naming to docker.io/library/app:latest                                                                                            0.0s 
 => [app] resolving provenance for metadata file                                                                                         0.0s 
[+] Running 4/4
 ✔ app                                       Built                                                                                       0.0s 
 ✔ Network docker-compose-example_default    Created                                                                                     0.3s 
 ✔ Container docker-compose-example-app-1    Started                                                                                    12.3s 
 ✔ Container docker-compose-example-redis-1  Started                                                                                    11.3s
 ```

 #### Scan the Vulnerabilities with _docker scout_ command

 The following _docker scout_ command was used to scan the vulnerabilities, please note the DockerHub CLI Login should be done prior to execution of this command:


 ```bash
$ docker scout quickview 41372890aa9d   # 41372890aa9d is image id
    v Image stored for indexing  
    v Indexed 292 packages

    i Base image was auto-detected. To get more accurate results, build images with max-mode provenance attestations.
      Review docs.docker.com ↗ for more information.

  Target             │  41372890aa9d:latest  │    0C     1H     0M     0L 
    digest           │  41372890aa9d         │
  Base image         │  node:18-alpine       │    0C     1H     0M     0L 
  Updated base image │  node:20-alpine       │    0C     1H     0M     0L
                     │                       │

What's next:
    View vulnerabilities → docker scout cves 41372890aa9d
    View base image update recommendations → docker scout recommendations 41372890aa9d
    Include policy results in your quickview by supplying an organization → docker scout quickview 41372890aa9d --org <organization>
 ```

 Another overview of vulnerabilities can be found as below:

 ```bash
 $ docker scout cves 41372890aa9d
    v SBOM of image already cached, 292 packages indexed
    x Detected 1 vulnerable package with 1 vulnerability


##### Overview

                    │       Analyzed Image
────────────────────┼──────────────────────────────
  Target            │  41372890aa9d:latest 
    digest          │  41372890aa9d 
    platform        │ linux/amd64
    vulnerabilities │    0C     1H     0M     0L 
    size            │ 54 MB
    packages        │ 292


##### Packages and Vulnerabilities

   0C     1H     0M     0L  cross-spawn 7.0.3
pkg:npm/cross-spawn@7.0.3

    x HIGH CVE-2024-21538 [Inefficient Regular Expression Complexity]
      https://scout.docker.com/v/CVE-2024-21538
      Affected range : >=7.0.0
                     : <7.0.5
      Fixed version  : 7.0.5
      CVSS Score     : 7.5
      CVSS Vector    : CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H



1 vulnerability found in 1 package
  CRITICAL  0
  HIGH      1
  MEDIUM    0
  LOW       0


What's next:
    View base image update recommendations → docker scout recommendations 41372890aa9d:latest
```

Afterwards the _docker scout recommendations_ command was used to display the recommendations about the base image used:

```bash
$ docker scout recommendations 41372890aa9d
    v SBOM of image already cached, 292 packages indexed

    i Base image was auto-detected. To get more accurate recommendations, build images with max-mode provenance attestations.
      Review docs.docker.com ↗ for more information.
      Alternatively, use  docker scout recommendations --tag <base image tag>  to pass a specific base image tag.

  Target   │  41372890aa9d:latest 
    digest │  41372890aa9d 

## Recommended fixes

  Base image is  node:18-alpine 

  Name            │  18-alpine 
  Digest          │  sha256:b33d7471a6a5106cceb3b6e4368841e06338ff6e5e8b2ff345e2e17f15902d7d 
  Vulnerabilities │    0C     1H     0M     0L 
  Pushed          │ 2 days ago
  Size            │ 45 MB
  Packages        │ 216
  Flavor          │ alpine
  OS              │ 3.21
  Runtime         │ 18


  │ The base image is also available under the supported tag(s)  18- 
  │ alpine3.21 ,  18.20-alpine ,  18.20-alpine3.21 ,  18.20.7-alpine ,
  │ 18.20.7-alpine3.21 ,  hydrogen-alpine ,  hydrogen-alpine3.21 . If
  │ you want to display recommendations specifically for a different
  │ tag, please re-run the command using the  --tag  flag.



Refresh base image
  Rebuild the image using a newer base image version. Updating this may result in breaking changes.

  v This image version is up to date.


Change base image
  The list displays new recommended tags in descending order, where the top results are rated as most suitable.


              Tag              │                        Details                        │   Pushed   │       Vulnerabilities
───────────────────────────────┼───────────────────────────────────────────────────────┼────────────┼──────────────────────────────
   20-alpine                   │ Benefits:                                             │ 1 week ago │    0C     1H     0M     0L
  Major runtime version update │ • Same OS detected                                    │            │
  Also known as:               │ • Major runtime version update                        │            │
  • 20.18.3-alpine             │ • Image has similar size                              │            │
  • 20.18.3-alpine3.21         │ • Image has same number of vulnerabilities            │            │
  • 20.18-alpine               │ • Image contains equal number of packages             │            │
  • 20.18-alpine3.21           │                                                       │            │
  • iron-alpine                │ Image details:                                        │            │
  • iron-alpine3.21            │ • Size: 48 MB                                         │            │
  • 20-alpine3.21              │ • Flavor: alpine                                      │            │
                               │ • OS: 3.21                                            │            │
                               │ • Runtime: 20.18.3                                    │            │
                               │                                                       │            │
                               │                                                       │            │
                               │                                                       │            │
   23-alpine                   │ Benefits:                                             │ 1 week ago │    0C     0H     0M     0L
  Major runtime version update │ • Same OS detected                                    │            │           -1
  Also known as:               │ • Major runtime version update                        │            │
  • alpine                     │ • Image introduces no new vulnerability but removes 1 │            │
  • alpine3.21                 │ • Image contains similar number of packages           │            │
  • 23.8.0-alpine              │                                                       │            │
  • 23.8.0-alpine3.21          │ Image details:                                        │            │
  • 23.8-alpine                │ • Size: 57 MB                                         │            │
  • 23.8-alpine3.21            │ • Flavor: alpine                                      │            │
  • current-alpine             │ • OS: 3.21                                            │            │
  • current-alpine3.21         │ • Runtime: 22                                         │            │
  • 23-alpine3.21              │                                                       │            │
                               │                                                       │            │
                               │                                                       │            │
   22-alpine                   │ Benefits:                                             │ 1 week ago │    0C     0H     0M     0L
  Major runtime version update │ • Same OS detected                                    │            │           -1
  Also known as:               │ • Major runtime version update                        │            │
  • 22.14.0-alpine             │ • Image introduces no new vulnerability but removes 1 │            │
  • 22.14.0-alpine3.21         │ • Image contains similar number of packages           │            │
  • 22.14-alpine               │                                                       │            │
  • 22.14-alpine3.21           │ Image details:                                        │            │
  • lts-alpine                 │ • Size: 55 MB                                         │            │
  • lts-alpine3.21             │ • Flavor: alpine                                      │            │
  • 22-alpine3.21              │ • OS: 3.21                                            │            │
  • jod-alpine                 │ • Runtime: 22.14.0                                    │            │
  • jod-alpine3.21             │                                                       │            │
                               │                                                       │            │
                               │                                                       │            │
   slim                        │ Benefits:                                             │ 1 week ago │    0C     0H     2M    23L 
  Tag is preferred tag         │ • Tag is preferred tag                                │            │           -1     +2    +23
  Also known as:               │ • Major runtime version update                        │            │
  • 23.8.0-slim                │ • Tag is using slim variant                           │            │
  • 23.8-slim                  │ • slim was pulled 17K times last month                │            │
  • current-slim               │                                                       │            │
  • 23-slim                    │ Image details:                                        │            │
  • bookworm-slim              │ • Size: 80 MB                                         │            │
  • 23-bookworm-slim           │ • Runtime: 22                                         │            │
  • 23.8-bookworm-slim         │                                                       │            │
  • 23.8.0-bookworm-slim       │                                                       │            │
  • current-bookworm-slim      │                                                       │            │
                               │                                                       │            │
                               │                                                       │            │
```