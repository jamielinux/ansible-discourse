*****************************
Multiple server configuration
*****************************

It’s best to run PostgreSQL on a separate server, as PostgreSQL doesn’t like
memory pressure.

Example
=======

Let’s deploy PostgreSQL to ``198.51.100.111``. We’ll deploy everything else to
``198.51.100.222``. We’ll manage the configuration of both servers `from our
local computer <README.remote.rst>`_. You’ll need SSH access to a remote user
with sudo permissions.

Prepare Ansible
---------------

Install Ansible on your local computer and clone this repository.

.. code-block:: console

    $ git clone https://github.com/jamielinux/ansible-discourse
    $ cd ansible-discourse

Configure hosts
---------------

The inventory file tells Ansible about your remote hosts and puts them into
groups. Each section is a group of one or more servers. The ``deploy-local.sh``
script uses |inventory/local|_.

Create ``inventory/remote`` with these contents:

.. code-block:: text

    [postgres]
    198.51.100.111

    [redis]
    198.51.100.222

    [discourse]
    198.51.100.222

.. |inventory/local| replace:: ``inventory/local``
.. _inventory/local: ../inventory/local

Configure options
-----------------

Get started with |vars_example.yml|_:

.. code-block:: shell

    $ cp vars_example.yml group_vars/all/main.yml

Edit the options in ``group_vars/all/main.yml``, and also append these
additional options:

.. code-block:: yaml

    # By default, Discourse connects to the database on localhost.
    # Point Discourse to the database server:
    discourse_db_host:            "198.51.100.111"
    discourse_db_port:            "5432"

    # By default, postgres only listens for connections on localhost.
    # Tell postgres to listen on all interfaces:
    postgres_listen:              ["*"]
    postgres_port:                "5432"

    # By default, only localhost is allowed to connect to the postgres.
    # Tell postgres to allow connections from the Discourse server:
    postgres_hosts_allow:         ["198.51.100.222/32"]

.. |vars_example.yml| replace:: ``vars_example.yml``
.. _vars_example.yml: vars_example.yml

Deploy
------

Replace ``USERNAME`` with the remote user on your servers.

.. code-block:: console

    $ ansible-playbook -i inventory/remote \
          -s -K -u USERNAME master.yml

You should configure a firewall on your postgres host that allows connections to
port ``5432`` only from ``198.51.100.222``.

