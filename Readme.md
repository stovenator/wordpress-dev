# Build instructions

## Build the docker image
`docker build --build-arg MYSQL_USER_PASSWORD=mysql_password_to_use -t wordpress-dev .`

## Create a docker container from the built image
`docker run -p 8088:80 --name wp_container -d wordpress-dev`


