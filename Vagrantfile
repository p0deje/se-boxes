Vagrant.configure(2) do |config|
  config.vm.synced_folder (ENV['SELENIUM_PATH'] || '../selenium'), '/selenium'
  config.vm.synced_folder (ENV['WATIR_PATH'] || '../watir'), '/watir'

  configure_windows = proc do |windows|
    windows.vm.guest = :windows

    windows.vm.provider :virtualbox do |vbox|
      vbox.cpus = 2 # use 1/4 of cores
      vbox.memory = 2048 # use 1/4 of memory
      vbox.customize ['modifyvm', :id, '--ioapic', 'on']
      vbox.customize ['modifyvm', :id, '--cpuexecutioncap', '100']
      vbox.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
      vbox.customize ['modifyvm', :id, '--hwvirtex', 'on']
      vbox.customize ['modifyvm', :id, '--vram', '128']
      vbox.customize ['modifyvm', :id, '--accelerate2dvideo', 'on']
    end

    windows.vm.provision :shell, path: 'script/prepare_windows.cmd'
    windows.vm.provision :puppet do |puppet|
      puppet.options = '--verbose'
      puppet.environment = 'windows'
      puppet.environment_path = 'environments'
      puppet.facter = {
        'chrome_version' => ENV['CHROME_VERSION'] || 'latest',
        'chromedriver_version' => ENV['CHROMEDRIVER_VERSION'] || 'latest',
        'firefox_version' => ENV['FIREFOX_VERSION'] || 'latest',
        'geckodriver_version' => ENV['GECKODRIVER_VERSION'] || 'latest',
        'phantomjs_version' => ENV['PHANTOMJS_VERSION'] || 'latest',
      }
    end
  end

  config.vm.define :win2012 do |windows|
    windows.vm.box = 'mwrock/Windows2012R2'
    windows.vm.box_version = '0.6.1'

    windows.vm.provider :virtualbox do |vbox|
      vbox.gui = false
    end

    configure_windows.call(windows)
  end

  config.vm.define :win10 do |windows|
    windows.vm.box = 'Microsoft/EdgeOnWindows10'
    windows.winrm.username = 'IEUser'
    windows.winrm.password = 'Passw0rd!'

    windows.vm.provider :virtualbox do |vbox|
      vbox.gui = true
    end

    configure_windows.call(windows)
  end
end
