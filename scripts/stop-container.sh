#!/bin/bash

docker rm -f $(docker ps -qa) || true
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $OWNER.dkr.ecr.$AWS_REGION.amazonaws.com
docker rmi 432627114264.dkr.ecr.us-east-1.amazonaws.com/hackathon-upper-turismo:DEV || true
