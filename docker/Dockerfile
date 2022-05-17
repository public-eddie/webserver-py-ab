FROM python:3.9-alpine

RUN apk --no-cache add build-base && apk del curl --no-cache
RUN apk update
RUN apk add --no-cache libressl-dev musl-dev libffi-dev gcc python3-dev gcc libffi-dev openssl-dev cargo

RUN apk update && apk add --no-cache tzdata && rm -rf /var/cache/apk/*
RUN cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    echo "Asia/Seoul" > /etc/timezone
RUN apk del tzdata

RUN mkdir -p /webserver
WORKDIR /webserver

COPY ./requirements.txt .
COPY ./webServer.py .

RUN pip3 install -r requirements.txt

EXPOSE 9100
ENTRYPOINT ["python3"]
CMD ["webServer.py"] 