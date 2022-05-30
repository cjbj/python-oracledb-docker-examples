# python-oracledb Examples in a Container

This Dockerfile creates a container with python-oracledb samples and a running
Oracle Database.

See https://oracle.github.io/python-oracledb/ for information about
python-oracledb.

## Usage

- Get an Oracle Database container (see
  https://hub.docker.com/r/gvenzl/oracle-xe):

  ```
  podman pull docker.io/gvenzl/oracle-xe:21-slim
  ```

- Add Python and the samples to the container:

  ```
  podman build -t cjones/pyo .
  podman run -d --name pyo -p 1521:1521 -it -e ORACLE_PASSWORD=oracle cjones/pyo
  ```

- Log into the container:

  ```
  podman exec -it pyo bash
  ```

- At the first login, create the sample schema:

  ```
  python setup.py
  ```

- In the container, run samples like:

  ```
  python bind_insert.py
  ```

The database will persist across container shutdowns, but will be deleted when
the container is deleted.

## About python-oracledb

- Python-oracledb is the new name for Oracle's popular Python cx_Oracle driver
  for Oracle Database.

- Python-oracledb 1.0 is a new major release - the successor to cx_Oracle 8.3.

- Python-oracledb is simple and small to install — under 15 MB (including
  Python package dependencies): `pip install oracledb`

- Python-oracledb is now a Thin driver by default - it connects directly to
  Oracle Database without always needing Oracle Client libraries.

- Python-oracledb has comprehensive functionality conforming to the Python
  Database API v2.0 Specification, with many additions and just a couple of
  exclusions.

- A "Thick" mode can be optionally enabled by an application call. This mode
  has similar functionality to cx_Oracle and supports Oracle Database features
  that extend the Python DB API. To use this mode, the widely used and tested
  Oracle Client libraries such as from Oracle Instant Client must be installed
  separately.

- Python-oracledb runs on many platforms including favorites like Linux, macOS
  and Windows. It can also be used on platforms where Oracle Client libraries
  are not available (such as Apple M1, Alpine Linux, or IoT devices), or where
  the client libraries are not easily installed (such as some cloud
  environments).

## Resources

Home page: [oracle.github.io/python-oracledb/](https://oracle.github.io/python-oracledb/)

Quick start: [Quick Start python-oracledb Installation](https://python-oracledb.readthedocs.io/en/latest/user_guide/installation.html#quick-start-python-oracledb-installation)

Documentation: [python-oracle.readthedocs.io/en/latest/index.html](https://python-oracle.readthedocs.io/en/latest/index.html)

PyPI: [pypi.org/project/oracledb/](https://pypi.org/project/oracledb/)

Source: [github.com/oracle/python-oracledb](https://github.com/oracle/python-oracledb)

Upgrading: [Upgrading from cx_Oracle 8.3 to python-oracledb](https://python-oracledb.readthedocs.io/en/latest/user_guide/appendix_c.html#upgrading-from-cx-oracle-8-3-to-python-oracledb)
