FROM ubuntu:latest

RUN apt-get update && apt-get install -y nasm build-essential

COPY hello.asm /hello.asm

RUN nasm -f elf64 -o hello.o hello.asm && \
    ld -s -o hello hello.o

CMD ["./hello"]
