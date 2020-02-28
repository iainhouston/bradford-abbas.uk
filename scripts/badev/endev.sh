#!/usr/bin/env bash

#$DRUSH $DEVALIAS pm-enable devel kint -y
$DRUSH $DEVALIAS pm-enable devel -y
$DRUSH $DEVALIAS cr
echo "Note: Use of command ${RED}safecex${NC} will uninstall devel modules ...\nbefore exporting configuration to version-controlled ${GREEN}config/sync/*${NC}"
