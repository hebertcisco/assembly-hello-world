NAME := assembly_enviroment

build:
	docker build -t $(NAME) .

pub: build
	docker push $(NAME)

run:
	docker run -it --rm $(NAME)