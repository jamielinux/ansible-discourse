DKIM
====

`DKIM`_ involves applying a digital signature to every email to prevent email
spoofing. We'll install and use OpenDKIM to sign emails before Postfix sends
them.

.. _DKIM: https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail

Choose a domain and a selector
------------------------------

For simplicity, the sending domain should match your Discourse hostname (eg,
``discourse.jamielinux.com``). Login to your **Admin** dashboard and set
**notification email** accordingly (eg, ``noreply@discourse.jamielinux.com``).

Pick a unique **selector** for the key pair. An identifier followed by the
current date works well (eg, ``discourse-20150601``).

Create a key pair
-----------------

Install ``opendkim`` (or ``opendkim-tools`` on Debian). Run ``dkim-genkey.sh``
with your desired domain and selector.

.. code-block:: console

    $ cd files/dkim
    $ ./dkim-genkey.sh discourse.jamielinux.com discourse-20150601

Two files have been created: a private key (``discourse-20150601.private``) and
a public key (``discourse-20150601.txt``). Use the contents of the public key to
create a TXT record. In `zone file`_ format, it looks like this:

.. code-block:: text

    ; 't=y' indicates "test mode". Remove 't=y' once you know DKIM is working.
    discourse-20150601._domainkey.discourse.jamielinux.com. IN TXT (
        "v=DKIM1; k=rsa; t=y;"
        "p=MIIBIjANBgkqhkiG9w0BAQEFAAOC... " )

Add these options to ``group_vars/all/main.yml``:

.. code-block:: yaml

    dkim_enabled:  True
    dkim_domain: "discourse.jamielinux.com"
    dkim_selector: "discourse-20150601"

    # Discourse notification emails will be signed by this private key.
    # Ensure the matching public key has been published to DNS records.
    dkim_private_key: |
      -----BEGIN RSA PRIVATE KEY-----
      MIIEpQIBAAKCAQEA7+2mcjteiADpXQK5PQyfv+U2yxRxwTEhF2py/1y0ZY4Pybnr
      30+aQ4Q5RWRCDGm+nq8dZu0l//EuwBqC0GZDQyfCEl4ozHtL4SLYP3MGNXUjek3q
      hq7qT82dwKjqO5UtqTsrJVuCJjoNPixJUIX3bmCy3a2HeXwMk8JZor33tcnC2Lvk
      RnP7chlT4zlbrgO9XtNcXiBdyV1K1g+uqYHczQJehPXn5+lMFMRNHbns/p1+x7dz
      ... snipped ...
      sKwoinVMHG2amJS85DWKw7hRzJHrWUqqMcCPcwCxg3D0vOc+vD7snNGXqXKb1dX5
      82xQhRECgYEAnKxf25mG1iVW1cnuAM7d6m3eGhZWqZMZnQegBIGmbUs/IggOkKUB
      wAvhb5O1oVwctaqQxpdJfP/9ekXnt5iEWkj7pJX4OyDrSMyF7b6BOCbugCxQS2Ev
      Ie8xVj/6E40HAdA2+49SmPZJ4N6dw4s5ZlUHbYY/cA8pL+DmX/bghIU=
      -----END RSA PRIVATE KEY-----

.. _zone file: https://en.wikipedia.org/wiki/Zone_file

Key rotation
------------

Advice varies on how often to rotate. A 2048-bit key should probably be rotated
every few years. Follow these steps:

#. Generate another key with a different selector.

#. Add a TXT record for your new key, but don’t change the TXT record for your
   old key.  If you retire the old TXT record too early, emails sent before you
   rotated might fail validation.

#. Update the variables in ``group_vars/all/main.yml``. Re-run the playbook to
   rotate to the new key.

#. Wait a couple of weeks and then retire the old key. Empty the contents of
   the ``p`` field from the old TXT record.

.. code-block:: text

   ; This should remain in your DNS records.
   discourse-20150601._domainkey.discourse.jamielinux.com. IN TXT (
       "v=DKIM1; k=rsa; p=" )

How do I know DKIM is working?
------------------------------

A few services can check for you, such as `port25`_. To receive a report to
``jamie@example.com``, login to your **Admin** dashboard and send a test email
to ``check-auth-jamie=example.com@verifier.port25.com``.

The email report sent to ``jamie@example.com`` should look like this:

.. code-block:: text

    SPF check:          pass
    DomainKeys check:   neutral
    DKIM check:         pass
    Sender-ID check:    pass
    SpamAssassin check: ham

Once you know everything is working, remove ``t=y`` from the DKIM record.

.. _port25: http://www.port25.com/support/authentication-center/email-verification/

Further reading
---------------

* http://www.opendkim.org/opendkim-README

