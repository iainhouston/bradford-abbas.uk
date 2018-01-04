# Development and maintenance of Bradford Abbas Parish Council website

How to set up the development site on MacBook
===============

I used Jeff Geerling's Drupal-VM to create a local Drupal server per his [tutorial](https://www.jeffgeerling.com/blog/2017/soup-nuts-using-drupal-vm-build-local-and-prod#comment-7231).

Just a few differences:

1. Instead of his `vagrant.config.yml` we needed to name it `local.config.yml`

2. These commands were run inside the vagrant VM since the `drush loader` seemed to have problems with the aliases when running the `..sync` commands.

```
vagrant ssh
cd /var/www/drupal/web
drush rsync  @balive:%files @self:%files
drush sql-sync  @balive @self
drush   updb
```

Managing the secrets file
---------------------------

This is where the drupal admin pw, drupal db pw and mysql root pw are encoded.

```
ansible-vault create  vm/secrets.yml
ansible-vault view  vm/secrets.yml
ansible-vault edit  vm/secrets.yml
```


Initialising the staging server
-------------------------------

Enable `root` login on EC2 server. This assumes that we have the AWS EC2 server accounts private key in `~/.ssh/BAPC-2.pem` on the Mac


```
ssh ubuntu@staging.bradford-abbas.uk # from local
sudo emacs /root/.ssh/authorized_keys # on rremote
exit # back to local (MacBook) after editing authorized_keys on remote as below

```

Remove the preamble before the string `ssh-rsa` in `/root/.ssh/authorized_keys`

Create `vendor/geerlingguy/drupal-vm/examples/prod/bootstrap/vars.yml` per the tutorial creating a new
admin account (`webmaster`) on the server with the password recorded in `Vault PW` here on the Mac.

Now run the 'init' playbook.

```
ansible-playbook -i vm/staging.inventory vendor/geerlingguy/drupal-vm/examples/prod/bootstrap/init.yml -e "ansible_ssh_user=root"
```

We should now have created `webmaster` and be able to `ssh webmaster@staging.bradford-abbas.uk` and thence `sudo`  things using the password recorded in `Vault PW` here on the Mac.


Provisioning the staging server
--------------------------------

We'll try:

```
DRUPALVM_ENV=prod ansible-playbook -i vm/staging.inventory vendor/geerlingguy/drupal-vm/provisioning/playbook.yml -e "config_dir=$(pwd)/vm" --become --ask-become-pass --ask-vault-pass
```
