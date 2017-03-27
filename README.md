# se-boxes

Simple Vagrant + Puppet setup to easily test Selenium for different browser
versions on different platforms.

Currently provides with:

* Windows 2012 x64 (Firefox, Chrome, IE11, PhantomJS)
* Windows 10 x64 (Edge)

## Installation

Make sure you have the following installed:

* [Puppet Agent](https://docs.puppet.com/puppet/4.9/#getting-started) (tested on 4.9.0)
* [Ruby](https://www.ruby-lang.org) (tested on 2.3.3)
* [Vagrant](https://www.vagrantup.com) (tested on 1.9.3)
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

```bash
$ vagrant up win2012
```

Username: **vagrant**.
Password: **vagrant**.

To quickly change browser/driver versions, you can do following:

```bash
$ export CHROME_VERSION="57.0.2987.110"
$ export CHROMEDRIVER_VERSION="2.28"
$ export FIREFOX_VERSION="52.0.1"
$ export GECKODRIVER_VERSION="0.15.0"
$ export PHANTOMJS_VERSION="2.1.1"
$ vagrant provision win7
```

Refer to the following chocolatey packages to figure out available versions:

* [googlechrome](https://chocolatey.org/packages/googlechrome)
* [chromedriver](https://chocolatey.org/packages/chromedriver)
* [firefox](https://chocolatey.org/packages/firefox)
* [selenium-gecko-driver](https://chocolatey.org/packages/selenium-gecko-driver)
* [phantomjs](https://chocolatey.org/packages/phantomjs)

The best way to connect to VM is to use `vagrant rdp win2012`. This command
will open Remote Desktop connection to VM. You can use
[Microsoft Remote Desktop](https://itunes.apple.com/ru/app/microsoft-remote-desktop)
or any other RDP client.

### Windows 10

```bash
$ vagrant up win10
```

The box should only be used for testing of Microsoft Edge driver.

You need to manually install [Microsoft WebDriver](https://www.microsoft.com/en-us/download/details.aspx?id=48212) and
[add it to PATH](https://msdn.microsoft.com/en-us/library/office/ee537574(v=office.14).aspx).

## Selenium

By default, Vagrant tries to sync your Selenium sources from `../selenium`
to `/selenium` directories. Source directory can be altered by exporting
`SELENIUM_PATH` variable.

Refer to Selenium [wiki](https://github.com/SeleniumHQ/selenium/wiki/Crazy-Fun-Build)
page for build system details.

## Watir

By default, Vagrant tries to sync your Watir sources from `../watir`
to `/watir` directories. Source directory can be altered by exporting
`WATIR_PATH` variable.
