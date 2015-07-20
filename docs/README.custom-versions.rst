Custom versions
===============

Discourse
---------

The official Discourse Docker image defaults to the `tests-passed`_ branch.
``ansible-discourse`` takes a more conservative default and installs the `latest
stable Discourse release`_. To override the default, add the something like
this to ``group_vars/all/main.yml``:

.. code-block:: yaml

    # This can be any git commit hash, branch or tag.
    discourse_version: "stable"

    # Examples:
    #discourse_version: "tests-passed"
    #discourse_version: "latest-release"
    #discourse_version: "v1.4.0.beta6"
    #discourse_version: "5e38512b1b28382746d0826dbee9ffc7d6bd4ef5"

.. _tests-passed: https://github.com/discourse/discourse/tree/tests-passed
.. _latest stable Discourse release: https://github.com/discourse/discourse/tree/stable

Ruby
----

By default, ``ansible-discourse`` installs the latest stable version of Ruby
that is known to be compatible with Discourse. To override the default, add the
something like this to ``group_vars/all/main.yml``:

.. code-block:: yaml

    rbenv_ruby_version: "2.2.2"

