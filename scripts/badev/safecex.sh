#!/bin/zsh

# set -x
printf '%s\n' "Disabling development modules if they're enabled"
# : (True) will ignore pmu errors
#: $DRUSH $DEVALIAS pmu devel,kint
: $DRUSH $DEVALIAS pmu devel
printf '%s\n' "Exporting configurations from running Dev sysytem"
$DRUSH $DEVALIAS cex -y
