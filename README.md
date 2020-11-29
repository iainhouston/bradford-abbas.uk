# Development and maintenance of Bradford Abbas Parish Council website

Quick start
========

1. `cd && clone git@github.com:iainhouston/bradford-abbas.uk.git`

2. Add the following alias to your `~/.zshrc`;  `~/.bashrc` (or `~/.bash_aliases` as appropriate):

  ```
  alias cdbadev="cd ${HOME}/bradford-abbas.uk && source ./scripts/badev/dev_aliases.sh"
  ```

3. `$ source ~/.zshrc`

4. `$ cdbadev` =>

    ```sh
	  updateLiveCode - Code and Config to Live site
	  cloneLive2Dev  - Clone Live Database and Files to Dev site
	  safecex        - Safe export of Dev site's configuration
	  endev          - Enable development modules in Dev site
	```

Regular maintenance
===============

Further information  can be found in my web log post [Overview of the Parish Council website](https://iainhouston.com/bapcoverview/)


TO DO items
-----------

See [here](TODO.md)
