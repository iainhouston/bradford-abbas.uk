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
