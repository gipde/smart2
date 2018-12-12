#!/bin/sh

echo "${SSH_KEY}" | base64 --decode >/tmp/ssh_rsa
chmod 600 /tmp/ssh_rsa

go build -o smart2

ls -lah
ls scripts -lah
ls /tmp -lah

scp -o "StrictHostKeyChecking=no" -i /tmp/ssh_rsa smart2 scripts/Dockerfile werner@35.190.129.82:/home/werner/
ssh -o "StrictHostKeyChecking=no" -i /tmp/ssh_rsa werner@35.190.129.82 "docker build -t smart2 ."

shred /tmp/ssh_rsa

