base_image=python:3.9-alpine

tag=v0.1.0

image_name=webserver
container_name=webserver

repository_url = 10.0.0.255:5000
project_name=2022_hybrid-cloud


#### docker #####
build-docker:
	docker build -f docker/Dockerfile -t $(image_name):$(tag) . --build-arg BASE_IMAGE=$(base_image)

run-docker:
	docker run -it -d --shm-size=8G --init --name $(container_name) $(image_name):$(tag)

exec-docker:
	docker exec -it $(container_name) /bin/bash

rm-docker:
	docker stop $(container_name) && docker rm $(container_name)
#################


#### image management ####
push-image:
	docker tag $(image_name):$(tag) $(repository_url)/$(project_name)/$(image_name):$(tag)
	docker push $(repository_url)/$(project_name)/$(image_name):$(tag)