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

#Instalamos los paquetes del servidor nfs
sudo apt install nfs-kernel-server -y

#Creamos el directorio a compartir, en este caso html en /var/www
mkdir -p /var/www/html

#Eliminamos tanto el propietario como el grupo al que pertenece el directorio
chown nobody:nogroup /var/www/html

#Copiamos el archivo de las opciones de como se exportará el directorio
cp ../nfs/exports /etc/exports

#Añadimos a dicho archivo de configuración las redes a las que hará referencia
sed -i "s#FRONTEND_NETWORK#$FRONTEND_NETWORK#" /etc/exports

#Reiniciamos el servidor
systemctl restart nfs-kernel-server