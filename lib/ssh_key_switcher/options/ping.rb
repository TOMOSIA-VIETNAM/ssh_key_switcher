# frozen_string_literal: true

module SshKeySwitcher
  module Options
    class Ping
      class << self
        def pong
          server_names = SERVER_NAMES.map { |server| "git@#{server}" }
          result = prompt.select('Connect to', server_names, default: 'git@github.com')
          stdout, stderr, status = Cmd.exec("ssh -T #{result}")
          return prompt.ok(stdout) if status.success?

          prompt.error(stderr)
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
