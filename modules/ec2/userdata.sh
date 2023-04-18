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

rm awscliv2.zip

wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh

sudo chmod +x ./dotnet-install.sh

./dotnet-install.sh --channel 7.0

export DOTNET_ROOT=$HOME/.dotnet

export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools

rm dotnet-install.sh