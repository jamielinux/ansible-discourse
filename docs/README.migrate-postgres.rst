*****************************************
Migrate PostgreSQL to a new major version
*****************************************

Rarely you may need to upgrade PostgreSQL to a new major version (eg, from
``9.3`` to ``9.4``), for example if Discourse increases their minimum required
version. The ``migrate-X-to-Y.yml`` playbooks will perform this upgrade for you.
Total downtime depends on the size of your database, but in most cases you’ll
have less than 5 minutes of downtime.

Attempt a migration
===================

Before you do anything, **take a backup of your database!**

Edit ``group_vars/all/main.yml`` and change ``postgres_version`` to the version
that you want to migrate to (eg, from ``9.3`` to ``9.4``). Now run the
appropriate ``migrate-X-to-Y.yml`` playbook.

If you’re running the playbook directly on your server:

.. code-block:: console

    $ sudo ansible-playbook -i inventory/local -c local migrate-X-to-Y.yml


What does the migration playbook do?
====================================

#. Shutdown the Nginx, Unicorn and PostgreSQL services.

#. Install the new PostgreSQL server.

#. Run ``pg_upgrade``.

#. Start the new PostgreSQL server.

#. Uninstall the ``pg`` gem.

#. Install the new PostgreSQL client.

#. Rebuild the ``pg`` gem against the new PostgreSQL client.

#. Start the Nginx and Unicorn services.

What if the migration fails?
============================

If ``pg_upgrade`` fails, the playbook will bail out. Fortunately, the old
version of PostgreSQL is still installed and your original database remains
untouched. To get your website back online:

#. Change ``postgres_version`` back to the original value.

#. Re-run ``deploy-local.sh`` (or just login to your servers and start
   PostgreSQL, Unicorn and Nginx manually).

#. Delete the new and unused PostgreSQL database. If you try another migration
   without doing this, it will fail. On CentOS, run ``rm -rf
   /var/lib/pgsql/9.4/data/*``. On Debian, run ``pg_dropcluster 9.4 main``.
   Change the version as appropriate.

Speed up migrations
===================

Add the following to ``group_vars/all/main.yml`` to speed up migrations:

.. code-block:: yaml

    pg_upgrade_extra_opts: "--link"

Normally, ``pg_upgrade`` will copy your whole database to a new directory. The
``--link`` option creates hard links instead. This significantly speeds up
migrations and avoids using double the disk space. However, it will make
reverting the upgrade `more difficult`_. You probably only want this if you know
what you’re doing.

.. _more difficult: http://www.postgresql.org/docs/current/static/pgupgrade.html#PGUPGRADE-STEP-REVERT

