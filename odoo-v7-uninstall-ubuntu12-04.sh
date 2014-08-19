#!/bin/sh
####################################
#
# Completely remove OpenERP v7 from ubuntu server
# !!!!! This will delete postgresql databases !!!!!!
#
####################################

## Stop service 
service openerp-server stop

# Remove config file(s)
rm -f /etc/openerp-server.conf
rm -f /etc/odoo.conf

# Remove application code
rm -R /opt/openerp

# Remove startup process
update-rc.d -f openerp-server remove
rm -f /etc/init.d/openerp-server

# Remove logs
rm -R /var/log/openerp

# Remove databases
sudo service postgresql stop
apt-get remove postgresql -y
apt-get --purge remove postgresql\* -y
rm -r -f /etc/postgresql/
rm -r -f /etc/postgresql-common/
rm -r -f /var/lib/postgresql/

# Delete users and groups
userdel -r postgres
groupdel postgres
userdel -r openerp



