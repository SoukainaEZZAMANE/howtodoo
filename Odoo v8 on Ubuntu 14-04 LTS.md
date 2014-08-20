# Odoo v8.0 on Ubuntu 14.04
## What?
This guide shows how to intall Odoo v8 on Ubuntu 14.04, from github
We will:
* Get the system ready by installing dependencies
* Create system users for the Odoo application and the postgresql database
* Install and configure Odoo
* Make it launch when the server boots (boot script)

## Prerequisites
Before starting, update your system:

`sudo apt-get update`

`sudo apt-get dist-upgrade`

`sudo apt-get install git -y`

Next, install the necessary dependencies for Odoo:

`sudo apt-get install python-dateutil python-docutils python-feedparser python-gdata python-jinja2 python-ldap python-libxslt1 python-lxml python-mako python-mock python-openid python-psycopg2 python-psutil python-pybabel python-pychart python-pydot python-pyparsing python-reportlab python-simplejson python-tz python-unittest2 python-vatnumber python-vobject python-webdav python-werkzeug python-xlwt python-yaml python-zsi python-pypdf python-decorator python-requests -y`

Install the most recent version of gdata:

`sudo apt-get install python-pip -y`

`sudo pip install gdata --upgrade`

## Create a system user for Odoo application
First we create a user that will run the Odoo application.

`sudo adduser --system --home=/opt/odoo --group odoo`

A home folder is created (/opt/odoo), we will put all the odoo code there. A user group is created. You can view the user and group by typing:

`sudo cat /etc/passwd`

## Install postgresql databank
We install postgresql databank, this will probably be version 9.2. Make sure that you have not installed postgresql already, if so you can either uninstall it (recommended) or skip this step.

`sudo apt-get install postgresql -y`

This will automatically create a (system) user named postgres. Now we log in as that user and create a database user.

`sudo su - postgres`

`createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt odoo`

You will be prompted for a password, write this password down. We will now go back to root user, type 

`exit`

## Install Odoo
### Our plan
In order to install Odoo, we will download the code from Github. Furthermore we will create a folder for our customizations to Odoo. You don’t have to put your addons in a seperate folder, but it is recommended that you do. If you do not touch the base code, you can get an update for it without touching your modifications/customizations… Our folders fill look like this:

/opt/odoo
	/odoo
	/customizations


### Set up and download code

`sudo cd /opt/odoo`

`sudo mkdir customizations`

`sudo git clone https://www.github.com/odoo/odoo --branch 8.0`

### Change ownership to odoo user

`sudo chown -R odoo: *`

## Setup configuration file
We copy the config file to /etc folder:

`sudo cp /opt/odoo/odoo/debian/openerp-server.conf /etc/odoo-server.conf`

`sudo chown odoo: /etc/odoo-server.conf`

`sudo chmod 640 /etc/odoo-server.conf`

We create a log file:

`sudo mkdir /var/log/odoo`

`sudo chown odoo:root /var/log/odoo`

## Run script
Now we will create a run script:

`cd /etc/init.d/`

`sudo wget https://raw.githubusercontent.com/mathi123/howtodoo/master/odoo-boot.sh`

`sudo cp odoo-boot.sh odoo`

`sudo rm odoo-boot.sh`

Now make it executable: 

`sudo chmod 755 /etc/init.d/odoo`

`sudo chown root: /etc/init.d/odoo`

If you want to start odoo when the machine starts, execute the following commands:

`cd /etc/init.d`

`sudo update-rc.d odoo defaults`


## Run and view logs
You can test by running odoo:

`sudo service odoo start`

You can view the logs live using tail:

`sudo tail -f /var/log/odoo/odoo-server.log`
