FROM --platform=linux/x86_64 python:alpine3.16 AS frontend

WORKDIR /usr/src/frontend

ENV PATH="${PATH}:/home/frontend/.local/bin" \
    FLASK_APP="frontend.py" \
    PYTHONDONTWRITEBYTECODE="1" \
    PYTHONUNBUFFERED="1"

ARG MAINTAINER="romuloslv"
LABEL DESCRIPTION="Challenge accept by $MAINTAINER"

RUN adduser frontend -D -g ""
USER frontend

COPY --chown=frontend:frontend frontend.py .
RUN pip install -q --user flask requests Flask-Opentracing jaeger-client

CMD flask run --host=0.0.0.0 --port=8000