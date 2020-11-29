# Project directory; created when cloned from GitHub
export BADEV="$HOME/bradford-abbas.uk"

# Convenience commands change directory
alias cdp="cd $BADEV/"
alias cdw="cd $BADEV/web/"
alias cdl="cd $BADEV/web/libraries/ && ls $BADEV/web/libraries/"
alias cdm="cd $BADEV/web/modules/contrib/ && ls $BADEV/web/modules/contrib/"
alias cdt="cd $BADEV/web/themes/contrib/pellucid_olivero/ && ls ./"
alias cds="cd $BADEV/web/sites/default/"
alias cdf="cd $BADEV/web/sites/default/files/"
alias cdv="cd $BADEV/vendor/geerlingguy/drupal-vm"

# the following aliases must have corresponding `Host` settings in `~/.ssh/config`
export LIVE_SSH_ALIAS="webadmin"
export STAGING_SSH_ALIAS="stageadmin"

# the following aliases must have corresponding `.yml` files in `drush/sites`
export DEVALIAS="@badev"
export STAGEALIAS="@bastage"

export DRUSH="$BADEV/vendor/drush/drush/drush"
alias drush="$DRUSH"

# convenience commands for running utility scripts live here
export BADEVSCRIPTS="$BADEV/scripts/badev"

echo "updateLiveCode - Code and Config to Live site"
alias updateLiveCode="sh $BADEVSCRIPTS/updateLiveCode.sh"

# Production to Development
alias rsyncp2dfiles="sh $BADEVSCRIPTS/rsyncProd2DevFiles.sh"
# exceptionally - bring dev Drupal Config settings in line with live ones
alias rsyncp2dconfig="rsync -avz --delete $LIVE_SSH_ALIAS:/var/www/drupal/config/sync/ ./config/sync/"

# Dumps: SQL and Static files
echo "cloneLive2Dev  - Clone Live Database and Files to Dev site"
alias cloneLive2Dev="sh $BADEVSCRIPTS/cloneLive2Dev.sh"

# Dumps: SQL
alias sqldumpLive="sh $BADEVSCRIPTS/sqldumpLive.sh"
alias sqldumpDev="sh $BADEVSCRIPTS/sqldumpDev.sh"

# Safe export of configuration to ensure --dev modules are not enabled
echo "safecex        - Safe export of Dev site's configuration"
alias safecex="sh $BADEVSCRIPTS/safecex.sh"

# Enable development modules
echo "endev          - Enable development modules in Dev site"
alias endev="sh $BADEVSCRIPTS/endev.sh"

# For pretty printing
# See https://en.wikipedia.org/wiki/ANSI_escape_code
export RED='\x1B[0;31m'
export GREEN='\x1B[0;32m'
export NC='\x1B[0m' # No Colour

# Check versions of software required on this machine
alias checkVersions='php --version && composer --version && vagrant --version && echo "VirtualBox `vboxmanage --version`" && ruby --version && ansible --version && echo "NodeJS Version `node --version`" && echo "npm Version `npm --version`" && vagrant plugin list && echo "Developer Edition of `/Applications/Firefox\ Developer\ Edition.app/Contents/MacOS/firefox --version`"'
alias devSoftwareVersions='(checkVersions 2>&1) | tee  checkVersions.txt'
