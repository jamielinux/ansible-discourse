****************
Browser security
****************

By default, only the ``X-UA-Compatible`` response header is sent to the client’s
browser (as a workaround for Internet Explorer issues unrelated to browser
security).

There are other response headers you can use to enhance browser security.
Populate ``group_vars/all/main.yml`` with any headers that are appropriate for
your site. Take care with single quotes and double quotes.

.. code-block:: yaml

    content_security_policy: "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; connect-src 'self'; font-src 'self' data:;"
    response_headers:
      - 'X-UA-Compatible "IE=edge"'
      - 'X-Frame-Options DENY'
      - 'X-Content-Type-Options nosniff'
      - 'X-XSS-Protection "1; mode=block"'
      - 'X-Permitted-Cross-Domain-Policies "none"'
      - 'X-Content-Security-Policy "{{ content_security_policy }}"'
      - 'Content-Security-Policy "{{ content_security_policy }}"'
      - 'X-WebKit-CSP "{{ content_security_policy }}"'

A `content security policy`_ that’s too strict could make your website
inaccessible. Also, if you’re using a CDN or loading other remote content,
you’ll need to adjust your headers accordingly.

.. _content security policy: https://developer.mozilla.org/en-US/docs/Web/Security/CSP

