#!/bin/bash

data() {

	read -p "enter your application name to be installed:" app

	status=$(systemctl is-active $app)

	if [ $status == "inactive" ]

	then

		echo "your service is not active"

		sudo dnf install $app -y

		sudo systemctl enable --now $app

		sudo firewall-cmd --add-port=80/tcp --permanent

		sudo firewall-cmd --reload

		sudo sed -i s/local/"all granted"/g /etc/httpd/conf.d/phpMyAdmin.conf

		sudo systemctl restart httpd

		sudo setenforce 0

		getenforce

		echo "done"

	fi 

}

data "httpd"

data "mysql-server"

data "phpmyadmin"



