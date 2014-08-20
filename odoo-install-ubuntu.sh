#!/bin/sh

# Dependencies
apt-get update
apt-get dist-upgrade
apt-get install git -y

apt-get install python-dateutil python-docutils python-feedparser python-gdata python-jinja2 python-ldap python-libxslt1 python-lxml python-mako python-mock python-openid python-psycopg2 python-psutil python-pybabel python-pychart python-pydot python-pyparsing python-reportlab python-simplejson python-tz python-unittest2 python-vatnumber python-vobject python-webdav python-werkzeug python-xlwt python-yaml python-zsi -y
apt-get install python-pip wkhtmltopdf -y
pip install gdata --upgrade

# Add system user
adduser --system --home=/opt/odoo --group odoo

# Install postgresql
apt-get install postgresql -y

su - postgres

createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt odoo

exit

# Get code
cd /opt/odoo
mkdir customizations
git clone https://www.github.com/odoo/odoo --branch 7.0

chown -R odoo: *
cp /opt/odoo/odoo/debian/openerp-server.conf /etc/odoo-server.conf
chown odoo: /etc/odoo-server.conf
chmod 640 /etc/odoo-server.conf

mkdir /var/log/odoo
chown odoo:root /var/log/odoo

# init script
cd /etc/init.d/
wget https://github.com/mathi123/howtodoo/blob/master/odoo-boot.sh
cp odoo-boot.sh odoo
rm odoo-boot.sh
chmod 755 /etc/init.d/odoo
chown root: /etc/init.d/odoo
update-rc.d odoo defaults

