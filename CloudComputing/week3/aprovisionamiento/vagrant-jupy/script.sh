#!/bin/bash

echo "Actualizando linux..."
sudo apt update
echo "Instalando python ..."
sudo apt install -y python3-pip
echo "Python instalado "
echo "Instalando jupyter ..."
pip3 install jupyter
echo "Instalando jupyterlab ..."
export PATH="$HOME/.local/bin:$PATH"
jupyter notebook --ip=0.0.0.0
