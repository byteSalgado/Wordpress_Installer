#!/bin/bash
clear
printf "\e[1;35m

#     #  ######  #       #        ####
#     #  #       #       #       #    #
#######  #####   #       #       #    #
#     #  #       #       #       #    #
#     #  #       #       #       #    #
#     #  ######  ######  ######   ####

\n"
sleep 4
printf "\e[1;32mEste Script instalara Wordpress en su servidor\n"
sleep 4
printf "\e[1;34mEste Script funciona en sistemas basados en debian\n"
sleep 4
printf "\e[1;32mSi te sirve regalanos una estrella en github\n"
sleep 4
printf "\e[1;34mIniciaremos la instalacion en\e[1;31m 5\e[1;34m segundos\n"
sleep 1
printf "\e[1;31m4\e[1;34m segundos..\n"
sleep 1
printf "\e[1;31m3\e[1;34m segundos..\n"
sleep 1
printf "\e[1;31m2\e[1;34m segundos..\n"
sleep 1
printf "\e[1;31m1\e[1;34m segundos..\n"
sleep 1
printf "\e[1;32mIniciando Instalacion...\n"
sleep 4
clear
printf "\e[1;32mActualizando paquetes...\n"
sleep 4
apt-get update -y && apt-get upgrade -y 
clear
printf "\e[1;32mPaquetes actualizados...\n"
sleep 4
printf "\e[1;34mAhora instalaremos las dependencias\n"
sleep 4
printf "\e[1;34mInstalando Dependencias en\e[1;31m 5\e[1;34m segundos\n"
sleep 1
printf "\e[1;31m4\e[1;34m segundos..\n"
sleep 1
printf "\e[1;31m3\e[1;34m segundos..\n"
sleep 1
printf "\e[1;31m2\e[1;34m segundos..\n"
sleep 1
printf "\e[1;31m1\e[1;34m segundos..\n"
sleep 1
printf "\e[1;32mIniciando Instalacion...\n"
sleep 4
clear
apt-get install apache2 -y
apt install php7.0-mysql -y 
apt-get install mariadb-server -y 
apt-get install mariadb-client -y
apt-get install libapache2-mod-php7.0 -y 
apt-get install php7.0 -y
apt-get install php7.0-gd -y
apt-get installphp7.0-xml -y
apt-get install php7.0-curl -y
apt-get install php7.0-mbstring -y
apt-get install php7.0-mcrypt -y
apt-get install php7.0-xmlrpc -y
apt-get install a2ensite -y
apt-get install wget -y
apt-get install unzip -y
apt-get install tar -y
systemctl start mariadb
a2ensite default-ssl.conf
echo "<Directory /var/www/html>
       Options Indexes FollowSymLinks MultiViews
       AllowOverride All
       Require all granted
    </Directory>" >> /etc/apache2/sites-enabled/000-default.conf
rm /var/www/html/index.html
systemctl restart apache2.service
clear
printf "\e[1;32mInstalacion dependencias finalizada..\n"
sleep 4
printf "\e[1;31mAhora debera\e[1;32m setear la paswoord root del mysql..\n"
sleep 5
sudo mysql_secure_installation
printf "\e[1;35mContraseña seteada correctamente\n"
sleep 5
cd /home/
clear
echo "
CREATE DATABASE Wordpress;
CREATE USER 'Wordpress_user'@'%' IDENTIFIED BY 'userwordpress2020';
GRANT ALL PRIVILEGES ON Wordpress.* TO 'Wordpress_user'@'%';
FLUSH PRIVILEGES;
exit " >> /home/db_wordpress.sql
printf "\e[1;32mA CONTINUACION INTRODUSCA LA PASSWORD SETEADA\n"
sleep 2
mysql -u root -p < db_wordpress.sql
printf "\e[1;32mBase de datos seteada correctamente\n"
sleep 7
clear
printf "\e[1;32mLos datos de la base de datos Wordpress son los siguientes\n"
sleep 6
echo
echo
printf "\e[1;31mADVERTENCIA: Por favor copie estos datos\n"
sleep 5
echo
echo
printf "\e[1;32mDB Name:\e[1;35m Wordpress\n"
printf "\e[1;32mDB user:\e[1;35m Wordpress_user\n"
printf "\e[1;32mDB Password:\e[1;35m userwordpress2020\n"
sleep 10
echo
echo
printf "\e[1;31mADVERTENCIA:\e[1;32m Debe Modificar estos datos, mas adelante\n"
sleep 5
printf "\e[1;32mDescargando Wordpress en 5 segundos\n"
sleep 5
cd /tmp
wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
cp -rf wordpress/* /var/www/html/
chmod -R 775 /var/www/html/
chgrp -R www-data /var/www/html/
ls -al /var/www/html
clear
service apache2 restart
printf "\e[1;32mSe ha completado la instalacion, dirigase al navegador\n"
sleep 2
printf "\e[1;32mColoque la ip de su VPS y instale wordpress\n"
echo
echo
printf "\e[1;31mAVISO: Por favor copie estos datos\n"
sleep 5
echo
echo
printf "\e[1;32mDB Name:\e[1;35m Wordpress\n"
printf "\e[1;32mDB user:\e[1;35m Wordpress_user\n"
printf "\e[1;32mDB Password:\e[1;35m userwordpress2020\n"
echo
echo
printf "\e[1;32mFin del Script.. regala una estrella en github\n"
sleep 5
printf "\e[1;34mScript creado por\e[1;35m Facundo Salgado\n"
