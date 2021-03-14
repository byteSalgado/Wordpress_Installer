#!/bin/bash

#Script created for Facu Salgado: https://github.com/ByteSalgado

# trap function ctrl + c 
trap ctrl_c INT

#Colores
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
Cafe="\033[0;33m"
Fiuscha="\033[0;35m"
blue="\033[1;34m"
nc="\e[0m"

function ctrl_c() {

echo -e "$purple(*)$blue Presionaste la tecla$red CTRL + C$blue Saliendo del programa.."
sleep 2
echo -e "$purple(*)$blue Gracias por usar mi Script by$red Facu Salgado$nc"
sleep 1
exit

}

apt-get install toilet -y
#comprobar directorio
directory=$(pwd)


#Opciones menu

a="Instalar Wordpress"
b="Ver datos base de datos"
c="Salir"


#logo y bienvenida
clear
tput setaf 3  && toilet --filter border Wordpress
sleep 1
echo -e "$purple(*)$blue Script created by$red Facu Salgado"
sleep 2
echo -e "$purple(*)$blue regalanos una estrella en github$yellow"
sleep 2
echo
echo

export PS3=$'\e[01;35m(*)\e[01;32m Selecciona una Opcion:\e[01;33m '

#menu principal

function menu_principal() {
select menu in "$a" "$b" "$c";
do
case $menu in
$a)
echo -e "$purple(*)$blue Bien vamos a instalar Wordpress en su sistema"
sleep 2
echo -e "$purple(*)$blue actualizando repositorios..."
apt-get update -y && apt-get upgrade -y
mkdir db_setup
mkdir db
clear
echo -e "$purple(*)$blue Repositorios actualizados."
sleep 2
echo -e "$purple(*)$blue Instalaremos las dependencias en 5 segundos.."
sleep 1
echo -e "$purple(*)$blue 4 segundos.."
sleep 1
echo -e "$purple(*)$blue 3 segundos.."
sleep 1
echo -e "$purple(*)$blue 2 segundos.."
sleep 1
echo -e "$purple(*)$blue 1 segundos.."
sleep 1
echo -e "$purple(*)$green Instalacion iniciada"
sleep 2
clear

sudo apt -y install lsb-release apt-transport-https ca-certificates
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
apt-get update -y
apt-get install apache2 -y
apt install php7.4-mysql -y 
apt install php7.4-common -y
sudo apt-get install php7.4-mysqli -y
apt-get install mariadb-server -y 
apt-get install mariadb-client -y
apt-get install libapache2-mod-php7.4 -y 
apt-get install php7.4 -y
apt-get install php7.4-gd -y
apt-get install php7.4-xml -y
apt-get install php7.4-curl -y
apt-get install php7.4-mbstring -y
apt-get install php7.4-mcrypt -y
apt-get install php7.4-xmlrpc -y
apt-get install a2ensite -y
apt-get install wget -y
apt-get install unzip -y
service apache2 restart
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
echo -e "$purple(*)$blue Dependencias instaladas"
sleep 1
echo -e "$purple(*)$blue Ahora configuraremos su servidor FTP"
sleep 3
sudo apt install vsftpd -y
clear
echo -e "$purple(*)$blue FTP instalado correctamente..."
sleep 2
echo -e "$purple(*)$blue Ingrese un nombre de usuario para su FTP"
read userftp
sleep 2
echo -e "$purple(*)$blue Muy bien ahora debera especificar la contraseña para el usuario"
sleep 1
sudo adduser $userftp
echo "$userftp" | sudo tee -a /etc/vsftpd.user_list
sudo chmod 7777 /var/www/html
sleep 1
sudo chown -R $userftp: /var/www/html
sleep 1
echo -e "$purple(*)$blue Usuario FTP configurado correctamente.."
sleep 2
echo -e "$purple(*)$blue ahora configuraremos su archivo de configuracion FTP.. please wait.."
sleep 2
echo "
write_enable=YES
user_sub_token=$userftp
local_root=/var/www/html
allow_writeable_chroot=YES
chroot_local_user=YES
userlist_enable=YES
userlist_file=/etc/vsftpd.user_list
userlist_deny=NO
" >> /etc/vsftpd.conf
sleep 2
echo -e "$purple(*)$blue FTP configurado correctamente..."
sleep 3
clear
echo -e "$purple(*)$blue Ahora debera configurar su password root para su MYSQL"
sleep 4
echo -e "$purple(*)$blue iniciara el proceso de configuracion, siga los pasos.."
sudo mysql_secure_installation
clear
echo -e "$purple(*)$blue MYSQL configurado correctamente"
sleep 2
echo -e "$purple(*)$blue Le pediremos los datos para configurar los datos de su DB de wordpress"
sleep 2
printf "\e[1;35mIngrese su DB User:\e[1;34m "
read userdb
printf "\e[1;35mIngrese su DB name:\e[1;34m "
read dbname
printf "\e[1;35mIngrese su DB password:\e[1;34m "
read dbpassword
echo -e "$purple(*)$blue Bien ahora crearemos su base de datos.."
echo "
CREATE DATABASE $dbname;
CREATE USER '$userdb'@'%' IDENTIFIED BY '$dbpassword';
GRANT ALL PRIVILEGES ON $dbname.* TO '$userdb'@'%';
FLUSH PRIVILEGES;
exit " >> $directory/db/db_wordpress.sql
echo -e "$purple(*)$blue Archivo SQL Creado correctamente"
sleep 2
echo -e "$purple(*)$blue a continuacion ingrese su root MYSQL password"
mysql -u root -p < $directory/db/db_wordpress.sql
echo -e "$purple(*)$bluela base de datos se configuro correctamente"
echo "
Database Name: $dbname
Database User: $userdb
Database Password: $dbpassword
" >> $directory/db_setup/sudb.txt
echo -e "$purple(*)$blue la a continuacion iniciaremos el proceso de instalacion de wordpress"
sleep 2
wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
cp -rf wordpress/* /var/www/html/
chmod -R 775 /var/www/html/
chgrp -R www-data /var/www/html/
ls -al /var/www/html
clear
service apache2 restart
echo -e "$purple(*)$blue La instalacion ha finalizado dirigase a su IP apache y configure su Wordpress"
sleep 2
echo -e "$purple(*)$blue Volviendo al menu principal.."
menu_principal



;;

$b)
sleep 1
echo -e "$purple(*)$blue si aparece los datos de la db significa que wordpress esta instalado"
sleep 1
echo -e "$purple(*)$blue Sus datos de su base de datos son:"
cat $directory/db_setup/sudb.txt
echo
echo
echo -e "$purple(*)$blue Volviendo al menu principal.."
sleep 2
menu_principal

;;

$c)
echo -e "$purple(*)$blue Saliendo del programa, gracias por utilizar nuestro script."
sleep 2
echo -e "$purple(*)$blue created by$red Facu Salgado"
exit
;;

*)

echo -e "$purple(*)$red $REPLY$blue Opcion no valida"
;;
esac
done
}
menu_principal
