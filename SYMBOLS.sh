# Important!
#
# You must check this PARAMETERS section against what names you wish to work with
# These symmbols parameterise several other scripts and provisioning tasks
# ... but not completely yet ...

# The idea is to have this repo apply to any Parish Council website
# Unfortunately, we have not yet completed the total parameterisation of the
# naming of the website domain names created.
# So domain names are still hard-coded into the following files:
# -  staging/inventory
# -  vm/inventory
# -  vm/vagrant.config.yml
# -  vm/prod.config.yml

# Project directory; created when cloned from GitHub thus:
# `cd && clone git@github.com:iainhouston/bradford-abbas.uk.git`
export BADEV="$HOME/bradford-abbas.uk"

# URL of Live, and Virtual Development and Staging sites
# Used, besides others, by gulp tasks in theme toolchain and Vagrantfile provisioning
export LIVESITE="bradford-abbas.uk"
export STAGESITE="staging.bradford-abbas.uk"
export DEVSITE="vagrant.bradford-abbas.uk"

# the following aliases must have corresponding `.yml` files in `drush/sites`
export LIVEALIAS="@balive"
export STAGEALIAS="@bastage"
export DEVALIAS="@badev"

# the following aliases must have corresponding `Host` settings in `~/.ssh/config`
export LIVE_SSH_ALIAS="webadmin"
export STAGING_SSH_ALIAS="stageadmin"

# End of main PARAMETERS section
# ______________________________

# Convenience commands change directory
alias cdp="cd $BADEV/"
alias cdw="cd $BADEV/web/"
alias cdl="cd $BADEV/web/libraries/ && ls $BADEV/web/libraries/"
alias cdm="cd $BADEV/web/modules/contrib/ && ls $BADEV/web/modules/contrib/"
alias cdt="cd $BADEV/web/themes/contrib/pellucid_olivero/ && ls ./"
alias cds="cd $BADEV/web/sites/default/"
alias cdf="cd $BADEV/web/sites/default/files/"
alias cdv="cd $BADEV/library/geerlingguy/drupal-vm"

# The `drush` we use for this project is installed locally with composer
export DRUSH="$BADEV/vendor/drush/drush/drush"
alias drush="$DRUSH"

# convenience commands for running utility scripts
export BADEVSCRIPTS="$BADEV/scripts/badev"

# send all code changes to Live system; install them and sync Live config with Dev config
alias updateLiveCode="sh $BADEVSCRIPTS/updateLiveCode.sh"

# Restore all files and database from the S3 backups and sync to DEV system
alias restoreFromS3="sh $BADEVSCRIPTS/restoreFromS3.sh"

# Put Live system into maintenance mode
alias livemaint="sh $BADEVSCRIPTS/livemaint.sh"

# Take Live system out of maintenance mode
alias liveunmaint="sh $BADEVSCRIPTS/liveunmaint.sh"

# Production to Development
alias rsyncp2dfiles="sh $BADEVSCRIPTS/rsyncProd2DevFiles.sh"
# exceptionally - bring dev Drupal Config settings in line with live ones
alias rsyncp2dconfig="rsync -avz --delete $LIVE_SSH_ALIAS:/var/www/drupal/config/sync/ ./config/sync/"

# Dumps: SQL and Static files
alias cloneLive2Dev="sh $BADEVSCRIPTS/cloneLive2Dev.sh"

# Dumps: SQL
alias sqldumpLive="sh $BADEVSCRIPTS/sqldumpLive.sh"
alias sqldumpDev="sh $BADEVSCRIPTS/sqldumpDev.sh"

# Safe export of configuration to ensure --dev modules are not enabled
alias safecex="sh $BADEVSCRIPTS/safecex.sh"

# Enable development modules
alias endev="sh $BADEVSCRIPTS/endev.sh"

# Reload Dev database
alias reloadDevDB="sh $BADEVSCRIPTS/reloadDevDB.sh"

# Provision Live Server and Upload Live static Data and dynamic Content
# OK, you won't want to do this very often!
alias initialiseLiveServer="sh $BADEVSCRIPTS/initialiseLiveServer.sh"
alias provisionLiveServer="sh $BADEVSCRIPTS/provisionLiveServer.sh"
alias populateLiveData="sh $BADEVSCRIPTS/populateLiveData.sh"

# For pretty printing
# See https://en.wikipedia.org/wiki/ANSI_escape_code
export RED='\x1B[0;31m'
export GREEN='\x1B[0;32m'
export NC='\x1B[0m' # No Colour

# Check versions of software required on this host machine
alias checkVersions='php --version && composer --version && vagrant --version && ruby --version && ansible --version && echo "NodeJS Version `node --version`" && echo "npm Version `npm --version`" && vagrant plugin list && echo "Developer Edition of `/Applications/Firefox\ Developer\ Edition.app/Contents/MacOS/firefox --version`"'
alias devSoftwareVersions='(checkVersions 2>&1) | tee  checkVersions.txt'
