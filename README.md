# selenium-boxes

Simple Vagrant + Puppet setup to easily test Selenium for different browser versions.

At the moment, only Firefox is supported.

## Installation

Make sure you have [Vagrant](https://www.vagrantup.com/downloads.html) installed.

Next, follow these steps:

```bash
$ vagrant plugin install vagrant-exec
$ gem install librarian-puppet
$ git clone https://github.com/p0deje/selenium-boxes.git
$ cd selenium-boxes/
$ librarian-puppet install
$ export FIREFOX_VERSION=35 # change to any major version you want
$ vagrant up
```

## Firefox

To quickly change Firefox version, you can do following:

```bash
$ export FIREFOX_VERSION=30
$ vagrant provision
```

## Selenium

To run the tests, you can do following:

```bash
$ vagrant exec ./go clean test
```

Refer to Selenium [wiki](https://github.com/SeleniumHQ/selenium/wiki/Crazy-Fun-Build) page for build system details.

By default, Vagrant tries to sync your Selenium sources from `../selenium` directory.
This can be altered by exporting `SELENIUM_PATH` variable.

## Access browser UI

Vagrant exposes VNC to the host, so you can connect to `localhost:5901` with any VNC client and see what is actually happening in the box.
