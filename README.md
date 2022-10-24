# Development and maintenance of Bradford Abbas Parish Council website

## Development system hardware architecture

As of October 24th 2022 the *dev* system will now work on Apple Silicon (ARM64) hardware but should also work on an Intel hardware platform just by choosing the appropriate Bento box and editing it into `vm/vagrant.config.yml`

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

+  Virtualisation software (I use Parallels, previously Oracle Virtualbox)

+  PHP (to run drush)

+  Composer (to install Drupal and contributed modules and Themes) 

+  Vagrant and vagrant plugins (to run the provisioning tasks)

+  Ruby (required by `vagrant`; available by default on MacOS)

+  Ansible (to run the provisioning tasks). 

+  NodeJS and npm (Required when developing the website's Appearance / Theme)  

+  Firefox Developer Edition (favourite browser when developing the Theme's CSS)

Do `checkVersions` to list the versions of all the above required software. A typical out is incuded below.

**Notes:**

+  I use `brew install ...` to install PHP, Composer, Vagrant, Ansible, and NodeJS (node). Very convenient. 

+  I purchased Parallels Desktop for other reasons. I used the free Oracle VirtualBox for many years but quite frequently came across issues of compatibility with other components. 

+  Different virtual boxes implicitly require different virtualisation software. `vagrant_box: bento/ubuntu-20.04` used in `vm/vagrant.conf.yml` is configured to require Parallels virtualisation

+  Last but not least: ["Get the latest features, fast performance, and the development tools you need to build for the open web"](https://www.mozilla.org/en-GB/firefox/developer/)

## Website development and maintenance stategy

Now you'll need to look in my web log post [Overview of the Parish Council website](https://iainhouston.com/bapcoverview/)


## TO DO items

See [here](TODO.md)

## Typical versions for required software  

2`% checkVersions` =>  
  
    ```sh 
        √ bradford-abbas.uk % checkVersions
        PHP 8.1.11 (cli) (built: Sep 29 2022 19:44:28) (NTS)
        Copyright (c) The PHP Group
        Zend Engine v4.1.11, Copyright (c) Zend Technologies
            with Zend OPcache v8.1.11, Copyright (c), by Zend Technologies
        Composer version 2.4.3 2022-10-14 16:56:41
        Vagrant 2.3.2
        ruby 2.6.8p205 (2021-07-07 revision 67951) [universal.arm64e-darwin21]
        ansible [core 2.13.5]
          config file = /Users/iainhouston/bradford-abbas.uk/ansible.cfg
          configured module search path = ['/Users/iainhouston/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
          ansible python module location = /opt/homebrew/Cellar/ansible/6.5.0/libexec/lib/python3.10/site-packages/ansible
          ansible collection location = /Users/iainhouston/.ansible/collections:/usr/share/ansible/collections
          executable location = /opt/homebrew/bin/ansible
          python version = 3.10.8 (main, Oct 13 2022, 09:48:40) [Clang 14.0.0 (clang-1400.0.29.102)]
          jinja version = 3.1.2
          libyaml = True
        NodeJS Version v18.11.0
        npm Version 8.19.2
        vagrant-hostsupdater (1.2.4, global)
        vagrant-parallels (2.2.5, global)
    ```  
    
Fin
