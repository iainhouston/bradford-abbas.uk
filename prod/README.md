# This directory

This `prod` directory is for use after all the setting up and provisioning of dev and live servers; development and testing of new and existing features and when the tested code and configurations need to be deployed to the live (`prod`) server.

I kept this separate from the `vm` directory because that is quite complicated enough and I thought the task of updating code needed to be as simple, reliable and foolproof as I could make it and the method suggested in Jeff Geerlings "From Soup to Nuts" blog is so embedded in the general provisioning tasks and rôles that it became unnecessarily  complicated - and Jeff has added a pragraph to this blog stating that he will no longer support it; that he's not convinced its really mainstream, which echoes the fact that Drupal-VM is really about provisioning servers?

Objectives of updating the live server
======================================

1.	Use `drush` to put the website into maintenance mode

1.	Use `git` to checkout the latest committed `git@github.com:iainhouston/bradford-abbas.uk.git`

1.	Use `drush` to import the latest configuration settings from `config/sync` 

1.	Use `drush` to update the Drupal database

1.	Use `drush` to rebuild the Drupal system (cache)

1.	Use `drush` to take the website out of maintenance mode

Method of achieving the Objectives
==================================

+	Create a completely new `ansible-playbook` playbook in this directory

+	provide shortcut / alias `updateLiveCode` to invoke the playbook properly  

	```
	ansible-playbook prod/update.playbook.yml --inventory-file=vm/inventory
	```


