# se-boxes

Simple Vagrant + Puppet setup to easily test Selenium for different browser
versions on different platforms.

Currently supports:

* Windows 2012 x64 (Firefox, Chrome, IE11)
* Windows 10 x64 (Firefox, Chrome, IE11, Edge)

## Installation

Make sure you have the following installed:

* [Puppet Agent](https://docs.puppet.com/puppet/4.9/#getting-started) (tested on 4.10.4)
* [Ruby](https://www.ruby-lang.org) (tested on 2.5.1)
* [Vagrant](https://www.vagrantup.com) (tested on 2.1.4)
* [VirtualBox](https://www.virtualbox.org) (tested on 5.2.14)

Now, clone repository:

```bash
$ git clone https://github.com/p0deje/se-boxes.git
$ cd se-boxes/
```
## Usage

### Windows 2012

> Username: **vagrant**<br />
> Password: **vagrant**<br />

```bash
$ vagrant up win2012
```

The best way to connect to VM is to use RDP command:

```bash
$ vagrant rdp win2012
```

It will open Remote Desktop connection to VM. You can use
[Microsoft Remote Desktop](https://itunes.apple.com/ru/app/microsoft-remote-desktop)
or any other RDP client you like.

### Windows 10

> Username: **vagrant**<br />
> Password: **vagrant**<br />

```bash
$ vagrant up win10 --no-provision
```

Once VM is started, it is going to run some configuration and then you'll need
to reboot VM.

```bash
$ vagrant reload win10
```

The best way to connect to VM is to use RDP and/or SSH:

```bash
$ vagrant rdp win10
``````
It will open Remote Desktop connection to VM. You can use
[Microsoft Remote Desktop](https://itunes.apple.com/ru/app/microsoft-remote-desktop)
or any other RDP client you like.

You can also connect using SSH:

```bash
$ vagrant ssh win10
```

## Packages and Provision

To quickly change browser/driver versions, you can do the following:

```bash
$ export CHROME_VERSION="57.0.2987.110"
$ export CHROMEDRIVER_VERSION="2.28"
$ export FIREFOX_VERSION="52.0.1"
$ export GECKODRIVER_VERSION="0.15.0"
$ vagrant provision [VM]
```

Refer to the following chocolatey packages to figure out available versions:

* [googlechrome](https://chocolatey.org/packages/googlechrome)
* [chromedriver](https://chocolatey.org/packages/chromedriver)
* [firefox](https://chocolatey.org/packages/firefox)
* [selenium-gecko-driver](https://chocolatey.org/packages/selenium-gecko-driver)

Additionally, the following tools are installed:

* [git](https://chocolatey.org/packages/git) (obvious)
* [conemu](https://chocolatey.org/packages/conemu) (better terminal emulator)

Refer to [`environments/windows/manifests`](environments/windows/manifests) for
more information.

## Cleanup

Note that we use [linked clones](https://www.vagrantup.com/docs/virtualbox/configuration.html#linked-clones)
of VMs, which means that in order to fully remove VM and box you need to:

1. Remove linked VM using `vagrant destroy [VM]`.
2. Manually remove master VM using VirtualBox.
3. Remove box using `vagrant box destroy [BOX]`.

## Selenium

If you want your Selenium sources directory be synced into VM, export `SELENIUM_PATH`
environment variable. It will be accessible in `C:\selenium` inside VM.

Please note that on Windows 10 box you might need to restart Vagrant to pick up Selenium sources after provisioning:

```bash
$ vagrant reload win10 --no-provision
```

The synchronization is done using RSync so if you want to modify files inside host
machine and automatically synchronize them into VM, don't forget to run:

```bash
$ vagrant rsync-auto win10
```

## Watir

If you want your Watir sources directory be synced into VM, export `WATIR_PATH`
environment variable. It will be accessible in `C:\watir` inside VM.

## Puppet Modules

Puppet modules are staged to this repository. In order to install new modules
or upgrade existing ones, you will need `librarian-puppet` Ruby gem:

```bash
gem install librarian-puppet
cd environments/windows/
librarian-puppet install --clean --verbose
```
