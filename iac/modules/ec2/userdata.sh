#!/bin/bash
sudo apt update

sudo apt install ruby-full -y
sudo apt install wget -y
cd /home/ubuntu
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto > /tmp/logfile
sudo service codedeploy-agent stop
sudo service codedeploy-agent start
sudo service codedeploy-agent enable

rm install

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo usermod -a -G docker ubuntu
