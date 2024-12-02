#!/bin/bash
#mostrar los comandos que se van ejecutando
#la e es para parar la ejecución si falla, la x para mostrar el comando
#Cogemos las variables
source .env
#Vamos a crear un proxy inverso
set -ex

#Actualizar el repositorio
apt update

#Actualiza el paquete
apt upgrade -y

sudo apt install nfs-kernel-server -y

mkdir -p /var/www/html

chown nobody:nogroup /var/www/html

cp ../nfs/exports /etc/exports

sed -i "s#FRONTEND_NETWORK#$FRONTEND_NETWORK#" /etc/exports