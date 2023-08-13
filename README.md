**Assembly** is a low-level language that allows us to write code directly in machine instructions. In this text, we'll explore how to create a simple "Hello, World!" in x86 assembly and run it in a Docker environment.

## How the code works

The code provided is written in x86 assembly and uses operating system interrupts to perform writing a message to standard output and then exiting the program.

Here is a simplified explanation of how the code works:

1. The .data section:
    - The `hello db 'Hello, World!',10` snippet defines a variable named `hello` that stores the message "Hello, World!" followed by the character 10 (which represents a line break).
    - The `helloLen equ $ - hello` snippet defines a variable called `helloLen` that calculates the length of the string `hello` by subtracting the current address (`$`) from the beginning of the `hello` variable.

2. The .text section:
    - The `_start:` snippet marks the entry point of the program.
    - `mov eax, 4` defines interrupt number 4 (sys_write), which is used to write to standard output.
    - `mov ebx, 1` defines file descriptor 1, which represents standard output (stdout).
    - `mov ecx, hello` loads the starting address of the `hello` message into the ecx register.
    - `mov edx, helloLen` loads the length of the `hello` message into the edx register.
    - `int 0x80` generates interrupt 0x80, which triggers the system call to write the message to standard output.

    - `xor ebx, ebx` sets the value 0 in the ebx register.
    - `mov eax, 1` defines interrupt number 1 (sys_exit), which is used to exit the program.
    - `int 0x80` generates interrupt 0x80, which triggers the system call to terminate the program.

3. The `write(1, hello, helloLen)` function writes the string `hello` to standard output using the `sys_write` system call.
4. The `exit(0)` function terminates the program, using the `sys_exit` system call and returning the value 0.

In general, the program loads the appropriate values into the registers to invoke the necessary system calls (`sys_write` and `sys_exit`) via interrupt 0x80, resulting in the message "Hello, World!" on standard exit and on program termination with exit code equal to zero.

## Preparing the **Docker** environment

To prepare the Docker environment, follow these steps:

1. Install Docker: Visit the official Docker website (https://www.docker.com) and follow the installation instructions specific to your operating system. Make sure you have Docker Engine installed correctly.

2. Verify installation: After installation, open a terminal or command prompt and run the following command to verify that Docker installed correctly:

    ```
    docker --version
    ```

    It should display the installed Docker version.

3. Create a working directory: Create a directory on your system where you want to store your Docker files, for example `docker-workspace`.

4. Create a Dockerfile: Inside the working directory, create a file called `Dockerfile`. This file will contain the instructions for building the Docker image.

5. Edit the Dockerfile: Open the `Dockerfile` file in a text editor and add the following content:

    ```
    FROM ubuntu:latest
    WORKDIR / app
    COPY hello.asm /app
    RUN apt-get update && apt-get install -y nasm
    RUN nasm -f elf32 -o hello.o hello.asm
    RUN ld -m elf_i386 -s -o hello hello.o
    CMD["./hello"]
    ```

    Explanation of the content:
    - `FROM ubuntu:latest`: Sets the base image to the latest Ubuntu release.
    - `WORKDIR /app`: Defines the working directory inside the container as `/app`.
    - `COPY hello.asm /app`: Copies the `hello.asm` file from your local directory to the `/app` directory inside the container.
    - `RUN apt-get update && apt-get install -y nasm`: Updates the package index and installs the NASM (Netwide Assembler) inside the container.
    - `RUN nasm -f elf32 -o hello.o hello.asm`: Compiles the `hello.asm` assembly file into the `hello.o` object using NASM.
    - `RUN ld -m elf_i386 -s -o hello hello.o`: Links the `hello.o` object file and creates the `hello` executable file.
    - `CMD ["./hello"]`: Defines the default command to be executed when the container is started, which is to execute the file `hello`.

6. Create the "hello.asm" file: In the same working directory, create a file called `hello.asm` and add the assembly code "Hello, World!" that you want to run. For example, the code that was explained earlier.

7. Build the Docker image: In the terminal or command prompt, navigate to your working directory and run the following command to build the Docker image:

    ```
    docker build -t hello-assembly .
    ```

    This will create an image named `hello-assembly` from the Dockerfile.

You now have a Docker environment set up with an image that contains NASM installed and your assembly code. You can run assembly code inside the Docker container using additional Docker commands like `docker run` to test and run your "Hello, World!" program.

## Create a Makefile with the commands to facilitate the build
Create a Makefile file with commands to facilitate building, publishing and running the container image. The file defines a NAME variable with the name of the image and three rules: build, pub and run. The build rule uses the docker build command to build the image from the Dockerfile. The pub rule uses the docker push command to publish the image to a remote repository. The run rule uses the docker run command to run the container in interactive mode and remove the container after running.

```Makefile
NAME := assembly_environment

build:
docker build -t $(NAME) .

pub: build
docker push $(NAME)

run:
docker run -it --rm $(NAME)
```

Run the make run command to build the container image, if necessary, and run the container. The expected result is the impression of "Hello, World!" on the screen.

```bash
$ make run
Hello World!
```

## Conclusion

In this post, we learned how to create a simple "Hello, World!" on screen and how to run it in a Docker container. Leave your comment below. To the next!
