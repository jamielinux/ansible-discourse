*************************
Install Discourse plugins
*************************

Specify plugins to install in ``group_vars/all/main.yml``:

.. code-block:: yaml

    discourse_plugins:
      - name: "discourse-akismet"
        repo: "https://github.com/discourse/discourse-akismet.git"
        version: "HEAD"

      - name: "discourse-spoiler-alert"
        repo: "https://github.com/discourse/discourse-spoiler-alert.git"
        version: "HEAD"

