# Development and maintenance of Bradford Abbas Parish Council website

How to set up the development site on Mac
===============

I used Jeff Geerling's Drupal-VM to create a local Drupal server per his [tutorial](https://www.jeffgeerling.com/blog/2017/soup-nuts-using-drupal-vm-build-local-and-prod).

Just a few notes:

Development setup
-----------------

1. Local environment at this time:

    ```
    python --version #==> Python 2.7.14
    ansible --version #==> ansible 2.4.2.0
    vagrant --version #==> Vagrant 2.0.1
    VBoxManage --version #==> Virtual Box 5.2.4r119785
    composer --version  #==> ... 1.6.2 2018-01-05 15:28:4
    ```

    Experience shows that unexplained provisioning errors can often disappear after having upgraded to the latest of each of `ansible`; `vagrant`; and `VirtalBox`.

1. Ensure that the `DRUPALVM_ENV` environment variable is correctly set by issuing vagrant commands in the form: `DRUPALVM_ENV=vagrant vagrant up` and `DRUPALVM_ENV=vagrant vagrant provision`

2. Run these commands *inside* the vagrant VM (or prod server) - regardless of whether you're using `drush` 8.1.15 or ~9.0  - only one of the aliases can be remote when running the `(sql-|r)sync` command. e.g.:

    ```
    vagrant ssh
    drush rsync  @balive:%files @self:%files --exclude-paths=sync:css:js:php
    drush sql-sync  @balive @self
    drush @self updb
    ```

    Although Jeff recommends - and we shold try:

    > If you're still having issues, you can avoid `sql-sync` entirely
    > and pipe the mysqldump output yourself with:
    `drush @remote sql-dump | drush @drupalvm.drupalvm.test sql-cli``


3. I had unexplained errors with `drush/drush:8.1.15` so switched to `drush/drush:~9.0`. This means that I also required `ansible` to install  the [Drush Launcher](https://github.com/drush-ops/drush-launcher). The only real effect on provisioning `vagrant` and `prod` is in the default (prod) `config.yml` we have:

    ```
    drush_launcher_version: "0.5.0"
    drush_phar_url: https://github.com/drush-ops/drush-launcher/releases/download/{{ drush_launcher_version }}/drush.phar
    ```

    It really is as simple as that. OK, well, we also needed to convert our alias files into `.yml`.

From Development to Production
==============================

Once we have created encrypted a `secrets.yml` file for production; should we wish to reprovision our vagrant development server, we will need to supply our vault password tp Ansible which vagrant will only do after we have added this to our delegate `Vagrantfile` located in the project root.

```
ENV['DRUPALVM_ANSIBLE_ARGS'] = '--ask-vault-pass'
```


Managing the secrets file
---------------------------

This is where the passwords for drupal admin, drupal db; and mysql root;  are encoded.

```
ansible-vault create  vm/secrets.yml
ansible-vault view  vm/secrets.yml
ansible-vault edit  vm/secrets.yml
```


Initialising the AWS EC2 staging server
-------------------------------

1. Enable `root` login on EC2 server. This assumes that we have the AWS EC2 server accounts private key in `~/.ssh/BAPC-2.pem` on the Mac

  ```
  ssh ubuntu@remote.server.uk # from local
  sudo emacs /root/.ssh/authorized_keys # on remote
  ```

2. On EC2 server: remove the preamble before the string `ssh-rsa` in `/root/.ssh/authorized_keys`

3. On local control machine: Create `vendor/geerlingguy/drupal-vm/examples/prod/bootstrap/vars.yml` per the tutorial creating a new
admin account (`webmaster`) on the server with the password recorded in `Vault PW` here on the Mac.

4. On local control machine: run the 'init' playbook.

  ```
  ansible-playbook -i vm/staging.inventory vendor/geerlingguy/drupal-vm/examples/prod/bootstrap/init.yml -e "ansible_ssh_user=root"
  ```

  We should now have created `webmaster` and be able to `ssh webmaster@remote.server.uk` and thence `sudo`  things using the password recorded in `Vault PW` here on the Mac.

5. On EC2 server: revert the preamble before the string `ssh-rsa` in `/root/.ssh/authorized_keys` to prevent anyone logging into `root` directly.

Provisioning the Production server
==================================

```
DRUPALVM_ENV=prod ansible-playbook \
-i vm/inventory vendor/geerlingguy/drupal-vm/provisioning/playbook.yml \
-e "config_dir=$(pwd)/vm" \
--become --ask-become-pass \
--ask-vault-pass
```

Running additional tasks not in Drupal VM's provisioning roles and tasks
-------------------------------------------

To use an extra ansible task file, configure the path to the file (relative to `provisioning/playbook.yml`) in `<DRUPALVM_ENV>config.yml`:


A note about provisioning a staging server
--------------------------------

Couldn't make Drupal VM deal with `DRUPALVM_ENV=staging` and `staging.inventory` etc. so we're sticking to a `DRUPALVM_ENV=prod`-only approach and will switch staging->live in due course either by provisioning a new EC2 server or just reprovisioning this one after having changed relvevant `inventory` settings and `prod.config.yml` and DNS settings.


TO DO items
-----------

See [here](TODO.md)
