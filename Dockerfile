FROM python:3-alpine

WORKDIR /opt

RUN apk --update add python3 py3-pip openssl ca-certificates py3-openssl wget git aws-cli openssh
RUN apk --update add --virtual build-dependencies libffi-dev openssl-dev python3-dev build-base
RUN pip install --upgrade pip \
  && pip install pyyaml ansible \
  && pip install --index-url https://test.pypi.org/simple/ opera==0.6.2.dev7
RUN apk del build-dependencies
RUN pip list



