Verifying that the new live server can send emails OK
-----------------------------------------------------

-  Log into the live server
-  create `/tmp/mail.txt`

	    To: iainhouston@mac.com
	    Subject: sendmail test
	    From: webadmin@bradford-abbas.uk

	    An e-mail body, test test test..

-  do `sendmail -vt < /tmp/mail.txt`

-  Have a look at the headers in the recipient's email

    -  DKIM header should be there
    - Authentication should pass DKIM and so should SPF

-  If that looks OK

	- Go to the SwiftMailer configuration on the staging server and send a test message

	- If that fails, have a look at the `Sender` in the `Mail System` configuration

		- `Swift Mailer` usually works but the `Default PHP Mailer` worked on the LCN Server and was useful for `mailhog` testing on the development system


