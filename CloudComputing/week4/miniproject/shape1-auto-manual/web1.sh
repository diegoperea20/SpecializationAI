#!/bin/bash

echo "Actualizando linux..."
sudo apt update
sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt-get -y install apache2
sudo systemctl enable apache2
sudo systemctl start apache2
echo "WEB 1 completado instalacion :) "

echo "Instalando Consul ..."
echo "Primera parte ..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "Primera parte Completada"
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
echo "Segunda parte Completada"
echo "Instalando Consul Ultimo ..."
sudo apt update && sudo apt install consul
echo "Consul Intalado Completado"
consul -v