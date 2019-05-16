# Makefile for hello-pod
install:
	npm install
build:
	docker build -t hello-pod:latest -f Dockerfile .
start:
	docker run -p 3000:3000 --name hello -d hello-pod
stop:
	docker stop hello
clean:
	rm -rf node_modules

