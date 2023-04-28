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

echo "instalacion de node.js y npm en raiz"
sudo apt -y install nodejs
sudo apt -y install npm

echo "actualizando apt e instalando apache PARTE HA PROXY"
sudo apt -y update && apt -y upgrade

echo "instalando apache PARTE PROXY"
sudo apt -y install apache2
sudo systemctl enable apache2

echo "iniciando apache"
sudo systemctl start apache2
sudo systemctl status apache2


echo "clonar la pagina del repo"
git clone https://github.com/SamirHO/cloud
cd cloud/app

echo "instalar consul y express en carpeta /cloud/app"
npm install consul
npm install express

cd..
cd..
echo "Arrancando un agente de cónsul"
consul agent -ui -dev -bind=192.168.100.6 -client=0.0.0.0 -data-dir=.

#echo "instanciar"
#node index.js 4000
#node index.js 4001
#node index.js 4002




