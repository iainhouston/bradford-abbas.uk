
TODO
-----
Quite a bit!

This file is about moving the production *old* server to a *new* machine.

You'll need to inspect and be prepared to alter the variables in `./init.yml`, `../scripts/badev/dev_aliases`, `../drush/sites/bastage.site.yml`, and `~/.ssh/config`

How to create a virtual staging machine
---------------------------------------

You may like to do this to practice provisioning the new server by setting up and provisioning this virtual staging server first

-  Add shortcut command to `~/.zshrc`



 -  Create a new virtual machine:

    	cd && mkdir staging.bradford-abbas.uk
    	cdbastage # assign sybols and change directory
    	vagrant box add geerlingguy/ubuntu2004

  - copy `~/bradford-abbas.uk/staging/Vagrantfile.rb` to `~/staging.bradford-abbas.uk/Vagrantfile` (NB: no target `.rb` file extension)

  - `vagrant up` and then `vagrant ssh` into the guest virtual machine ~~(do we really need to do this `vagrant ssh` first?);~~ have a look around, and then `exit` back to the host machine.

  -  `ssh-copy-id vagrant@staging.bradford-abbas.uk` using password `vagrant` so that the following  Ansible playbook can access the virtual Staging Server without further need for a password.



How to set up the administrator account prior to provisioning the new staging server
-----------------------------------------------------------------------------

Instructions for generating, and information about the user names and passwords
are encrypted in `staging/secrets.yml`. The

From the project directory `~/bradford-abbas.uk`:

    ansible-vault view  staging/secrets.yml
    ansible-vault edit  staging/secrets.yml

From the project directory `~/bradford-abbas.uk` run the `init.yml` playbook:

    ansible-playbook staging/init.yml \
        --inventory-file=staging/inventory \
        --extra-vars="ansible_ssh_user=vagrant" \
        --vault-password-file="~/.vaultpw"

 Now we are ready to provision the staging server.

 But first, just check; with `~/.ssh/config` having:

        Host stageadmin
            User webadmin
            Hostname staging.bradford-abbas.uk
            PreferredAuthentications publickey

we can `ssh stageadmin`

 Provisioning the new staging server
 ---------------

 This step applies both when the target Staging Server is a virtual or a real one. It is run from the project directory.

 The vault and superuser "become" passwords are both identical; this password must reside in `~/.vaultpw` but you'll also be asked to enter it when running the provisionuing playbook next.

 **Important** The origin of this password is documented in `../staging/secrets.yml`.
 It is generated from `openssl passwd -1 <origin>`

     DRUPALVM_ENV=prod ansible-playbook vendor/geerlingguy/drupal-vm/provisioning/playbook.yml \
     --inventory-file=staging/inventory \
     --vault-password-file="~/.vaultpw" \
     --extra-vars="config_dir=$(pwd)/vm" \
     --skip-tags=test_only \
     --ask-become-pass




