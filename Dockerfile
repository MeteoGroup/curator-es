FROM alpine:3.8

MAINTAINER vladyslav.kosheliev@meteogroup.com

ARG CURATOR_VERSION=5.5.4
ARG BOTO3_VERSION=1.7.74
ARG AWS4AUTH_VERSION=0.9
ARG CRYPTO_VERSION=2.1.4

RUN apk --no-cache --update --upgrade add python py-setuptools py-pip \
    gcc libffi py-cffi python-dev libffi-dev py-openssl musl-dev \
    linux-headers openssl-dev libssl1.0 && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir elasticsearch-curator==${CURATOR_VERSION} && \
    pip install --no-cache-dir boto3==${BOTO3_VERSION} && \
    pip install --no-cache-dir requests-aws4auth==${AWS4AUTH_VERSION} && \
    pip install --no-cache-dir cryptography==${CRYPTO_VERSION} && \
    apk del py-pip gcc python-dev libffi-dev musl-dev linux-headers openssl-dev && \
    sed -i '/import sys/a urllib3.contrib.pyopenssl.inject_into_urllib3()' /usr/bin/curator && \
    sed -i '/import sys/a import urllib3.contrib.pyopenssl' /usr/bin/curator && \
    sed -i '/import sys/a import urllib3' /usr/bin/curator

COPY *.yml /tmp/

RUN addgroup curator && \
    adduser -S -s /bin/bash -G curator curator

USER curator

RUN mkdir -p $HOME/.curator && \
    cp /tmp/curator.yml $HOME/.curator/

CMD ["/usr/bin/curator", "/tmp/action.yml"]
