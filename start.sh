#!/bin/bash
set -e

cd backend
export FLASK_APP=wsgi.py

# Initialize new database if none exists
if [ ! -f "instance/blog.db" ]; then
    flask db init
    flask db migrate -m "initial migration"
fi

# Always run upgrades
flask db upgrade

gunicorn --bind 0.0.0.0:$PORT wsgi:app
