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

#Creamos una copia de seguridad de fstab
cp /etc/fstab /etc/fstab.bak

#Creamos una entrada de acceso directo a fstab para garantizar que se monte al arranque de cada máquina mount -a
sed -i '/UEFI/a 172.31.84.55:/var/www/html /var/www/html nfs rsize=8192,wsize=8192,timeo=14,intr,noexec,nosuid' /etc/fstab
