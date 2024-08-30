# frozen_string_literal: true

module SshKeySwitcher
  module Utils
    class SshAgent
      def self.start_ssh_agent
        Cmd.exec('eval $(ssh-agent -s)')
      end

      def self.add(private_key)
        Cmd.exec("ssh-add #{private_key}")
      end

      def self.remove_all
        Cmd.exec('ssh-add -D')
      end

      def self.del(path)
        Cmd.exec("ssh-add -d #{path}")
      end

      def self.start_ssh_agent_if_needed
        ssh_agent_pid = ENV.fetch('SSH_AGENT_PID', nil)
        start_ssh_agent if ssh_agent_pid.nil? || !system("ps -p #{ssh_agent_pid} > /dev/null 2>&1")
      end
    end
  end
end
