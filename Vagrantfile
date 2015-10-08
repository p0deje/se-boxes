Vagrant.configure(2) do |config|
  SYNCED_FOLDERS = [{
    host: ENV['SELENIUM_PATH'] || '../selenium',
    guest: '/selenium'
  }, {
    host: ENV['WATIR_PATH'] || '../watir-webdriver',
    guest: '/watir-webdriver'
  }].freeze

  SYNCED_FOLDERS.each do |synced_folder|
    if Dir.exist?(synced_folder[:host])
      config.vm.synced_folder synced_folder[:host], synced_folder[:guest]
    end
  end

  config.vm.define :ubuntu do |ubuntu|
    ubuntu.vm.box = 'hashicorp/precise64'
    ubuntu.vm.network :forwarded_port, guest: 5900, host: 5901, id: 'vnc'

    ubuntu.vm.provider :virtualbox do |vbox|
      vbox.memory = 1024
    end

    ubuntu.vm.provision :puppet do |puppet|
      puppet.module_path = 'modules'
      puppet.manifest_file = 'ubuntu.pp'
      puppet.facter = {
        'firefox_version' => ENV['FIREFOX_VERSION']
      }
    end
  end

  config.vm.define :win7 do |windows|
    windows.vm.box = 'ferventcoder/win7pro-x64-nocm-lite'
    windows.vm.guest = :windows
    windows.vm.network :forwarded_port, guest: 22, host: 2222, id: 'ssh'
    windows.vm.communicator = :winrm
    windows.winrm.username = 'vagrant'
    windows.winrm.password = 'vagrant'

    windows.vm.provider :virtualbox do |vbox|
      vbox.gui = true
    end

    windows.vm.provision :shell, path: 'script/prepare_windows.cmd'
    # Need to reboot machine for Puppet installation to finish.
    windows.vm.provision :reload
    windows.vm.provision :puppet do |puppet|
      puppet.options = %w[--verbose]
      puppet.module_path = 'modules'
      puppet.manifest_file = 'win7.pp'
      puppet.facter = {
        'firefox_version' => ENV['FIREFOX_VERSION'] || 'latest',
        'phantomjs_version' => ENV['PHANTOMJS_VERSION'] || 'latest',
        'chrome_version' => ENV['CHROME_VERSION'] || 'latest'
      }
    end
  end
end
