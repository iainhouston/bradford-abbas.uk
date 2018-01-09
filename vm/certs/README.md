# certs directory

Secret files in this directory are encrypted using:

```
ansible-vault encrypt certs/<secret filename>
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
