# Docker file for invenio from
# https://github.com/inveniosoftware/invenio/blob/master/INSTALL.rst
FROM ubuntu:14.04
MAINTAINER Bruce Becker <bbecker@csir.co.za>
# We prepare the machine for ansble
RUN apt-get clean all && apt-get -y update
RUN apt-get -y install python-yaml python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools git python-pip
RUN mkdir /etc/ansible/
RUN echo '[local]\nlocalhost\n' |  tee --append /etc/ansible/hosts
RUN mkdir /opt/ansible/
RUN git clone --recursive https://github.com/ansible/ansible.git /opt/ansible/ansible
WORKDIR /opt/ansible/ansible
RUN git submodule update --init
ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
ENV PYTHONPATH /opt/ansible/ansible/lib
ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library
WORKDIR /root
RUN git clone https://github.com/brucellino/invenio-docker-role.git roles/invenio-docker-role
RUN cp roles/invenio-docker-role/invenio.yml .
RUN ansible-playbook -c local invenio.yml
