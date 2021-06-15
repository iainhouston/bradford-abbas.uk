# certs directory

Secret files in this directory are encrypted using:

```
ansible-vault encrypt vm/certs/<secret filename>
```

`mail.txt` is a public key so doesn't need to be encrypted since it's available in the public domain in the DNS text record for this site. For example:

```
dig mail._domainkey.bradford-abbas.uk TXT
```

should show the same string as in `mail.txt`.

Checking (on prod host) that dkim keys match with DNS:

```
sudo opendkim-testkey −d bradford-abbas.uk −s mail −k /etc/postfix/dkim.key
```

# Renewing the SSL Certificate

1. We make the Domain / CA bunndle [per these instructions](https://iainhouston.com/devops/drupal/parish%20councils/2019/06/15/Annual_SSL_Renewal.html)

1. Decrypt the old Certificates:
    ```
    ansible-vault decrypt vm/certs/SSL.crt
    ```

1. Copy bundle from step 1 above into `SSL.crt`

1. Encrypt the new Certificates:
    ```
    ansible-vault encrypt vm/certs/SSL.crt
    ```

1. Git add; commit; push above changes to our  `bradford-abbas.uk` repo on GitHub

1. `updateLiveCode` to re-configure the live server

1. Empty browser caches.

1. Use the browser to check the validity and expiry date of the https connec tion to [bradford-abbas.uk](https://bradford-abbas.uk/)
