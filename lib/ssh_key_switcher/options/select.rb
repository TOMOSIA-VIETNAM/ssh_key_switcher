# frozen_string_literal: true

module SshKeySwitcher
  module Options
    class Select
      class << self
        def display_select
          ssh_keys = Helper.find_ssh_keys
          if ssh_keys.empty?
            prompt.error("No OpenSSH keys found in #{SSH_DIR}")
            nil
          else
            prompt.select('Select an OpenSSH key:', select_options) do |menu|
              menu.enum '.'
              select_choices(menu, ssh_keys)
            end
          end
        end

        def add(path_open_ssh_key)
          return if path_open_ssh_key.nil?

          SshKeySwitcher::Utils::SshAgent.remove_all
          _stdout, stderr, status = SshKeySwitcher::Utils::SshAgent.add(path_open_ssh_key)
          return prompt.ok('Add OpenSSH key successfully!') if status.success?

          prompt.error(stderr)
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

        def select_choices(menu, ssh_keys)
          ssh_keys.each do |key|
            display_text = Helper.filename(key)
            menu.choice display_text, key
          end
        end
      end
    end
  end
end
