# LAMP STACK (IN A DOCKER CONTAINER)
## This is a detailed instruction on how to deploy a LAMP Stack in a Docker container.

 ### Create a Docker Container

 `docker run -t --name webserver -p xx:80 image env_type`

 e.g. 
 
 `docker run -t --name webserver -p 81:80 centos: 6.0 bash`

 ### Update the packages in the container

 Centos

 `yum install update`

 Ubuntu
 
 `sudo apt-get update`

 And

 `sudo apt-get upgrade`
 
 Centos
 
 `yum install httpd`

 Ubuntu
 
 `sudo apt install apache2`

 ### Enable & Start Apache Service

 Centos

 `chkconfig httpd on`

 Or

 `service httpd start`

 Ubuntu
 
 `systemctl start apache2`

 Or

 `systemctl enable apache2`

 ### Verify the host IP Address and test it on a browser with the container port number.

`ip a` or `ifconfig`

 ### Install MySQL Server

 Centos
 
 `yum install mysql-server -y`

 Ubuntu
 
 `sudo apt install mysql-server -y`

 ### Enable & start MySQL server Daemon

 Centos 6
 
 `service mysqld start`

 Or
 
 `chkconfig mysqld on`

 Ubuntu
 
 `systemctl mysqld enable`

 Or
 
 `systemctl mysqld start`

 ### Set the root password for Mysql

 `mysql_ secure_ installation`

press enter at the prompt type **y** and press enter on second prompt.

**enter password:** `***********` then press **ENTER***

**re-enter password:** `***********` then press **ENTER**

Type **Y** and press **ENTER** on the remaining prompt.

### Login to MySQL Server using the **root** user credential

`mysql -u root -p` press **ENTER**

Insert the **root** user **password** and press **ENTER**

The system will return a prompt like the below

`mysql>`

Type the following command to view the list of databases on the server

`show databases;` and press **ENTER**

### Create a new **database**

`create database database_name;` and press **ENTER**

### Create a new user and set privilege for the user

`create user username@localhost identified by 'password';`

Set user privilege

`grant all privileges on database_name.* to username@localhost identified by 'password';`

Flush privilege

`flush privileges;`

Exit **mysql**

`exit` and press **ENTER**

### Install PHP

Centos 

`yum install php php-mysql -y'

Ubuntu

`sudo apt install php php-mysql -y`

### Create info.php file in */var/www/html* directory

Change directory to */var/www/html*

`cd /var/www/html`

Create the info.php file

`vim info.php` and press **ENTER**

Inser the following code

`<?php

phpinfo();

?>`

**save** and **exit**

### Restart the Apache Service

Centos

`service httpd restart`

Ubuntu

`systemctl apache2 restart`

### Test to see if the PHP is working

Go to your browser, at the end of the container IP address, include the info.php

`172.1.2.1:81/info.php`

### Install php package

Centos

`yum install php-gd -y`

Ubuntu

`sudo apt install php-gd -y`

### Install wordpress package (Content Management System)

Change directory to the */tmp* folder

`cd /tmp`

Download the wordpress package

`wget http://wordpress.org/wordpress-version.tar.gz`

Extract the wordpress file

`tar -xf wordpress-version.taz.gz`

Display the content of the file

`ls`

Remove the zip file to free up system storage

`rm -rf wordpress-version.taz.gz`

### Copy wordpress content to */var/www/html*

`cp -r wordpress/* /var/www/html`

Change directory to */var/www/html*

`cd /var/www/html`

Create a new directory in */var/www/html*

`mkdir /var/www/html/wp-content/uploads`

Copy contents of *wp-config-sample.php* to *wp-config.php*

`cp wp-config-sample.php wp-config.php`

Modify the content of the **wp-config.php** file

`vim wp-config.php`

Edit the **DB_NAME**, **DB_USER, **DB_PASSWORD** section of the file with the **DATABASE NAME**, **USERNAME**, and **PASSWORD** created earlier.

### Change ownership and group name of the */var/www/html/** folder to apache

`chown -R apache:apache /var/www/html/*`

NB: The **-R** means recursive(it will ensure all subdirectories and files inherit the new owner and group name)

### Restart the **httpd** or **apache2** service

Centos

`service httpd restart`

Ubuntu

`systemctl apache2 restart`

### Open the browser and install wordpress

Type the **IP** address and the **port** number in the browser

Example

`172.1.2.1:81`

### Follow the on-screen instruction to complete the wordpress installation.