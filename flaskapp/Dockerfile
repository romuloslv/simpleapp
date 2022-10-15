FROM --platform=linux/x86_64 python:alpine3.16 AS app

WORKDIR /app

ENV PATH="${PATH}:/home/admin/.local/bin" \
    PYTHONDONTWRITEBYTECODE="1" \
    PYTHONUNBUFFERED="1"

ARG MAINTAINER="romuloslv"
LABEL DESCRIPTION="Challenge accept by $MAINTAINER"

RUN adduser admin -D -g ""
USER admin

COPY --chown=admin:admin ./app/app.py .
RUN pip install -q --user flask==2.2.2

EXPOSE 8008
CMD [ "python", "app.py" ]