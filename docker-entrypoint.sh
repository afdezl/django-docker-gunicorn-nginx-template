#!/bin/sh

python manage.py migrate                  # Apply database migrations
python manage.py collectstatic --noinput  # Collect static files

# Prepare log files and start outputting logs to stdout
mkdir -p /opt/logs/@@PROJECT_NAME@@
touch /opt/logs/@@PROJET_NAME@@/gunicorn.log
touch /opt/logs/@@PROJECT_NAME@@/access.log
tail -n 0 -f /opt/logs/@@PROJECT_NAME@@/*.log &

# Start Gunicorn processes
echo Starting Gunicorn.
exec gunicorn @@PROJECT_NAME@@.wsgi:application \
    --name @@PROJECT_NAME@@_django \
    --bind 0.0.0.0:8000 \
    --workers 3 \
    --log-level=info \
    --log-file=/opt/logs/@@PROJECT_NAME@@/gunicorn.log \
    --access-logfile=/opt/logs/@@PROJECT_NAME@@/access.log \
    "$@"
