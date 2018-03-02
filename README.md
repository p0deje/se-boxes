# se-boxes

Simple Vagrant + Puppet setup to easily test Selenium for different browser
versions on different platforms.

Currently supports:

* Windows 2012 x64 (Firefox, Chrome, IE11, PhantomJS)
* Windows 10 x64 (Firefox, Chrome, IE11, PhantomJS, Edge)

## Installation

Make sure you have the following installed:

* [Puppet Agent](https://docs.puppet.com/puppet/4.9/#getting-started) (tested on 4.9.0)
* [Ruby](https://www.ruby-lang.org) (tested on 2.3.3)
* [Vagrant](https://www.vagrantup.com) (tested on 2.0.2)
* [VirtualBox](https://www.virtualbox.org) (tested on 5.1.18)

Now, clone repository:

```bash
$ git clone https://github.com/p0deje/se-boxes.git
$ cd se-boxes/
```

You need to install all Puppet dependencies first:

```bash
$ gem install librarian-puppet
$ cd environments/windows/
$ librarian-puppet install
```

## Usage

### Windows 2012

Username: **vagrant**.
Password: **vagrant**.

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

Username: **IEUser**.
Password: **Passw0rd!**.

You will need to manually download Windows 10 Vagrant box from
[Microsoft VMs](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/).
The following has been tested on 16.16299.

After it's downloaded and unpacked, add it to Vagrant:

```bash
$ vagrant box add --name msedge-win10 dev-msedge.box
```

Now you can start VM:

```bash
$ vagrant up win10 --no-provision
```

Once VM is started, you'll see VirtualBox GUI which you should use to manually
tweak VM so it allows provisioning:

1. Go to "Control Panel".
2. Open "Administrative Tools".
3. Open "Local Security Policy".
4. Open "Network List Management Policies".
5. Open "Network".
6. Switch to "Network Location" tab.
7. Set "Location type" to "Private".
8. Set "User permissions" to "User can change location".
9. Go back to "Network List Management Policies".

Next, we might need to enable WinRM (at least on preview box):

1. Run "Command Prompt" as administrator.
2. Execute `winrm quickconfig -q`.

If you encounter the following error:

```
WinRM firewall exception will not work since one of the network connection types
on this machine is set to Public. Change the network connection type to either
Domain or Private and try again.
```

Then make all networks private by the following:

1. Run "Window PowerShell" as administrator.
2. Execute `Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private`.

Next, you might need to install VirtualBox Guest Additions (at least on preview box):

1. Switch to VirtualBox VM window.
2. Select "Devices" menu.
3. Hit "Insert Guest Additions CD image..." menu entry.
4. Switch inside VM.
5. Install Guest Additions from CD.
6. Reboot to complete Guest Additions installation.

Finally, restart and provision your VM:

```bash
$ vagrant reload win10 --provision
```

## Packages and Provision

To quickly change browser/driver versions, you can do the following:

```bash
$ export CHROME_VERSION="57.0.2987.110"
$ export CHROMEDRIVER_VERSION="2.28"
$ export FIREFOX_VERSION="52.0.1"
$ export GECKODRIVER_VERSION="0.15.0"
$ export PHANTOMJS_VERSION="2.1.1"
$ vagrant provision [VM]
```

Refer to the following chocolatey packages to figure out available versions:

* [googlechrome](https://chocolatey.org/packages/googlechrome)
* [chromedriver](https://chocolatey.org/packages/chromedriver)
* [firefox](https://chocolatey.org/packages/firefox)
* [selenium-gecko-driver](https://chocolatey.org/packages/selenium-gecko-driver)
* [phantomjs](https://chocolatey.org/packages/phantomjs)

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

Please note that on Windows 10 box you might need to restart Vagrant to
pick up Selenium sources after provisioning:

```bash
$ vagrant reload win10 --no-provision
```

## Watir

If you want your Watir sources directory be synced into VM, export `WATIR_PATH`
environment variable. It will be accessible in `C:\watir` inside VM.
