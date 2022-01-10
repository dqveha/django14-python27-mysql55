FROM ubuntu:20.04

RUN apt-get update \ 
    && apt install -y python2-dev \
    && apt-get install curl -y \
    && curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py \
    && python2 get-pip.py

ENV PYTHONUNBUFFERED=1

WORKDIR /code

COPY requirements.txt /code/

RUN apt-get install -y libmysqlclient-dev wget gcc make openssl libffi-dev libgdbm-dev libsqlite3-dev libssl-dev zlib1g-dev build-essential

RUN ln -s /usr/include/mysql/mysql.h /usr/include/mysql/my_config.h

RUN pip install -r requirements.txt

COPY . /code/