#!/bin/bash
set -e

cd backend
export PYTHONPATH=$PYTHONPATH:$(pwd)
export FLASK_APP=wsgi.py
export PORT=${PORT:-9000}

# Initialize if no migrations exist
if [ ! -d "migrations" ]; then
    flask db init
    flask db migrate -m "initial migration"
fi

flask db upgrade
gunicorn --bind 0.0.0.0:$PORT wsgi:app
