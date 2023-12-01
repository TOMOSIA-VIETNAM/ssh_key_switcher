# frozen_string_literal: true

require 'open3'

module SshKeySwitcher
  module Utils
    module Cmd
      module_function

      def exec(command, opts = {})
        stdout, stderr, status = Open3.capture3(command)
        if opts[:print]
          print stderr
          print stdout
        end
        [stdout, stderr, status]
      end
    end
  end
end
