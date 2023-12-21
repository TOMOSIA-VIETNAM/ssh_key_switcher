# frozen_string_literal: true

module SshKeySwitcher
  module Options
    class CurrentAgent
      class << self
        def fetch_results
          Helper.current_active_keys
        end

        def display
          Helper.display_current_ssh_keys(prompt)
        end

        private

        include SshKeySwitcher::Utils

        def prompt
          @prompt ||= TTY::Prompt.new
        end
      end
    end
  end
end
