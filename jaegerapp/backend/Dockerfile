FROM --platform=linux/x86_64 python:alpine3.16 AS backend

WORKDIR /usr/src/backend

ENV PATH="${PATH}:/home/backend/.local/bin" \
    FLASK_APP="backend.py" \
    PYTHONDONTWRITEBYTECODE="1" \
    PYTHONUNBUFFERED="1"

ARG MAINTAINER="romuloslv"
LABEL DESCRIPTION="Challenge accept by $MAINTAINER"

RUN adduser backend -D -g ""
USER backend

COPY --chown=backend:backend backend.py .
RUN pip install -q --user flask Flask-Opentracing jaeger-client

CMD flask run --host=0.0.0.0 --port=5000