# The absolute path to the root directory of the project.
ENV['DRUPALVM_PROJECT_ROOT'] = "#{__dir__}"

# The relative path from the project root to the VM config directory.
ENV['DRUPALVM_CONFIG_DIR'] = "vm"

# The relative path from the project root to the directory of our Drupal VM  clone.
ENV['DRUPALVM_DIR'] = "library"

# When provisioning VM, skip live-only tasks
ENV['DRUPALVM_ANSIBLE_ARGS'] = '--skip-tags=prod_only --vault-password-file="${HOME}/.vaultpw"'

# Load the real Vagrantfile
load "#{__dir__}/#{ENV['DRUPALVM_DIR']}/Vagrantfile"
