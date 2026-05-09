#!/usr/bin/env bash

# Exit on any error
set -e

# Variables
PROJECT_DIR="/srv/django/staging/nexsme_staging/src/nexsme-backend"
VENV_DIR="/srv/django/staging/nexsme_staging/venv/bin/activate"
BRANCH="deploy/dev-server"

# Cd into the project code
cd $PROJECT_DIR

# activate the virtual environment
source $VENV_DIR

# Exit if the virtual environment wasn't activated properly
if [ $? -ne 0 ]; then
    echo "Failed to activate virtual environment"
    exit 1
fi

git status
#change branch to ci/cd
git checkout $BRANCH

# Exit if git checkout fails
if [ $? -ne 0 ]; then
    echo "Failed to checkout branch: $BRANCH"
    exit 1
fi

# pull the latest codebase
git pull

# Exit if git pull fails
if [ $? -ne 0 ]; then
    echo "Failed to pull from branch: $BRANCH"
    exit 1
fi

# install the app dependencies
pip install -r requirements.txt

# Exit if pip install fails
if [ $? -ne 0 ]; then
    echo "Failed to install requirements"
    exit 1
fi

# run the database migration
python manage.py migrate

# Exit if migrate fails
if [ $? -ne 0 ]; then
    echo "Failed to apply migrations"
    exit 1
fi

#check application health
python manage.py check

# Exit if check fails
if [ $? -ne 0 ]; then
    echo "Application health check failed"
    exit 1
fi

# If all the above steps pass, then the script will reach here and deactivate the environment
deactivate
