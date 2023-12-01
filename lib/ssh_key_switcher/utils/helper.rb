# frozen_string_literal: true

module SshKeySwitcher
  module Utils
    module Helper
      include SshKeySwitcher::Contains

      module_function

      def find_open_ssh_keys
        ssh_folder = File.expand_path(SSH_DIR)

        Dir.glob("#{ssh_folder}/*").select { |file| valid_ssh_key?(file) }.sort
      end

      def valid_ssh_key?(file)
        File.open(file, 'rb') do |f|
          # Read the first 20 bytes from the file
          header = f.read(20)
          header.include?(STRING_DETECT_OPENSSH_KEY)
        end
      rescue StandardError
        false
      end
    end
  end
end
