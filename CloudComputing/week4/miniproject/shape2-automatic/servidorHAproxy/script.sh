#!/bin/bash

echo "Actualizando linux..."
sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt-get -y install haproxy
haproxy -v
sudo systemctl enable haproxy
echo "HAPROXY instalado"


