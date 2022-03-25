# certs directory

Secret files in this directory are encrypted using:


        ansible-vault encrypt vm/certs/<secret filename>


`mail.txt` is a public key so doesn't need to be encrypted since it's available in the public domain in the DNS text record for this site. For example:


        dig mail._domainkey.bradford-abbas.uk TXT


should show the same string as in `mail.txt`.

Checking (on prod host) that dkim keys match with DNS:


        sudo opendkim-testkey −d bradford-abbas.uk −s mail −k /etc/postfix/dkim.key


# Create an SSL Certificate Bundle

If several intermediate certificate files are received (as opposed to a single CA bundle), the files should be merged into a bundle before importing.  

Note:  This procedure assumes all intermediate files have been provided by the Certificate Authority (CA).       


Procedure:

1.  Confirm the files are in PEM format.  When opened in a text editor, the content should look similar to the format:  

        -----BEGIN CERTIFICATE1-----
        sajaisjkajfsdvjJV;kjvd;Kjv;Js;FDJVKjv
        -----END CERTIFICTATE1-----

    If the content does not have these types of headers, convert to PEM format first.   
    
    Convert DER/Binary to PEM Format: 
    
            openssl x509 -inform der -in <filename> -out <newfilename>
    
    Example converting certificate.cer:  
    
            openssl x509 -inform der -in certificate.cer -out certificate.pem
    
    Convert P7B/PKCS#7 to PEM Format:  
    
            openssl pkcs7 -print_certs -in <filename> -out <newfilename>
    
    Example converting certificate.p7b: 
    
            openssl pkcs7 -print_certs -in certificate.p7b -out certificate.cer
    
    Convert PFX/PKCS#12 to PEM Format:  
    
            openssl pkcs12 -in <filename> -out <newfilename> –nodes
    
    Example converting certificate.pfx:  
    
            openssl pkcs12 -in certificate.pfx -out certificate.cer –nodes

2.  Verify Private Key is in RSA format.  Review the private key file using a text editor.  Alternatively, if in Linux, the file can be viewed by running the command: `cat <filename> `.

    If Key Header looks like this:  `-----BEGIN PRIVATE KEY-----`  

    This is an indication the Key is not in the correct format and needs to be converted.
    Covert the file by running the following command (on a Linux server):  

        openssl rsa -in <old_file_name> -out  <new_file>

    Header should now look like this:  `-----BEGIN RSA PRIVATE KEY-----`

3.  Append all intermediate and root files into a single text file (example: `vm/certs/SSL.crt"`).  The appended files must not have any spaces between each start and end of file. 

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
    


The file is now ready for import.

# Renewing the SSL Certificate

1. We make the Domain / CA bunndle [per these instructions](https://iainhouston.com/devops/drupal/parish%20councils/2019/06/15/Annual_SSL_Renewal.html)

1. Decrypt the old Certificates:
    
        ansible-vault decrypt vm/certs/SSL.crt

1. Copy bundle from step 1 above into `SSL.crt`

1. Encrypt the new Certificates:  
    
        ansible-vault encrypt vm/certs/SSL.crt

1. Git add; commit; push above changes to our  `bradford-abbas.uk` repo on GitHub

1. `updateLiveCode` to re-configure the live server

1. Empty browser caches.

1. Use the browser to check the validity and expiry date of the https connec tion to [bradford-abbas.uk](https://bradford-abbas.uk/)
