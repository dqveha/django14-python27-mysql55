# FROM python:2.7.18
# ENV PYTHONDONTWRITEBYTECODE=1
# ENV PYTHONUNBUFFERED=1
# WORKDIR /code
# COPY requirements.txt /code/
# RUN sed '/st_mysql_options options;/a unsigned int reconnect;' /usr/include/mysql/mysql.h -i.bkp
# RUN pip install -r requirements.txt
# COPY . /code/

# ARG UBUNTU_VERSION=20.04
# FROM ubuntu:$UBUNTU_VERSION

# ARG PYTHON_VERSION=2.7.18

# # Install dependencies
# RUN apt-get update \
#   && apt-get install -y wget gcc make openssl libffi-dev libgdbm-dev libsqlite3-dev libssl-dev zlib1g-dev \
#   && apt-get clean \
#   && apt-get update \
#   && apt-get install curl -y

# WORKDIR /tmp/

# # Build Python from source
# RUN wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz \
#   && tar --extract -f Python-$PYTHON_VERSION.tgz \
#   && cd ./Python-$PYTHON_VERSION/ \
#   && ./configure --with-ensurepip=install --enable-optimizations --prefix=/usr/local \
#   && make && make install \
#   && cd ../ \
#   && rm -r ./Python-$PYTHON_VERSION*

# RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py \
#     && python2 get-pip.py

# COPY requirements.txt .

# RUN python --version \
#   && pip --version \
#   pip install -r requirements.txt

# ENTRYPOINT [ "python" ]

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