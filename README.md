# Development and maintenance of Bradford Abbas Parish Council website

Quick start
========

1. Clone this repo to `~/bapc-drupal9`

2. Add the following alias to your `~/.zshrc`;  `~/.bashrc` (or `~/.bash_aliases` as appropriate):

  ```
  alias cdba9dev="cd ${HOME}/bapc-drupal9 && source ./scripts/badev/dev_aliases.sh"
  ```

3. `$ source ~/.zshrc`

4. `$ cdba9dev` =>

    ```sh
	  updateLiveCode - Code and Config to Live site
	  cloneLive2Dev  - Clone Live Database and Files to Dev site
	  safecex        - Safe export of Dev site's configuration
	  endev          - Enable development modules in Dev site
	```

Regular maintenance
===============

Exhaustive detail can be found in my web log document ["DrupalVM in use"](https://iainhouston.com/drupalbapc/)


TO DO items
-----------

See [here](TODO.md)
