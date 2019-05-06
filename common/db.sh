#!/bin/sh
sudo apt-get update
sudo apt-get -y install debconf-utils
sudo apt-get install -y mariadb-server
sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('paloalto@123') WHERE User = 'root';"
sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -e "DROP DATABASE IF EXISTS test;"
sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
sudo mysql -e "FLUSH PRIVILEGES;"
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mysql
sudo mysql -e "CREATE DATABASE Demo;"
sudo mysql -e "CREATE USER 'demouser'@'%' IDENTIFIED BY 'paloalto@123';"
sudo mysql -e "GRANT ALL PRIVILEGES ON Demo.* TO 'demouser'@'%';"
sudo mysql -e "FLUSH PRIVILEGES;"