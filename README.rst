******************************
Deploy Discourse using Ansible
******************************

Easily deploy `Discourse`_ with `Ansible`_ (and without Docker). `Several
operating systems are supported <docs/README.operating-system-support.rst>`_,
including CentOS, Debian, Fedora and Ubuntu. You don’t need any knowledge of
Ansible (but it’s recommended).

``ansible-discourse`` deploys a similar software stack to the `official
Discourse Docker image`_, including PostgreSQL, Redis, NGINX and Ruby (via
rbenv).

Don’t report issues to ``meta.discourse.org``. Instead, `open a new issue
here <https://discourse.jamielinux.com/c/ansible-discourse>`_.

Bonus features:

* Integrate with **systemd** for service management and isolation.

* `Zero-downtime Unicorn restarts even after upgrading Ruby via rbenv
  <https://jamielinux.com/blog/zero-downtime-unicorn-restart-when-using-rbenv/>`_
  (so downtime is rare).

* Install **Unbound** as a local DNS resolver with DNSSEC validation.

* Install **Postfix** and **OpenDKIM** to send emails (so no third-party service
  is required).

* Don’t install pngout as it’s not free software.

.. _Ansible: http://www.ansible.com
.. _official Discourse Docker image: https://github.com/discourse/discourse_docker
.. _Discourse: http://www.discourse.org/
.. _Discourse application: https://github.com/discourse/discourse

Is this for me?
===============

The Discourse team only supports installation via Docker. ``ansible-discourse``
may suit you if:

* you already manage your servers with Ansible

* you want more flexibility over your production environment

* you don’t want to run an OS (Docker container) inside an OS (virtual machine)
  inside an OS

* you need more secure isolation (eg, hardware virtualization) than Docker can
  provide (as `containers do not contain
  <https://opensource.com/business/14/7/docker-security-selinux>`_)

Important notes
===============

* I cannot provide any guarantees. If you need guaranteed uptime but aren’t an
  experienced system administrator, consider purchasing `premium support from
  Discourse.org`_.

* In some cases, `external package repositories are used
  <docs/README.operating-system-support.rst>`_.

.. _premium support from Discourse.org: https://payments.discourse.org/buy/

Quickstart
==========

Step 1: Install Ansible
-----------------------

You have two options:
   
* QUICKSTART: Install Ansible on your server and continue with the quickstart
  instructions.

* BETTER: Install Ansible locally and `deploy to a remote server from your
  local computer <docs/README.remote.rst>`_. Make sure your remote server has
  Python 2.x installed.

Step 2: Configure playbook
--------------------------

Login via SSH to your server. Get started with |vars_example.yml|_.

.. code-block:: console

    $ git clone https://github.com/jamielinux/ansible-discourse
    $ cd ansible-discourse
    $ cp vars_example.yml group_vars/all/main.yml
    $ vim group_vars/all/main.yml

.. |vars_example.yml| replace:: ``vars_example.yml``
.. _vars_example.yml: vars_example.yml

Step 3: Mail server
-------------------

Discourse needs to be able to send notification emails. You have two options:

* SELF-HOST: `Deliver your own mail <docs/README.mail.rst>`_.

* EXTERNAL: Sign up with a commercial service (eg, Mandrill).

Step 4: Deploy
--------------

The very first run will take 10-25 minutes depending on your hardware. A good
chunk is spent compiling Ruby, so `En Garde <https://xkcd.com/303/>`_!

.. code-block:: console

    $ sudo ./deploy-local.sh

You should configure a firewall with ports 22, 80 and 443 open. You should also
enable automatic system updates. Consult your operating system documentation for
instructions.

Updating
--------

By default, the `latest stable Discourse release`_ is installed. When a new
version is released, simply re-run ``deploy-local.sh``. Re-runs are much faster
than the first run, as Ansible skips completed tasks (eg, Ruby doesn’t need to
be compiled again).

.. code-block:: console

    $ cd ansible-discourse
    $ git pull
    $ sudo ./deploy-local.sh

.. _latest stable Discourse release: https://github.com/discourse/discourse/tree/stable

Further configuration
=====================

* `customize the version of Ruby or Discourse to install
  <docs/README.custom-versions.rst>`_

* `enable HTTPS <docs/README.https.rst>`_

* `run PostgreSQL (and/or Redis) on a separate server
  <docs/README.multiple-servers.rst>`_

* `install Discourse plugins <docs/README.plugins.rst>`_

* `enable a CDN <docs/README.cdn.rst>`_

* `improve browser security <docs/README.security-headers.rst>`_

* `enable multi-site <docs/README.multi-site.rst>`_

* `migrate to a new version of PostgreSQL <docs/README.migrate-postgres.rst>`_

