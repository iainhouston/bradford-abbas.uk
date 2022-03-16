## About this directory

Before attempting to run any of the scripts described below, do not forget to do `cdbadev` to ensure that you're in the **project's working directory:** `~/bradford-abbas.uk` and that the aliases for the utility scripts have been assigned by `SYMBOLS.sh`.

Regarding this subdirectory `prod`: it contains settings and variables that serve two purposes:  

1. **Updating Live Code** Most commonly for routine use after  development and testing of new and existing features and when the tested code and configurations need to be deployed to the live (`prod`) server.

	I kept this separate from the `vm` directory because that is quite complicated enough and is essentially for provisioning the Development VM and the Live remote web server.  
    
    I thought the task of updating code needed to be as simple, reliable and foolproof as I could make it and the method suggested in Jeff Geerlings "From Soup to Nuts" blog is so embedded in the general provisioning tasks and rôles that it became unnecessarily complicated - and Jeff has added a pragraph to this blog stating that he will no longer support it. So I have "forked" hhis code into this repo's `library` directory.

1. *Very* occasionally to **provision the Live server**; a fresh Ubuntu image when, for instance, we upgrade to a more recent Ubuntu LTS release.

#1. Updating


##Objectives of updating the live server

1.	Use `drush` to put the website into maintenance mode

1.	Copy the SSL Certificate and Private key

1.	Use `git` to checkout the latest committed `git@github.com:iainhouston/bradford-abbas.uk.git`

1.	Use `drush` to update the Drupal database

1.	Use `drush` to rebuild the Drupal system (cache)

1.	Use `drush` to import the latest configuration settings from `config/sync`

1.	Use `drush` to take the website out of maintenance mode

##Method of achieving the Objectives

+	Create a completely new `ansible-playbook` playbook in this directory

+	Provide shortcut / alias `updateLiveCode` to invoke the playbook properly  

	+ see `scripts/badev/updateLiveCode.sh`

#2. Initialising the server


##How to set up the administrator account `webadmin` prior to provisioning the new live server

We use *live* and *prod*uction interchangeably here.

From the project directory run the `initialiseLiveServer` script.


**Notes**

1. To do this you must have public key authentication to the Live Server's *root* account. 

    `initialiseLiveServer` will create admin user `webadmin` per contents of `prod/secrets.yml`

1. Linux user names and passwords are encrypted in `prod/secrets.yml`.  

1. The `ansible-vault` password used to decrypt `prod/secrets.yml` must reside in `~/.vaultpw`.

1. To inspect `prod/secrets.yml`: from the project directory `~/bradford-abbas.uk` (using the password found with `cat ~/.vaultpw`) do:

	    ansible-vault view  prod/secrets.yml
	    ansible-vault edit  prod/secrets.yml

Now we are ready to provision the prod server.

But first, just check that you can do `ssh webadmin`, with `~/.ssh/config` having:

        Host webadmin
            User webadmin
            Hostname bradford-abbas.uk
            PreferredAuthentications publickey

##Provisioning the new Live server

`provisionLiveServer` is run from the project directory.

**Notes**  

1. The vault and superuser Ansible "become" passwords are identical; this password must reside in `~/.vaultpw`.

1. The origin of this Linux password is documented in `../prod/secrets.yml`. It is generated from `openssl passwd -1 <origin>`
    
1. `provisionLiveServer` is a utility script that will invoke an Ansible playbook that builds all the software on the Ubuntu Linux platform and will install the Drupal PHP code and creates an empty SQL database.

##Populating the Live Server with dynamic and static Content and Configuration settings

`populateLiveData` is run from the project directory.

**Notes** 

1. The  utility script `populateLiveData` will poulate the Live Server with data previously backed up from a Live Server OR exceptionally bootstrap data for a completely new website starting from scratch.

1. Database Content: `populateLiveData` requires `mostRecentLive.sql` as the source for the Drupal datbase content
        
1. Static Data Files: `populateLiveData` requires a directory hierarchy at `./web/sites/default/files/` as the source of any static fiules to be uploaded to the Live Server

1. Both static and dynamic content are backed up once a week to a Amazon S3 Server. The login credentials to the Amazon Web Services (AWS) account are recorded on the USB drive in the posession of the Parish Clerk. 

1. The contents of `./web/sites/default/files/` and `mostRecentLive.sql` ca be obtained either by downloading the mazon S3 buckets or from cloning tthe Live data to the Development system with `cloneLive2Dev`

1. TODO: create a starting SQL file and `./web/sites/default/files/` hhierarchy for possible creation of other Parish Councils' websites from scratch.

#Tasks post provisioning

##Ensure postfix is working correctly

Look at `TryPostfix.md` in this directory.

