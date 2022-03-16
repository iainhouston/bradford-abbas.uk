# Development and maintenance of Bradford Abbas Parish Council website

## Quick start. 

1. `cd && clone git@github.com:iainhouston/bradford-abbas.uk.git`

2. Add the following alias to your `~/.zshrc`;  `~/.bashrc` (or `~/.bash_aliases` as appropriate):

  ```sh 
  alias cdbadev="cd ${HOME}/bradford-abbas.uk && source ./SYMBOLS.sh && source ./scripts/badev/motd.sh"
  ```
  
  `SYMBOLS.sh` is an essential file defining symbols used in other files dotted around this directory sructure 

3. `% source ~/.zshrc`

4. `% cdbadev` =>  
  
    ```sh
        checkVersions  - Review  software required for development
        cloneLive2Dev  - Sync live database and static files to Dev server
        reload_db      - Reload Dev database with most recently downloaded live database
        endev          - Enable development modules in Dev site
        safecex        - Safe export of Dev site's configuration
        updateLiveCode - Code and Config to Live site
        	  ...
        MOTD message
	```
    
5.  `vagrant up` 
    
## Provisioning

Step 5 above provisions the **Development** Server

You will find [detailed instructions](prod/README.md) to provision the **Live** Server

## Required software

On the development machine into which this repo is cloned, you'll need to have installed:

+  PHP (to run drush)

+  Composer (to install Drupal and contributed modules and Themes) 

+  Vagrant and vagrant plugins (to run the provisioning tasks)

+  Ruby (required by `vagrant`; available by default on MacOS)

+  Ansible (to run the provisioning tasks). 

+  NodeJS and npm (Required when developing the website's Appearance / Theme)  

+  Firefox Developer Edition (favourite browser when developing the Theme's CSS)

Do `checkVersions` to list the versions of all the above required software. A typical out is incuded below.

## Website development and maintenance stategy

Now you'll need to look in my web log post [Overview of the Parish Council website](https://iainhouston.com/bapcoverview/)


## TO DO items

See [here](TODO.md)

## Typical versions for required software  

+ `% checkVersions` =>  
  
    ```sh
        √ bradford-abbas.uk % checkVersions
        PHP 8.0.16 (cli) (built: Mar  1 2022 09:59:14) ( NTS )
        Copyright (c) The PHP Group
        Zend Engine v4.0.16, Copyright (c) Zend Technologies
            with Zend OPcache v8.0.16, Copyright (c), by Zend Technologies
        Composer version 2.1.3 2021-06-09 16:31:20
        Vagrant 2.2.18
        ruby 2.6.8p205 (2021-07-07 revision 67951) [universal.x86_64-darwin21]
        ansible [core 2.12.2]
          config file = /Users/iainhouston/bradford-abbas.uk/ansible.cfg
          configured module search path = ['/Users/iainhouston/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
          ansible python module location = /usr/local/Cellar/ansible/5.3.0/libexec/lib/python3.10/site-packages/ansible
          ansible collection location = /Users/iainhouston/.ansible/collections:/usr/share/ansible/collections
          executable location = /usr/local/bin/ansible
          python version = 3.10.2 (main, Feb  2 2022, 06:19:27) [Clang 13.0.0 (clang-1300.0.29.3)]
          jinja version = 3.0.3
          libyaml = True
        NodeJS Version v17.7.1
        npm Version 8.5.2
        vagrant-auto_network (1.0.3, global)
        vagrant-hostsupdater (1.2.4, global)
        vagrant-parallels (2.2.4, global)
        vagrant-vbguest (0.30.0, global)
        Developer Edition of Mozilla Firefox 99.0b2
    ```  
    
Fin
