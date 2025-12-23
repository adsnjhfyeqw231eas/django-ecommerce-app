#!/bin/bash
set -e
sleep 5
python manage.py makemigrations shop
sleep 5
python manage.py makemigrations
sleep 1
python manage.py migrate
sleep 4
python manage.py create_admin
sleep 6
python manage.py runserver 0.0.0.0:8000