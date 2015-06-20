Multi-site
==========

It’s possible to host multiple domains on a single installation. Each site has
its own separate database, which ``ansible-discourse`` will automatically create
for you (if it doesn’t already exist).

Add something like this to ``group_vars/all/main.yml``:

.. code-block:: yaml

    discourse_multisite:
      - name: "blue"
        database: "blue_discourse"
        db_id: "1"
        host_names:
          - "blue.discourse.example.com"

      - name: "red"
        database: "red_discourse"
        db_id: "2"
        host_names:
          - "red.discourse.example.com"
          - "red-alternate.discourse.example.com"

If you’re `delivering your own mail <docs/README.mail.rst>`_, keep the sending
address (eg, ``noreply@discourse.example.com``) the same across each of your
sites, unless you know what you’re doing.

