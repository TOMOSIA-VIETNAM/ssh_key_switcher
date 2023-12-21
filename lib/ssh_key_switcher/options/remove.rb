# frozen_string_literal: true

module SshKeySwitcher
  module Options
    class Remove
      class << self
        def display_select
          keys = Helper.find_ssh_keys
          if keys.empty?
            prompt.error('No OpenSSH keys found in ~/.ssh')
            nil
          else
            prompt.multi_select('Choose the OpenSSH keys to delete. Press [CTRL+C] to exit.',
                                select_options) do |menu|
              menu.enum '.'
              select_choices(menu, keys)
            end

          end
        end

        def del(path_open_ssh_keys)
          is_no = prompt.no?('Are you sure you want to remove these keys?')

          if is_no
            prompt.say('Cancelled!')
          else
            path_open_ssh_keys.each do |path|
              SshKeySwitcher::Utils::SshAgent.del(path)
              Cmd.exec("rm #{path}")
              Cmd.exec("rm #{path}.pub")
            end
            prompt.ok('OpenSSH key removed successfully!')
          end
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
            symbols: { marker: '●' },
            per_page: 100,
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
