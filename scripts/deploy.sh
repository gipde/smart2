#!/bin/sh


echo "${SSH_KEY}" | base64 --decode >/tmp/ssh_rsa
chmod 600 /tmp/ssh_rsa

CGO_ENABLED=0 go build -o smart2

scp -o "StrictHostKeyChecking=no" -i /tmp/ssh_rsa smart2 scripts/Dockerfile werner@35.190.129.82:/home/werner/
ssh -o "StrictHostKeyChecking=no" -i /tmp/ssh_rsa werner@35.190.129.82 "docker build -t smart2 ."
ssh -o "StrictHostKeyChecking=no" -i /tmp/ssh_rsa werner@35.190.129.82 "docker stop smart2"
ssh -o "StrictHostKeyChecking=no" -i /tmp/ssh_rsa werner@35.190.129.82 "docker run --name smart2 --rm  -p 80:1323 -d smart2"

shred /tmp/ssh_rsa

