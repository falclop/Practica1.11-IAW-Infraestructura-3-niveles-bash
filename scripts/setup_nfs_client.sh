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

#Instalamos el cliente
sudo apt install nfs-common -y

#Montamos la carpeta en el directorio, con df -h podemos comprobarlo
mount $NFS_SERVER_IP:/var/www/html /var/www/html