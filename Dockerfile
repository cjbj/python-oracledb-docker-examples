# NAME
#
#   Dockerfile
#
# PURPOSE
#
#   Creates a container with the Python python-oracledb samples and a running
#   Oracle Database so python-oracledb can be evaluated.
#
#   See https://oracle.github.io/python-oracledb/
#
# USAGE
#
#   Get an Oracle Database container (see
#   https://hub.docker.com/r/gvenzl/oracle-xe):
#     podman pull docker.io/gvenzl/oracle-xe:21-slim
#
#   Add Python and the samples to the container:
#     podman build -t cjones/pyo .
#     podman run -d --name pyo -p 1521:1521 -it -e ORACLE_PASSWORD=oracle cjones/pyo
#
#   Log into the container:
#     podman exec -it pyo bash
#
#   At the first login, create the sample schema:
#     python setup.py
#
#   Run samples like:
#     python bind_insert.py
#
#   The database will persist across container shutdowns, but will be deleted
#   when the container is deleted.

FROM docker.io/gvenzl/oracle-xe:21-slim

USER root
RUN  microdnf module enable python39 && \
     microdnf install python39 python39-pip vim vi

WORKDIR /samples/

COPY setup.py setup.py

RUN  curl -LO https://github.com/oracle/python-oracledb/archive/refs/tags/v1.0.0.zip && \
     unzip v1.0.0.zip && mv python-oracledb-1.0.0/samples/* . && \
     /bin/rm -rf python-oracledb-1.0.0 samples v1.0.0.zip && \
     cat create_schema.py >> /samples/setup.py && chown -R oracle.oinstall /samples/

USER oracle

RUN  python3.9 -m pip install oracledb --user

ENV PYO_SAMPLES_MAIN_USER=pythondemo
ENV PYO_SAMPLES_MAIN_PASSWORD=welcome
ENV PYO_SAMPLES_EDITION_USER=pythoneditions
ENV PYO_SAMPLES_EDITION_PASSWORD=welcome
ENV PYO_SAMPLES_EDITION_NAME=python_e1
ENV PYO_SAMPLES_CONNECT_STRING="localhost/xepdb1"
ENV PYO_SAMPLES_DRCP_CONNECT_STRING="localhost/xepdb1:pooled"
ENV PYO_SAMPLES_ADMIN_USER=system

# Run the samples using the default python-oracledb 'Thin' mode, if possible
ENV PYO_SAMPLES_DRIVER_MODE="thin"

# The privileged user password is set in setup.py from the "podman run"
# environment variable ORACLE_PASSWORD
#ENV PYO_SAMPLES_ADMIN_PASSWORD=

