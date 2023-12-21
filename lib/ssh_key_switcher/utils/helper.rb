# frozen_string_literal: true

module SshKeySwitcher
  module Utils
    module Helper
      include SshKeySwitcher::Contains

      module_function

      def find_ssh_keys
        files  = fetch_private_ssh_keys_via_header
        files += fetch_private_ssh_keys_via_filename
        files.flatten.uniq.sort
      end

      def fetch_private_ssh_keys_via_header
        ssh_dir = File.expand_path(SSH_DIR)
        files = Dir.glob("#{ssh_dir}/**/*").select do |file|
          next if File.directory?(file)

          File.open(file, 'rb') do |f|
            # Read the first 20 bytes from the file
            header = f.read(20)
            header.include?(STRING_DETECT_OPENSSH_KEY)
          end
        end
      end

      def fetch_private_ssh_keys_via_filename
        ssh_dir = File.expand_path(SSH_DIR)
        Dir.glob("#{ssh_dir}/**/*.pub").map { |file| file.gsub('.pub', '') }
      end

      def filename(key)
        key.gsub("#{SSH_DIR}/", '').gsub('.pub', '').strip
      end

      def current_active_keys
        results = []
        payload = Cmd.exec('ssh-add -l')[0]
        payload.each_line { |line| results << line.split.last(2).join(' ') }
        results
      end

      def display_current_ssh_keys(prompt, color: :green)
        ssh_keys = Helper.current_active_keys

        if ssh_keys[0].include?('no identities')
          prompt.warn('No active SSH keys')
        elsif ssh_keys.size == 1
          prompt.say("Active SSH key: #{ssh_keys[0]}", color: color)
        else
          prompt.say('List of active SSH keys:')
          Helper.display_list_keys(prompt, ssh_keys, color: color)
        end
      end

      def display_list_keys(prompt, ssh_keys, color: :blue)
        max_space_size = ssh_keys.size.to_s.size
        ssh_keys.each.with_index(1) do |key, idx|
          space_size = max_space_size - (idx < 10 ? 0 : idx.to_s.size - 1)
          filename = Helper.filename(key)
          prompt.say(format("  %d.%#{space_size}s%s", idx, ' ', filename), color: color)
        end
      end
    end
  end
end
