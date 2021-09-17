# Build instructions

## Build the docker image
`docker build --build-arg MYSQL_USER_PASSWORD=change_this_password -t wordpress-dev .`

## Create a docker container from the built image
`docker run -dit -p 8088:80/tcp --name wp_container wordpress_dev bash`

## Connect to the TTY on the new image (if needed)
`docker exec -it wp_container /bin/bash`


Open http://localhost:8088/ to verify website works
