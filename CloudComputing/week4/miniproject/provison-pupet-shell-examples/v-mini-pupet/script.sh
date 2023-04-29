#!/bin/bash

echo "Actualizando linux..."
sudo apt update
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
echo "-------PARTE CONSUL INSTALADA------------"
echo "-------INICIA INSTALACION LXD------------"
sudo apt-get install lxd-installer -y
newgrp lxd
echo "------fin instalacion LXD------------"
echo "inicializando lxd ....."
lxd init --auto
echo "Instalación de servidores de backend corriendo apache"
lxc launch ubuntu:18.04 web1
echo "Web 1 completo"
lxc launch ubuntu:18.04 web2
echo "Web 2 completo"
echo "Ingresando a sheell web1"
lxc exec web1 /bin/bash
sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt-get -y install apache2
sudo systemctl enable apache2
systemctl start apache2
exit
echo "Ingresando a sheell web2"
lxc exec web2 /bin/bash
sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt-get -y install apache2
sudo systemctl enable apache2
systemctl start apache2
exit
echo "Creando haproxy"
lxc launch ubuntu:18.04 haproxy
echo "Creacion haproxy completa"
lxc exec haproxy /bin/bash
sudo apt-get -y update && sudo apt-get -y upgrade
sudo  apt install haproxy
systemctl enable haproxy
#echo "Arrancando un agente de cónsul"
#consul agent -ui -dev -bind=192.168.100.6 -client=0.0.0.0 -data-dir=.
haproxy -v


