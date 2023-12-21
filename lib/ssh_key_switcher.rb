# frozen_string_literal: true

require 'tty-prompt'
require 'thor'
require_relative 'ssh_key_switcher/version'
Dir.glob("#{__dir__}/ssh_key_switcher/utils/*.rb").sort.each { |file| require_relative(file) }
Dir.glob("#{__dir__}/ssh_key_switcher/options/*.rb").sort.each { |file| require_relative(file) }

module SshKeySwitcher
  class Error < StandardError; end

  class CLI < Thor
    ENV['THOR_SILENCE_DEPRECATION'] = 'true'

    desc 'version [-v, --version]', 'Show version'
    map %w[-v --version] => :version
    def version
      TTY::Prompt.new.say("SSHKeySwitcher version #{VERSION}")
    end

    desc 'ping [-p, --ping]', "Connect to servers #{SshKeySwitcher::Contains::SERVER_NAMES}"
    map %w[-p --ping] => :ping
    def ping
      SshKeySwitcher::Options::Ping.pong
    end

    desc 'select [-s, --select]', 'Select an OpenSSH key'
    map %w[-s --select] => :select
    def select
      path_open_ssh_key = SshKeySwitcher::Options::Select.display_select
      SshKeySwitcher::Options::Select.add(path_open_ssh_key)
    end

    desc 'list [-l, --list]', 'List of OpenSSH key files'
    map %w[-l --list] => :list
    def list
      SshKeySwitcher::Options::List.display
    end

    desc 'current [-c, --current]', 'List of active OpenSSH keys'
    map %w[-c --current] => :current
    def current
      SshKeySwitcher::Options::CurrentAgent.display
    end

    desc 'remove [-rm, --remove]', 'Remove an OpenSSH key'
    map %w[-rm --remove] => :remove
    def remove
      path_open_ssh_key = SshKeySwitcher::Options::Remove.display_select
      SshKeySwitcher::Options::Remove.del(path_open_ssh_key)
    end
  end
end
