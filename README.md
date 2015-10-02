# selenium-boxes

Simple Vagrant + Puppet setup to easily test Selenium for different browser
versions on different platforms.

Currently provides with:

* Ubuntu 12.04 x64 (Firefox)
* Windows 7 x64

## Installation

Make sure you have [Vagrant](https://www.vagrantup.com/downloads.html), [Ruby](https://www.ruby-lang.org/en/downloads/) and
[Puppet](https://docs.puppetlabs.com/guides/install_puppet/pre_install.html#next-install-puppet) installed.

If you plan to use Windows VM, you'll also need [vagrant-reload](https://github.com/aidanns/vagrant-reload)
plugin:

```bash
$ vagrant plugin install vagrant-reload
```

Now, clone repository:

```bash
$ git clone https://github.com/p0deje/selenium-boxes.git
$ cd selenium-boxes/
```

You need to install all Puppet dependencies first:

```bash
$ gem install librarian-puppet
$ librarian-puppet install
```

## Usage

### Ubuntu

```bash
$ export FIREFOX_VERSION=35 # change to any major version you want
$ vagrant up ubuntu
```

To quickly change Firefox version, you can do following:

```bash
$ export FIREFOX_VERSION=30
$ vagrant provision ubuntu
```

Vagrant exposes VNC to the host, so you can connect to `localhost:5901` with any
VNC client and see what is actually happening in the box.

### Windows 7

```bash
$ vagrant up win7
```

Instead of VNC, Windows VM is started with GUI.

Switching browser versions is currently unsupported.

## Selenium

By default, Vagrant tries to sync your Selenium sources from `../selenium` directory.
This can be altered by exporting `SELENIUM_PATH` variable.

Refer to Selenium [wiki](https://github.com/SeleniumHQ/selenium/wiki/Crazy-Fun-Build)
page for build system details.

## TODO

* Apply firewall rules in Windows to avoid asking for Ruby/PhantomJS permissions.
* Install drivers automatically
* Test browser version change in Windows VM
