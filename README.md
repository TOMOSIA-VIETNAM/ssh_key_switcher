# SSH Key Switcher

A simple and efficient Ruby gem for managing and switching between OpenSSH keys seamlessly

![Preview](https://github.com/TOMOSIA-VIETNAM/ssh_key_switcher/blob/master/asset/demo.gif?raw=true "Preview")


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ssh_key_switcher'

```

And then execute:

```bash
$ bundle install

```

Or install it yourself as:

```bash
$ gem install ssh_key_switcher

```

## Usage

### Show Help

```bash
$ sks -h [--help]

```

### Show Version

```bash
$ sks -v [--version]

```

Displays the current version of SSH Key Switcher.

### Ping Server

```bash
$ sks -p [--ping]

```

Tests the connection to servers listed in **`SshKeySwitcher::Contains::SERVER_NAMES`**.

### Select OpenSSH Key

```bash
$ sks -s [--select]

```

Allows you to interactively select and set an OpenSSH key for your sessions.

### List of OpenSSH Keys

```bash
$ sks -c [--current]

```

Display a list of OpenSSH keys.

### List Active OpenSSH Keys

```bash
$ sks -c [--current]

```

Displays a list of currently active SSH keys.

### Remove OpenSSH Key

```bash
$ sks --rm [--remove]

```

Interactive prompt to remove an OpenSSH key from the list of managed keys.

## Contributing

Bug reports and pull requests are welcome on GitHub at [SSH Key Switcher](https://github.com/TOMOSIA-VIETNAM/ssh_key_switcher/issues).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Development

**Debug**

```bash
bundle exec sks [option]
```

**Install locally to test**

```bash
bin/install-local [version]
```

**Release**

```bash
bin/release [version]
```

## Contributor

**Minh Tang Q. <minh.tang@tomosia.com>**

## About [TOMOSIA VIET NAM CO., LTD](https://www.tomosia.com/)

A company that creates new value together with customers and lights the light of happiness

【一緒に】【ハッピー】【ライトアップ】

お客様と共に新たな価値を生み出し幸せの明かりを灯す会社、トモシア
