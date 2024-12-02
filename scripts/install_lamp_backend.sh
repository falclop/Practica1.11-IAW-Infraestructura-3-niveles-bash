#!/bin/bash
#mostrar los comandos que se van ejecutando
#la e es para parar la ejecución si falla, la x para mostrar el comando
#Le llamamos LAMP: Linux, Apache, MySql, PHP
set -ex

#Tomamos la fuente de variables de entorno
source .env

#Actualizar el repositorio
apt update

#Actualiza el paquete
apt upgrade -y

#Instalar MySQL_server
sudo apt install mysql-server -y

# Configuramos el archivo /ect/mysql/mysql.conf.d/mysqld.cnf
# Esto lo que pasa es que si no funciona de primeras
# Ya no funciona y hay que cambiarlos a mano en mysqld.cnf
sed -i "s/127.0.0.1/$BACKEND_PRIVATE_IP/" /etc/mysql/mysql.conf.d/mysqld.cnf

# reiniciamos el servicio
systemctl restart mysql