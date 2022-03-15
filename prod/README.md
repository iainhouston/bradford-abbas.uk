## About this directory

Before attempting to run any of the scripts described below, do not forget to `cdbadev` to ensure that you're in the project's working directory.

Regarding this directory: it contains settings and variables that serve two purposes:  

1. Most commonly for use after all the setting up and provisioning of dev and live servers; development and testing of new and existing features and when the tested code and configurations need to be deployed to the live (`prod`) server.

	I kept this separate from the `vm` directory because that is quite complicated enough and I thought the task of updating code needed to be as simple, reliable and foolproof as I could make it and the method suggested in Jeff Geerlings "From Soup to Nuts" blog is so embedded in the general provisioning tasks and rôles that it became unnecessarily  complicated - and Jeff has added a pragraph to this blog stating that he will no longer support it; that he's not convinced its really mainstream, which echoes the fact that Drupal-VM is really about provisioning servers?

1. Occasionally to provision a fresh Ubuntu image when, for instance, we upgrade to a more recent Ubuntu LTS release.

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

Linux user names and passwords are encrypted in `prod/secrets.yml`.  

From the project directory `~/bradford-abbas.uk`:

	    ansible-vault view  prod/secrets.yml
	    ansible-vault edit  prod/secrets.yml

From the project directory `~/bradford-abbas.uk` run the `init.yml` playbook:

(This assumes that the host provider initialises the Linux image with `root` access or that you have temporarily enabled `root` access.)

	    ansible-playbook prod/init.yml \
	        --inventory-file=prod/inventory \
	        --extra-vars="ansible_ssh_user=root" \
	        --vault-password-file="~/.vaultpw"

The step above will create admin user `webadmin` per contents of `prod/secrets.yml`

Now we are ready to provision the prod server.

But first, just check, with `~/.ssh/config` having:

        Host webadmin
            User webadmin
            Hostname bradford-abbas.uk
            PreferredAuthentications publickey

that we can `ssh webadmin`

##Provisioning the new Live server

This step is run from the project directory.

The vault and superuser "become" passwords are both identical; this password must reside in `~/.vaultpw`.

**Important** The origin of this Linux password is documented in `../prod/secrets.yml`.
It is generated from `openssl passwd -1 <origin>`
    
`provisionLiveServer` is a utility script that will invoke an Ansible playbook that builds all the software on the Ubuntu Linux platform and install the Drupal PHP code and creates an empty SQL database.

##Populating the Live Server with Content and Configuration settings

The  utility script `populateProdData` will poulate the Live Server with data previously backed up from a Live Server OR exceptionally bootstrap data for a completely new website starting from scratch.

TODO: create a starting SQL file for possible creation of other Parish Councils' websites from scratch.

###Database Content
The  utility script `populateProdData` requires `mostRecentLive.sql` as the source for the Drupal datbase content
        
###Static Data Files

The  utility script `populateProdData` requires a directory hierarchy at `./web/sites/default/files/` as the source of any static fiules to be uploaded to the Live Server

##Ensure postfix is working correctly

Look at `TryPostfix.md` in this directory.

##Copy static data to the live server

*TBD*

##Restore MYSql database data to the live server

*TBD*
