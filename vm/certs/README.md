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

1. LCN will notify us when the SSL Certificate is due for renewal.
    By email to bradfordabbaspc@hotmail.com

2. We renew the SSL Certificate at [LCN's website](https://www.lcn.com/my_account/ssl_certificates) if autorenew is not set up.

3. `webmaster@bradford-abbas.uk` receives an email from `geotrust` asking for aproval of the renewal

4. `webmaster@bradford-abbas.uk` receives an email from `sslorders@geotrust.com` containing the new SSL Certificate together with the CA's Intermediate Certificate.

5. Decrypt the old Certificates:
    ```
    ansible-vault decrypt vm/certs/SSL.crt
    ```

6. Copy and paste in both new SSL Certificates from step 4 above into `SSL.crt`

7. Encrypt the new Certificates:
    ```
    ansible-vault encrypt vm/certs/SSL.crt
    ```

8. Git add; commit; push above changes to our  `bradford-abbas.uk` repo on GitHub

9. `updateLiveCode` to re-configure the live server

10. Empty browser caches.

11. Use the browser to check the validity and expiry date of the https connec tion to [bradford-abbas.uk](https://bradford-abbas.uk/)
