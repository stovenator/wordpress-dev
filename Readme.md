# Build instructions

## Build the docker image
`docker build -t wordpress-dev .`

## Create a docker container from the built image
`docker run -p 8088:80 wordpress-dev`


