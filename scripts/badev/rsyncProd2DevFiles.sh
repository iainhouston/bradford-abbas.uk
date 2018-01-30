#!/usr/bin/env bash

rsync -avz $LIVE_SSH_ALIAS:/var/www/drupal/web/sites/default/files/ \
$BADEV/web/sites/default/files/ \
--exclude=js --exclude=php --exclude=css
