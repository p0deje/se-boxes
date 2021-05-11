Vagrant.configure(2) do |config|
  config.vm.provider(:virtualbox) do |vbox|
    vbox.linked_clone = true
  end

  sync_folders = proc do |box|
    box.vm.synced_folder ENV['WATIR_PATH'], '/watir' if ENV['WATIR_PATH'] && Dir.exist?(ENV['WATIR_PATH'])
    if ENV['SELENIUM_PATH'] && Dir.exist?(ENV['SELENIUM_PATH'])
      # Default VirtualBox synced folder creates a UNC path, which is not supported
      # by Buck (see facebook/buck#1269). The same applies to Samba and NFS.
      # Our only option is RSync.
      box.vm.synced_folder ENV['SELENIUM_PATH'], '/cygdrive/c/selenium',
                           type: 'rsync',
                           rsync__exclude: %w[
                             bazel-bin bazel-out bazel-testlogs bazel-selenium bazel-genfiles
                             build/
                             node_modules/
                             rb/.bundle/ rb/Gemfile.lock
                           ]
    end
  end

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

    windows.vm.provision :shell do |powershell|
      powershell.path = 'script/chocolatey.ps1'
      powershell.powershell_args = '-NoProfile -ExecutionPolicy Bypass'
    end

    windows.vm.provision :shell, inline: 'choco install -y puppet-agent'

    windows.vm.provision :puppet do |puppet|
      puppet.options = '--verbose'
      puppet.environment = 'windows'
      puppet.environment_path = 'environments'
      puppet.facter = {
        'username' => windows.ssh.username,
        'chrome_version' => ENV['CHROME_VERSION'] || 'latest',
        'chromedriver_version' => ENV['CHROMEDRIVER_VERSION'] || 'latest',
        'firefox_version' => ENV['FIREFOX_VERSION'] || 'latest',
        'geckodriver_version' => ENV['GECKODRIVER_VERSION'] || 'latest',
      }
    end
  end

  config.vm.define :win2012 do |windows|
    windows.vm.box = 'mwrock/Windows2012R2'
    windows.vm.box_version = '0.6.1'
    configure_windows.call(windows)
    sync_folders.call(windows)
  end

  config.vm.define :win10 do |windows|
    windows.vm.box = 'gusztavvargadr/windows-10'
    windows.vm.box_version = '2009.0.2012'
    configure_windows.call(windows)

    provisioned = File.exist?('.vagrant/machines/win10/virtualbox/action_provision')
    sync_folders.call(windows) if provisioned
  end
end
