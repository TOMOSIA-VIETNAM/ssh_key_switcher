# frozen_string_literal: true

module SshKeySwitcher
  module Utils
    class SshAgent
      def self.add(private_key)
        Cmd.exec("ssh-add #{private_key}")
      end

      def self.remove_all
        Cmd.exec('ssh-add -D')
      end

      def self.del(path)
        Cmd.exec("ssh-add -d #{path}")
      end
    end
  end
end
