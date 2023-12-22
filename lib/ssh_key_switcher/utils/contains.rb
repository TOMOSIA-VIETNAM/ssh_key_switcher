# frozen_string_literal: true

module SshKeySwitcher
  module Contains
    SSH_DIR = "#{Dir.home}/.ssh"
    STRING_DETECT_OPENSSH_KEY = 'OPENSSH'
    SERVER_NAMES = %w[github.com gitlab.com bitbucket.org].freeze
  end
end
