#!/bin/bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 432627114264.dkr.ecr.us-east-1.amazonaws.com
docker rm -f $(docker ps -qa) || true
docker run -itd -p 80:80 432627114264.dkr.ecr.us-east-1.amazonaws.com/hackathon-upper-turismo:DEV
