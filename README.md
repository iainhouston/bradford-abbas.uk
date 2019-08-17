# Development and maintenance of Bradford Abbas Parish Council website

Quick start
========

1. Clone this repo to `~/bradford-abbas.uk`

2. Add the following alias to your `~/.bashrc` (or `~/.bash_aliases` as appropriate):

  ```
  alias cdbadev="cd ~/bradford-abbas.uk && source ./scripts/badev/.dev_aliases"
  ```

3. `$ source ~/.bashrc`

4. `$ cdbadev` =>

  ```
  updateLiveCode - Code and Config to Live site
  rsyncp2dfiles  - Get latest files from live site
  sqldumpLive    - Get latest SQL from live site
  ```

Regular maintenance
===============

Pushing updated stuff to the live site
-----------------------

`updateLiveCode` is shorthand for:

```
DRUPALVM_ENV=prod \
ansible-playbook vendor/geerlingguy/drupal-vm/provisioning/playbook.yml \
--inventory-file=vm/inventory \
--tags=drupal   \
--extra-vars="config_dir=$(pwd)/vm" \
--become --ask-become-pass --ask-vault-pass
```

This doesn't re-provision the live server, it does just those playbook tasks - those with `tags: ['drupal']` - required to update the following:

*  Drupal core and contributed modules (via `composer.json`)
*  Our SSL key and certificate
*  Drupal configuration YAML from most recent  `drush @badev cex`   
   *but note that it doesn't run a*  `drush @balive cim`

So you run `updateLiveCode` when any of these have been updated and tested on the local development site.

More important detail can be found in my blog post ["DrupalVM in use"](https://iainhouston.com/drupalbapc/)


TO DO items
-----------

See [here](TODO.md)
