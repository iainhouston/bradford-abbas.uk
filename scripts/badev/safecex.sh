#!/bin/zsh

# set -x
printf '%s\n' "Disabling development modules if they're enabled"
# : (True) will ignore pmu errors
#: $DRUSH $DEVALIAS pmu devel,kint
#$DRUSH $DEVALIAS pm:uninstall upgrade_status, devel, devel_entity_updates, devel_kint_extras -y
$DRUSH $DEVALIAS pm:uninstall upgrade_status, core-dev
printf '%s\n' "Exporting configurations from running Dev sysytem"
$DRUSH $DEVALIAS cex -y
