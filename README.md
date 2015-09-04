[![Build Status](https://travis-ci.org/brucellino/invenio-docker-role.svg?branch=master)](https://travis-ci.org/brucellino/invenio-docker-role)

invenio-docker-role
=========

**This role is tested with Invenio 1.2.1**

`invenio-docker-role` - a role to deliver [invenio](https://github.com/inveniosoftware/invenio).

Invenio is built with

  * mysql server
  * Node.js
  * redis


# Run with Docker

This role has been tested with [Docker](http://docker.io) containers for the two different operating systems. The containers that the playbook have been tested with are

  *
  *

Testing is done as follows:

```bash
    docker run -v /home/becker/invenio-docker-role:/root/roles/invenio-docker-role brucellino/invenio:test-ubuntu /bin/bash -c 'cp roles/invenio-docker-role/invenio.yml . ; ansible-playbook -c local invenio.yml'
```

Requirements
------------

No role requirements, but to run this playbook you'll need a Linux OS (Debian and RedHat suported)

Role Variables
--------------

  * prerequisites: base pre-requisites for the OS in order to install Invenio. There are two sets - one for CentOS and one for Debian.


Dependencies
------------

No other Galaxy dependencies.

Example Playbook
----------------

It's unlikely that you'll be orchestrating more than one invenio server, although you might want to configure the mysql server separately.

    - hosts: local
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
