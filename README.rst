******************************
Deploy Discourse using Ansible
******************************

Easily deploy `Discourse`_ with `Ansible`_ (and without Docker). `Supported
operating systems include CentOS 7 and Debian Jessie
<docs/README.operating-system-support.rst>`_.  You don’t need any knowledge of
Ansible (but it’s recommended).

``ansible-discourse`` deploys a similar software stack to the `official
Discourse Docker image`_:

* **PostgreSQL** and **Redis**

* **Nginx** and **Unicorn**

* **Ruby** (installed with **rbenv**)

* The `Discourse application`_

Bonus features:

* Integration with **systemd** for service management and isolation.

* `Zero downtime`_ restarts of Unicorn when Discourse or gems are updated.

* Install **Unbound** as a local DNS resolver with DNSSEC validation.

* Install **Postfix** and **OpenDKIM** to send notification emails (so no
  third-party required).

.. _Ansible: http://www.ansible.com
.. _official Discourse Docker image: https://github.com/discourse/discourse_docker
.. _Discourse: http://www.discourse.org/
.. _Discourse application: https://github.com/discourse/discourse
.. _Zero downtime: http://unicorn.bogomips.org/SIGNALS.html#label-Procedure+to+replace+a+running+unicorn+executable

Is this for me?
===============

The Discourse team only supports installation via Docker. ``ansible-discourse``
may suit you if:

* you already manage your servers with Ansible

* you want more flexibility over your production environment

* you don’t want to run an OS (Docker container) inside an OS (virtual machine)
  inside an OS

* `you need more secure isolation (eg, hardware virtualization) than Docker can
  provide <https://opensource.com/business/14/7/docker-security-selinux>`_

Disclaimer
==========

I’ll try to make sure ``ansible-discourse`` never fails, but this isn’t a
guarantee. If you need guaranteed uptime but aren’t an experienced sysadmin,
consider purchasing `premium support from Discourse.org`_.

.. _premium support from Discourse.org: https://payments.discourse.org/buy/

Quickstart
==========

Step 1: Install Ansible
-----------------------

You have two options:
   
* QUICKER: Install Ansible on your server and continue with the quickstart
  instructions.

* BETTER: Install Ansible locally and `deploy to a remote server from your
  local computer <docs/README.remote.rst>`_.

Step 2: Configure playbook
--------------------------

Login via SSH to your server. Get started with either |vars_example.yml|_ or
|vars_ssl_example.yml|_:

.. code-block:: console

    $ git clone https://github.com/jamielinux/ansible-discourse
    $ cd ansible-discourse
    $ cp vars_example.yml group_vars/all/main.yml

Edit the options in ``group_vars/all/main.yml``.

.. |vars_example.yml| replace:: ``vars_example.yml``
.. _vars_example.yml: vars_example.yml
.. |vars_ssl_example.yml| replace:: ``vars_ssl_example.yml``
.. _vars_ssl_example.yml: vars_ssl_example.yml

Step 3: Mail server
-------------------

Discourse needs to be able to send notification emails. You have two options:

* SELF-HOST: `Deliver your own mail <docs/README.mail.rst>`_.

* EXTERNAL: Sign up with a service like Mandrill.

Step 4: Deploy
--------------

The very first run will probably take 10-20 minutes depending on your hardware.

.. code-block:: console

    $ sudo ./deploy-local.sh

You should configure a firewall with ports 22, 80 and 443 open. You should also
enable automatic system updates. Consult your operating system documentation for
instructions.

Updating
--------

By default, the `latest Discourse release`_ is installed. When a new version is
released, simply re-run ``deploy-local.sh``. Re-runs are much faster than the
first run, as Ansible skips completed tasks.

.. code-block:: console

    $ cd ansible-discourse
    $ git pull
    $ sudo ./deploy-local.sh

.. _latest Discourse release: https://github.com/discourse/discourse/releases/tag/latest-release

Advanced configuration
======================

* `run PostgreSQL (and/or Redis) on a separate server
  <docs/README.multiple-servers.rst>`_

