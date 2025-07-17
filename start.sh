#!/bin/bash
set -e

cd backend
flask db upgrade
gunicorn --bind 0.0.0.0:$PORT wsgi:app
