#!/bin/bash
cd ~
cp dnstemplate.json dns_$1.json
sudo sed -i "s/SUBDOMAIN_HERE/$1/g" dns_$1.json
aws route53 change-resource-record-sets --hosted-zone-id **ENTER HOSTED ZONE ID** --change-batch file://dns_$1.json
mkdir $1.ryancarroll.io
sudo cp /etc/apache2/subdomain_template.conf /etc/apache2/sites-available/$1.ryancarroll.io.conf
#sudo vi /etc/apache2/sites-available/$1.ryancarroll.io.conf
sudo sed -i "s/SUBDOMAIN_HERE/$1/g" /etc/apache2/sites-available/$1.ryancarroll.io.conf
sudo mkdir /var/www/$1.ryancarroll.io
sudo a2ensite $1.ryancarroll.io.conf
sudo systemctl reload apache2
cd /var/www/$1.ryancarroll.io/
sudo ln -s /home/ubuntu/$1.ryancarroll.io public_html
sudo certbot --apache
cd ~
cd $1.ryancarroll.io/
vi index.html
