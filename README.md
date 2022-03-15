# Development and maintenance of Bradford Abbas Parish Council website

Quick start
========

1. `cd && clone git@github.com:iainhouston/bradford-abbas.uk.git`

2. Add the following alias to your `~/.zshrc`;  `~/.bashrc` (or `~/.bash_aliases` as appropriate):

  ```sh 
  alias cdbadev="cd ${HOME}/bradford-abbas.uk && source ./SYMBOLS.sh && source ./scripts/badev/motd.sh"
  ```
  
  `SYMBOLS.sh` is an essential file defining symbols used in other files dotted around this directory sructure 

3. `$ source ~/.zshrc`

4. `$ cdbadev` =>

    ```sh
	  updateLiveCode - Code and Config to Live site
	  cloneLive2Dev  - Clone Live Database and Files to Dev site
	  safecex        - Safe export of Dev site's configuration
	  endev          - Enable development modules in Dev site
	  ...
	  MOTD message
	```
    
5.  `vagrant up`

Web Server Provisioning
=======================

Step 5 above provisions the Development Server

[This file](prod/README.md) describes provisioning the Live Server

Website development and maintenance stategy
===============

Now you'll need to look in the web log post [Overview of the Parish Council website](https://iainhouston.com/bapcoverview/)


TO DO items
-----------

See [here](TODO.md)
