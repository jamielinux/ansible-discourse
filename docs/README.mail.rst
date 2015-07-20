***********************
Configure outgoing mail
***********************

Discourse needs to send notification emails. It’s easy to setup a local mail
transfer agent to deliver your own emails, but the hard part is maintaining
long-term deliverability. This can be a major headache, especially if the IP
address of your server is placed on a spam blacklist. Therefore, some people
prefer to outsource email delivery to a commercial service.

If you’d rather deliver your own email, leave the ``discourse_smtp_*`` options
at their default values and ``ansible-discourse`` will automatically install
Postfix and OpenDKIM for you. However, you must take the following four steps to
avoid getting marked as spam.

Step 1: PTR record
==================

Add a PTR record for `reverse DNS lookup`_ that points to your domain name (eg,
``discourse.example.com``). Usually you need to ask your hosting company to do
this for you. Check that the PTR record is active with the ``host`` command.

Before the PTR record has been added, output looks like this:

.. code-block:: console

    $ host 89.16.185.202
    202.185.16.89.in-addr.arpa domain name pointer 89-16-185-202.no-reverse-dns-set.bytemark.co.uk.

After the PTR record has been added, output looks like this:

.. code-block:: console

    $ host 89.16.185.202
    202.185.16.89.in-addr.arpa domain name pointer discourse.jamielinux.com.

.. _reverse DNS lookup: https://en.wikipedia.org/wiki/Reverse_DNS_lookup

Step 2: SPF record
==================

An `SPF record`_ specifies hosts that are authorized to send email from your
domain. Consult the documentation for your domain registrar for instructions on
how to add a DNS record. In `zone file`_ format, it looks like this:


.. code-block:: text

    ; You should already have an A/AAAA record pointing to your server.
    discourse.jamielinux.com. IN A 89.16.185.202

    ; This SPF record only allows email to be sent from the IP address
    ; specified by the A record (or AAAA).
    discourse.jamielinux.com. IN TXT "v=spf1 a -all"

.. _SPF record: https://en.wikipedia.org/wiki/Sender_Policy_Framework
.. _zone file: https://en.wikipedia.org/wiki/Zone_file

Step 3: DKIM
============

`Follow these instructions <README.dkim.rst>`_.

Step 4: DMARC
=============

`DMARC`_ is a method of email authentication and tells mail servers what to do
with emails that fail SPF and DKIM validation. Add a DNS TXT record like this:

.. code-block:: text

    ; quarantine tells mail servers to mark affected messages as spam.
    _dmarc.discourse.jamielinux.com. IN TXT “v=DMARC1; p=quarantine;”

.. _DMARC: https://en.wikipedia.org/wiki/DMARC

