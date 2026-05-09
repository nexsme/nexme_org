#!/usr/bin/env bash

#Variables
PROJECT_DIR="/srv/django/nexsme/src/nexsme-backend"
VENV_DIR="/srv/django/nexsme/venv/bin/activate"
BRANCH="deploy/dev-server"
SERVICE_FILE="nexsme.talrop.works.service"

# Cd into the project code
cd $PROJECT_DIR

# activate the virtual environment
source $VENV_DIR

#change branch to ci/cd
git checkout $BRANCH

# pull the latest codebase
git pull

# install the app dependencies
pip install -r requirements.txt

# run the databse migration
python manage.py migrate

# run the collect static command
# python manage.py collectstatic --no-input

# put all other commads that required for you specific app

# deactivate
deactivate

# reload nginx
sudo systemctl reload nginx

# restart the gunicorn
sudo systemctl restart $SERVICE_FILE
