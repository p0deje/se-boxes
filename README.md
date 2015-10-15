# se-boxes

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
$ git clone https://github.com/p0deje/se-boxes.git
$ cd se-boxes/
```

You need to install all Puppet dependencies first:

```bash
$ gem install librarian-puppet
$ librarian-puppet install
```

## Usage

### Ubuntu

```bash
$ export FIREFOX_VERSION="35" # change to any major version you want
$ vagrant up ubuntu
```

To quickly change Firefox version, you can do following:

```bash
$ export FIREFOX_VERSION="30"
$ vagrant provision ubuntu
```

Vagrant exposes VNC to the host, so you can connect to `localhost:5901` with any
VNC client and see what is actually happening in the box.

To run Selenium tests, you can do something like this:

```bash
$ vagrant ssh ubuntu
$ cd /selenium
$ ./go clean test
```

### Windows 7

```bash
$ vagrant up win7
```

To quickly change browser/driver versions, you can do following:

```bash
$ export FIREFOX_VERSION="33.0"
$ export CHROME_VERSION="44.0.2403.89"
$ export PHANTOMJS_VERSION="1.9.8"
$ export CHROMEDRIVER_VERSION="2.10"
$ vagrant provision win7
```

Refer to the following chocolatey packages to figure out available versions:

* [firefox](https://chocolatey.org/packages/firefox)
* [google-chrome-x64](https://chocolatey.org/packages/google-chrome-x64)
* [phantomjs](https://chocolatey.org/packages/phantomjs)
* [chromedriver2](https://chocolatey.org/packages/chromedriver2)

Instead of VNC, Windows VM is started with GUI.

To run Selenium tests, you can do something like this:

```bash
$ vagrant ssh win7
$ cd C:\selenium
$ ./go.bat clean test
```

## Selenium

By default, Vagrant tries to sync your Selenium sources from `../selenium`
to `/selenium` directories. Source directory can be altered by exporting
`SELENIUM_PATH` variable.

Refer to Selenium [wiki](https://github.com/SeleniumHQ/selenium/wiki/Crazy-Fun-Build)
page for build system details.

## Watir

By default, Vagrant tries to sync your Watir sources from `../watir-webdriver`
to `/watir-webdriver` directories. Source directory can be altered by exporting
`WATIR_PATH` variable.

## TODO

* Add Windows 10 image for Microsoft Edge testing.

### Ubuntu

* Add more browsers/drivers

### Windows 7

* Install drivers automatically
* Test browser version changes
* Install different IE versions
