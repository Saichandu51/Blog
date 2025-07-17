#!/bin/bash
set -e

# Environment setup
cd backend
export FLASK_APP=wsgi.py
export PORT=${PORT:-9000}

# Migration emergency recovery
if [ -f "instance/dev.db" ]; then
    if ! sqlite3 instance/dev.db "SELECT 1 FROM alembic_version LIMIT 1" 2>/dev/null; then
        echo "Database exists without version - performing emergency initialization"
        flask db stamp head
    fi
fi

# Normal migration flow
flask db upgrade

# Start app
exec gunicorn --bind 0.0.0.0:$PORT wsgi:app
