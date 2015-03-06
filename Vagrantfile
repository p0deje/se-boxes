Vagrant.configure(2) do |config|
  config.vm.box = 'hashicorp/precise64'
  config.vm.synced_folder ENV['SELENIUM_PATH'] || '../selenium', '/selenium'
  config.vm.network :forwarded_port, guest: 5900, host: 5901
  config.exec.commands './go', directory: '/selenium'

  config.vm.provider :virtualbox do |vbox|
    vbox.memory = 1024
  end

  config.vm.provision :puppet do |puppet|
    puppet.module_path = 'modules'
    puppet.facter = {'firefox_version' => ENV['FIREFOX_VERSION']}
  end
end
