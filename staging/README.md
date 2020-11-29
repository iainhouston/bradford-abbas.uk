
TODO
-----
Quite a bit!

This file is about moving the production *old* server to a *new* machine.

You'll need to inspect and be prepared to alter the variables in `./init.yml`, `../scripts/badev/dev_aliases`, `../drush/sites/bastage.site.yml`, and `~/.ssh/config`

How to create a virtual staging machine
---------------------------------------

You may like to do this to practice provisioning the new server by setting up and provisioning this virtual staging server first

 -  Create a new directory:  
 
    	cd && mkdir staging.bradford-abbas.uk
    	cd ~/staging.bradford-abbas.uk && vagrant box add geerlingguy/ubuntu2004

  - copy `Vagrantfile.rb` in this (`staging`) directory to `~/staging.bradford-abbas.uk/Vagrantfile` (NB: no `.rb` file extension)

  - `vagrant up` and then `vagrant ssh` into the guest virtual machine ~~~(not quite sure why the next step fails if we forget to do this `vagrant ssh` first); have a look around, and then `exit` back to the host machine~~~

  

How to set up the administrator account prior to provisioning the new staging server
-----------------------------------------------------------------------------

Instructions for generating, and information about the user names and passwords
are encrypted in `staging/secrets.yml`

From the project directory:

    ansible-vault view  staging/secrets.yml
    ansible-vault edit  staging/secrets.yml

Run the `init.yml` playbook:

From the project directory:

    ansible-playbook staging/init.yml \
        --inventory-file=staging/inventory \
        --extra-vars="ansible_ssh_user=vagrant" \
        --vault-password-file="~/.vaultpw"

 Now you are ready to provision the staging server.
 
 But first, just check; with `~/.ssh/config` having:

        Host stageadmin
            User webadmin
            Hostname staging.bradford-abbas.uk
            PreferredAuthentications publickey

we can `ssh stageadmin`

 Provisioning the new staging server
 ---------------

 The vault and superuser "become" passwords are both identical; this password must reside in `~/.vaultpw`.  
 
 **Important** The origin of this password is documented in `../staging/secrets.yml`.  
 It is generated from `openssl passwd -1 <origin>`

     DRUPALVM_ENV=prod ansible-playbook vendor/geerlingguy/drupal-vm/provisioning/playbook.yml \
     --inventory-file=staging/inventory \
     --vault-password-file="~/.vaultpw" \
     --extra-vars="config_dir=$(pwd)/vm" \
     --skip-tags=test_only \
     --extra-vars="ansible_ssh_user=vagrant" \
     --ask-become-pass




