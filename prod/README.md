# This directory

This `prod` directory has two purposes:  

1. Most commonly for use after all the setting up and provisioning of dev and live servers; development and testing of new and existing features and when the tested code and configurations need to be deployed to the live (`prod`) server.

	I kept this separate from the `vm` directory because that is quite complicated enough and I thought the task of updating code needed to be as simple, reliable and foolproof as I could make it and the method suggested in Jeff Geerlings "From Soup to Nuts" blog is so embedded in the general provisioning tasks and rôles that it became unnecessarily  complicated - and Jeff has added a pragraph to this blog stating that he will no longer support it; that he's not convinced its really mainstream, which echoes the fact that Drupal-VM is really about provisioning servers?
	
1. Occasionally to provision a fresh Ubuntu image when, for instance, we upgrade to a more recent Ubuntu LTS release.

(1) Updating
--------

Objectives of updating the live server
======================================

1.	Use `drush` to put the website into maintenance mode

1.	Copy the SSL Certificate and Private key

1.	Use `git` to checkout the latest committed `git@github.com:iainhouston/bradford-abbas.uk.git`

1.	Use `drush` to update the Drupal database

1.	Use `drush` to rebuild the Drupal system (cache)

1.	Use `drush` to import the latest configuration settings from `config/sync`

1.	Use `drush` to take the website out of maintenance mode

Method of achieving the Objectives
==================================

+	Create a completely new `ansible-playbook` playbook in this directory

+	Provide shortcut / alias `updateLiveCode` to invoke the playbook properly  

	+ see `scripts/badev/updateLiveCode.sh`
	
(2) Initialising the server
-----------------------

TODO *copy and edit from staging README*

How to set up the administrator account prior to provisioning the new live server
=================================================================================

We use *live* and *prod*uction interchangeably here.

User names and passwords are encrypted in `prod/secrets.yml`. The

From the project directory `~/bradford-abbas.uk`:

    ansible-vault view  prod/secrets.yml
    ansible-vault edit  prod/secrets.yml

From the project directory `~/bradford-abbas.uk` run the `init.yml` playbook:

(This assumes that the host provider initialises the Linux image with `root` access.)

    ansible-playbook prod/init.yml \
        --inventory-file=prod/inventory \
        --extra-vars="ansible_ssh_user=root" \
        --vault-password-file="~/.vaultpw"
		
The step above will create admin user `webadmin` per contents of `prod/secrets.yml`

 Now we are ready to provision the prod server.

 But first, just check; with `~/.ssh/config` having:

        Host stageadmin
            User webadmin
            Hostname prod.bradford-abbas.uk
            PreferredAuthentications publickey

we can `ssh stageadmin`

 Provisioning the new prod server
 ---------------

 This step is run from the project directory.

 The vault and superuser "become" passwords are both identical; this password must reside in `~/.vaultpw` but you'll also be asked to enter it when running the provisionuing playbook next.

 **Important** The origin of this password is documented in `../prod/secrets.yml`.
 It is generated from `openssl passwd -1 <origin>`

     DRUPALVM_ENV=prod ansible-playbook vendor/geerlingguy/drupal-vm/provisioning/playbook.yml \
     --inventory-file=prod/inventory \
     --vault-password-file="~/.vaultpw" \
     --extra-vars="config_dir=$(pwd)/vm" \
     --skip-tags=test_only \
     --ask-become-pass
