# frozen_string_literal: true

module SshKeySwitcher
  module Options
    class List
      class << self
        def display
          ssh_keys = Helper.find_ssh_keys
          if ssh_keys.empty?
            prompt.error("No OpenSSH keys found in #{SSH_DIR}")
            nil
          else
            prompt.say('List of OpenSSH keys:')
            Helper.display_list_keys(prompt, ssh_keys, color: :blue)
          end

          print "\n"
          Helper.display_current_ssh_keys(prompt)
        end

        private

        include SshKeySwitcher::Contains
        include SshKeySwitcher::Utils

        def prompt
          @prompt ||= TTY::Prompt.new(interrupt: :exit)
        end
      end
    end
  end
end
