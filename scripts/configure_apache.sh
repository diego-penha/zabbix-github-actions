#!/bin/bash

sudo a2enmod proxy
sudo a2enmod proxy_fcgi
sudo a2enmod setenvif
sudo a2enmod rewrite

sudo systemctl restart apache2
