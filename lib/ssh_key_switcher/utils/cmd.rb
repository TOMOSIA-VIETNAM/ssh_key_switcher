# frozen_string_literal: true

require 'open3'

module SshKeySwitcher
  module Utils
    module Cmd
      module_function

      def exec(command, _opts = {})
        stdout, stderr, status = Open3.capture3(command)
        [stdout, stderr, status]
      end
    end
  end
end
