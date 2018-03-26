#!/usr/bin/env bash

drush $DEVALIAS pm-enable link_css devel kint -y
drush $DEVALIAS cr
echo "Note: Use of command ${RED}safecex${NC} will uninstall devel modules ...\nbefore exporting configuration to version-controlled ${GREEN}config/sync/*${NC}"
