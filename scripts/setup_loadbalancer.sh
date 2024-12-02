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

#Instalamos nginx
apt install nginx -y

#Eliminamos el virtualhost de nginx default
if [ -f "/etc/nginx/sites-enabled/default" ]; then
    unlink /etc/nginx/sites-enabled/default
fi
#Copiamos la platilla en el servidor
cp ../conf/load-balancer.conf /etc/nginx/sites-available

#Usamos sed para manipular nuestro 
sed -i "s/IP_FRONTEND_1/$IP_FRONTEND_1/" /etc/nginx/sites-available/load-balancer.conf
sed -i "s/IP_FRONTEND_2/$IP_FRONTEND_2/" /etc/nginx/sites-available/load-balancer.conf
sed -i "s/LE_DOMAIN/$LE_URL/" /etc/nginx/sites-available/load-balancer.conf

#Habilitamos el virtual host del balanceador de carga si no existe
if [ ! -f "/etc/nginx/sites-enabled/load-balancer.conf" ]; then
    ln -s /etc/nginx/sites-available/load-balancer.conf /etc/nginx/sites-enabled/
fi
#Reiniciamos el servicio
systemctl restart nginx