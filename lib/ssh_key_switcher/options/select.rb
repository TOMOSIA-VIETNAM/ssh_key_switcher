# frozen_string_literal: true

module SshKeySwitcher
  module Options
    class Select
      class << self
        def display_select
          ssh_keys = Helper.find_open_ssh_keys
          if ssh_keys.empty?
            prompt.error('No OpenSSH keys found in ~/.ssh')
            nil
          else
            prompt.select('Select an OpenSSH key:', select_options) do |menu|
              menu.enum '.'
              select_choices(menu, ssh_keys)
            end

          end
        end

        def add(path_open_ssh_key)
          SshKeySwitcher::Utils::SshAgent.remove_all
          SshKeySwitcher::Utils::SshAgent.add(path_open_ssh_key)
          prompt.ok('OpenSSH key added successfully!')
        end

        private

        include SshKeySwitcher::Contains
        include SshKeySwitcher::Utils

        def prompt
          @prompt ||= TTY::Prompt.new(interrupt: :exit)
        end

        def select_options
          {
            cycle: true,
            symbols: { marker: '➜' },
            per_page: 20,
            filter: true,
            help: 'Use ↑/↓ arrow keys, and letter keys to filter',
            show_help: :always
          }
        end

        def select_choices(menu, keys)
          keys.each do |value|
            display_text = value.split('/').last(2).join('/').gsub('.ssh/', '')
            menu.choice display_text, value
          end
        end
      end
    end
  end
end
