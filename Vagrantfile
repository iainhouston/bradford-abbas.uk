# The absolute path to the root directory of the project.
ENV['DRUPALVM_PROJECT_ROOT'] = "#{__dir__}"

# The relative path from the project root to the VM config directory.
ENV['DRUPALVM_CONFIG_DIR'] = "vm"

# The relative path from the project root to the Drupal VM directory.
ENV['DRUPALVM_DIR'] = "vendor/iainhouston/drupal-vm"

# When provisioning VM, skip live-only tasks
ENV['DRUPALVM_ANSIBLE_ARGS'] = '--skip-tags=prod_only'

# Load the real Vagrantfile
load "#{__dir__}/#{ENV['DRUPALVM_DIR']}/Vagrantfile"
