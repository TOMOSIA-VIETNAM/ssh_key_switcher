# frozen_string_literal: true

require_relative 'lib/ssh_key_switcher/version'

Gem::Specification.new do |spec|
  spec.name    = 'ssh_key_switcher'
  spec.version = SshKeySwitcher::VERSION
  spec.authors = ['Minh Tang Q.']
  spec.email   = ['minh.tang1@tomosia.com', 'vhquocminhit@gmail.com']
  spec.homepage              = 'https://github.com/TOMOSIA-VIETNAM/ssh_key_switcher'
  spec.summary               = 'A simple and efficient for managing and switching between OpenSSH keys seamlessly'
  spec.license               = 'MIT'
  spec.files                 = Dir['lib/**/*', 'README.md']
  spec.executables           = %w[sks]
  spec.required_ruby_version = '>= 2.5.0'
  spec.metadata = {
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'documentation_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'rubygems_mfa_required' => 'true'
  }

  spec.add_dependency 'thor', '~> 1.2.0'
  spec.add_dependency 'tty-prompt', '~> 0.23.0'
end
