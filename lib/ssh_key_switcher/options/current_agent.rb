# frozen_string_literal: true

module SshKeySwitcher
  module Options
    class CurrentAgent
      class << self
        def fetch_results
          results = []
          payload = Cmd.exec('ssh-add -l')[0]
          payload.each_line { |line| results << line.split.last(2).join(' ') }
          results
        end

        def display
          if fetch_results[0].include?('no identities')
            prompt.warn('No active SSH keys')
          elsif fetch_results.size == 1
            prompt.say('Active SSH key: ')
            prompt.ok(fetch_results[0])
          else
            prompt.say('List of active SSH keys:')
            fetch_results.each.with_index(1) do |result, index|
              prompt.ok("  #{index}) #{result}")
            end
          end
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
