NAME := asm

build:
	docker build -t assembly_enviroment/$(NAME) .

pub: build
	docker push assembly_enviroment/$(NAME)