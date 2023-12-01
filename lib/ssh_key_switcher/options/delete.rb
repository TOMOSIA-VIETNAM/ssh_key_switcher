# frozen_string_literal: true

module SshKeySwitcher
  module Options
    class Delete
      class << self
        def display_select
          keys = Helper.find_open_ssh_keys
          if keys.empty?
            prompt.error('No OpenSSH keys found in ~/.ssh')
            nil
          else
            msg = 'Choose the OpenSSH keys to REMOVE. Press [CTRL+C] to exit.'
            prompt.multi_select(msg, select_options) do |menu|
              menu.enum '.'
              select_choices(menu, keys)
            end
          end
        end

        def del(path_open_ssh_keys)
          is_no = prompt.no?('Are you sure you want to delete it permanently?')

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
            display_text = value.split('/')[-2..].join('/').gsub('.ssh/', '')
            menu.choice display_text, value
          end
        end
      end
    end
  end
end
