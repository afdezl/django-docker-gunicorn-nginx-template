FROM python:3.6.7-alpine3.8

MAINTAINER Adrian Fernandez

# Install Python and Package Libraries
RUN apk update

# Project Files and Settings
ARG PROJECT=@@PROJECT_NAME@@
ARG PROJECT_DIR=/opt/services/${PROJECT}

RUN mkdir -p $PROJECT_DIR
WORKDIR $PROJECT_DIR
COPY Pipfile Pipfile.lock ./
RUN pip install -U pipenv
RUN pipenv install --system

# Server
EXPOSE 8000
STOPSIGNAL SIGINT

ENTRYPOINT ["./docker-entrypoint.sh"]
