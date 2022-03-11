NAME := assembly_enviroment

build:
	docker build -t hebertsoftware/$(NAME) .

pub: build
	docker push hebertsoftware/$(NAME)

run:
	docker run -it --rm -p 8080:8080 hebertsoftware/$(NAME)