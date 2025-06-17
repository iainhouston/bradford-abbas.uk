# certs directory

Secret files in this directory are encrypted using:


        ansible-vault encrypt vm/certs/<secret filename>

# DKIM mail signing stuff


`mail.txt` is a public key so doesn't need to be encrypted since it's available in the public domain in the DNS text record for this site. For example:


        dig mail._domainkey.bradford-abbas.uk TXT


should show the same string as in `mail.txt`.

Checking (on prod host) that dkim keys match with DNS:


        sudo opendkim-testkey −d bradford-abbas.uk −s mail −k /etc/postfix/dkim.key


# CSR Certificate renewal stuff

LCN will (silently) raise a support ticket when you renew the SSL Cert from the LCN Dashboard
They will also send an email to `webmaster@bradford-abbas.uk` requesting that we submit a new CSR

On MacOS:

Firstly, find the password used to encrypt the key and the signing certficate in this repo. e.g. put the one stored locally into the MacOS clipboard (pb gor PasteBoard?):

```
cat ~/.vaultpw | pbcopy
```

Then decrypt the repo's key and CSY and generate new ones

```
cd ~/bradford-abbas.uk/vm/certs

ansible-vault decrypt  SSL.key
ansible-vault decrypt  SSL.csr

openssl req -nodes -newkey rsa:2048 -sha256 -keyout SSL.key -out SSL.csr
```

More details on what was required by LCN in May 2025:

1. Must use `www.bradford-abbas.uk` as "Common Name" for LCN to re-issue certificate  

1. Don't provide challenge password (or optional Company Name)

```
Generating a 2048 bit RSA private key
........................+++
................................................+++
writing new private key to 'SSL.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) []:GB
State or Province Name (full name) []:Dorset
Locality Name (eg, city) []:Sherborne
Organization Name (eg, company) []:Bradford Abbas Parish Council
Organizational Unit Name (eg, section) []:IT Department
Common Name (eg, fully qualified host name) []:www.bradford-abbas.uk
Email Address []:webmaster@bradford-abbas.uk

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:

An optional company name []:

```

Check ourselves and submit to LCN:

```
openssl req -text -noout -verify -in SSL.csr

# paste from MacOS clipboard into LCN's ticket response comment box
cat SSL.csr | pbcopy
```

And now encrypt

```
ansible-vault encrypt  SSL.key
ansible-vault encrypt  SSL.csr
```
... await arrival of new SSL certificate

# Create an SSL Certificate Bundle

*If only BA Cert supplied* 
I do this by copying and pasting the newly-aquired crt into the existing crt bundle
 `vm/certs/SSL.crt` replacing the top crt in the bundle  with the newly-aquired one.
 
 *If they send us a zipped up bundle of certificates*  we have to merge them together.  
 
The appended files must not have any spaces between each start and end of file.

    Example Bundle content:

        -----BEGIN CERTIFICATE1-----
        sajaisjkajfsdvjJV;kjvd;Kjv;Js;FDJVKjv
        -----END CERTIFICTATE1-----
        -----BEGIN CERTIFICATE2----
        sajdjsaskdjfkjdskvjsadvkjBDSVKBkdjv
        -----END CERTIFCATE2-----


    Order is important.  Put the Intermediate Certificate(s) at the top and Root at the bottom.  If more than one intermediate file, place them in order.  Look at the leaf certificate Issuer to determine the certificate to be listed at the top of the bundle.

    Leaf certificate
    Owner: CN=hostname.domain.edu
    Issuer: CN= CA 1

    Bundle (Bundle.crt)
    Intermediate certificate 1
    Owner: CN= CA 1
    Issuer: CN= CA 2

    Intermediate certificate 2
    Owner: CN= CA 2
    Issuer: CN= Root CA

    Root certificate content
    Owner: CN= Root CA.


    Example Bundle content:

        -----BEGIN CERTIFICATE1-----
        sajaisjkajfsdvjJV;kjvd;Kjv;Js;FDJVKjv
        -----END CERTIFICTATE1-----
        -----BEGIN CERTIFICATE2----
        sajdjsaskdjfkjdskvjsadvkjBDSVKBkdjv
        -----END CERTIFCATE2-----
        -----BEGIN CERTIFICATE3----
        sajdjsaskdjfkjdskvjsadvkjBDSVKBkdjv
        -----END CERTIFCATE3-----


Explicitly (May 2022)

```
cat www_bradford-abbas_uk.crt > SSL.crt
cat SectigoRSADomainValidationSecureServerCA.crt >> SSL.crt
cat USERTrustRSAAAACA.crt >> SSL.crt
cat AAACertificateServices.crt >> SSL.crt
cat SSL.crt
```
[2023]  **first** / **top** certificate is `www_bradford-abbas_uk.crt`
intermediates had expiry dates of more than a year

Check the key with the CRT.

These two commands print out md5 checksums of the certificate and key; the checksums can be compared to verify that the certificate and key match.

```
openssl x509 -noout -modulus -in SSL.crt| openssl md5
openssl rsa -noout -modulus -in SSL.key| openssl md5
```

The file is now ready for import.

```
cp SSL.crt ~/bradford-abbas.uk/vm/certs/
```

# Renewing the SSL Certificate

1. Encrypt the new Certificates:

        ansible-vault encrypt vm/certs/SSL.crt

1. Git add; commit; push above changes to our  `bradford-abbas.uk` repo on GitHub

1. `updateLiveCode` to re-configure the live server

1. Empty browser caches.

1. Use the browser to check the validity and expiry date of the https connec tion to [bradford-abbas.uk](https://bradford-abbas.uk/)
