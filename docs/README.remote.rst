************************************
Run Ansible from your local computer
************************************

The quickstart instructions tell you to log in via SSH to your remote server in
order to run Ansible. However, it’s much better to run Ansible from your local
computer.

Prepare Ansible
===============

Install Ansible on your local computer and clone this repository.

.. code-block:: console

    $ git clone https://github.com/jamielinux/ansible-discourse
    $ cd ansible-discourse

Configure hosts
===============

The inventory file tells Ansible about your remote hosts and puts them into
groups. Each section is a group of one or more servers. The ``deploy-local.sh``
script uses |inventory/local|_.

Create ``inventory/remote`` with these contents. Replace ``198.51.100.111`` with
the IP address of your remote server. You’ll need SSH access to a remote user
with sudo permissions.

.. code-block:: text

    [postgres]
    198.51.100.111

    [redis]
    198.51.100.111

    [discourse]
    198.51.100.111

.. |inventory/local| replace:: ``inventory/local``
.. _inventory/local: ../inventory/local

Configure options
-----------------

Get started with |vars_example.yml|_:

.. code-block:: shell

    $ cp vars_example.yml group_vars/all/main.yml

Edit the options in ``group_vars/all/main.yml``.

.. |vars_example.yml| replace:: ``vars_example.yml``
.. _vars_example.yml: vars_example.yml

Deploy
======

Replace ``USERNAME`` with the remote user on your server. Make sure your remote
server has Python 2.x installed.

.. code-block:: console

    $ ansible-playbook -i inventory/remote \
        -s -K -u USERNAME master.yml

