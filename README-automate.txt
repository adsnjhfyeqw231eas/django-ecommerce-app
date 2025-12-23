ec2 bootstrap:
#!/bin/bash
sudo apt update -y
sleep 3
sudo apt upgrade -y
sleep 5
sudo apt install python3.12-venv -y
sleep 1

-->> What’s Included
Django project App: Basic shop with UI without payment integrations
Admin APIs
Create / update products
User APIs
Place orders
View own orders
Django REST Framework
MySQL database support
Django Admin enabled

-->> Prerequisites
Make sure you have:
Python 3.10+
MySQL 8+
pip

-->> Steps to Run (DO NOT SKIP)
1. Unzip the Project
scp copy project folder to ec2

2. Create Virtual Environment
cd django_ecommerce
python3 -m venv virtual
source virtual/bin/activate

3. Install Dependencies and pip install -r requirements.txt 
sudo apt update
sudo apt install -y \
  default-libmysqlclient-dev \
  build-essential \
  
  mysql-server \
  libmysqlclient-dev \
  python3-dev \
  build-essential \
  pkg-config

Verify: mysql --version && pkg-config --version
pip install django djangorestframework mysqlclient
or 
pip install -r requirements.txt 

4. Create MySQL Database and user
chmod +x mysql_setup.sh
./mysql_setup.sh

verify: 
sudo mysql
SELECT User, Host FROM mysql.user;

~~~~~~~~~~~~~~~~~~~automated above~~~~~~~~~~~~~~~~~~~~
5. Run Migrations
makemigrations → migrate → runserver
# makemigration command -> It looks at your Django models (models.py) and asks: “Did the developer change the structure of the database?”

Q. verify if following files and directories exist?
ls -ld shop/migrations
ls -ld shop/management/commands
ls shop/management/__init__.py
ls shop/management/commands/__init__.py
ls shop/management/commands/create_admin.py

what this create_admin.py does?
IF admin exists:
    do nothing
ELSE:
    create superuser

# run following 2 makemigrations command differently inorder for makemigrations to work
$ python manage.py makemigrations shop
$ python manage.py makemigrations
$ python manage.py migrate

'''
What happens internally:
Django reads models.py

Creates tables:
shop_product
shop_order
auth_user
django_migrations

At this stage:
Database schema exists
NO admin user yet
'''

6. Create Admin User - only after migrate step this works
#export DJANGO_ADMIN_USER=admin
#export DJANGO_ADMIN_EMAIL=admin@admin.admin
#export DJANGO_ADMIN_PASSWORD=admin
already set at .env

$ python manage.py create_admin
output -> Admin user created

verify:
$ python manage.py showmigrations

login to mysql with ecommerce user and run $ SHOW TABLES
should have following tables present: 
shop_order    
shop_orderitem
shop_product    

7. Start Server
python manage.py runserver 0.0.0.0:8000
http://ec2-ip:8000/admin/


As a customer - What can be done in the app?
Products (Admin only)
GET /api/products/
POST /api/products/

Orders (Logged-in users)
GET /api/orders/
POST /api/orders/

Q. Test with curl
curl -kv -u username:password http://127.0.0.1:8000/api/orders/


Q. what is the REAL-win? on every restart we can just execute:-
export .env and run following:
python manage.py migrate
python manage.py create_admin
python manage.py runserver

