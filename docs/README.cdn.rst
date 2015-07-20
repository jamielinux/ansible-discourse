Enable CDN
==========

Sign up with a CDN and configure according to `these instructions
<https://meta.discourse.org/t/enable-a-cdn-for-your-discourse/>`_.

Add this to ``group_vars/all/main.yml``:

.. code-block:: yaml

    discourse_cdn_enabled:        True
    discourse_cdn_allow_origin:   "*"
    discourse_cdn_url:            "//discourse-cdn.example.com"

