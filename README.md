# Vagrant Librarian Puppet examples

> You want host OS independent box provisioning?

> You want only vagrant and virtual box as host dependencies?

> You want to handle all the stuff inside the box?

> This project comes to the rescue!

This project contains some examples to use vagrant with puppet provisioner. All the things are processed in the box, so it's
really host operating system independent and works on linux, windows and mac.

## Installation (on host system)

* Install latest [vagrant](https://www.vagrantup.com/downloads.html) version
* Install latest [virtual box](https://www.virtualbox.org/wiki/Downloads) version

## Test
Download this project and run `vagrant up` inside the extracted folder where `Vagrantfile` file is located. This installs
php and composer. Also php.ini and xdebug.ini will be configured for development.

## Documentation
There is a `puppet` folder and a `Vagrantfile` file. You must copy this to you project and configure to your needs.
The files contains some comments to get a quick start of using vagrant and puppet.

Please see docs for more information:

* [Vagrant](https://docs.vagrantup.com/v2/) (Vagrant documentation)
* [Librarian Puppet](http://librarian-puppet.com/) (Installs puppet modules e.g. from forge.puppetlabs.com)
* [Puppet](https://docs.puppetlabs.com/puppet/) (Puppet documentation)
* [Puppet Forge](https://forge.puppetlabs.com/) (Puppet modules)

### Puppetfile
Definitions of puppet modules which configures box. This is file is used by librarian puppet.

### hiera.yaml
Puppet hiera definition file.

### composer.yaml
Contains settings to install composer. Uses tPl0ch/composer puppet module.

### php.yaml
Contains settings to install php. Uses mayflower/php puppet module.

### site.pp
Puppet manifest file.

## Used puppet modules
A list of more puppet modules can be found under [Puppet Forge](https://forge.puppetlabs.com/).

* [mayflower/php](https://forge.puppetlabs.com/mayflower/php) - to install php
* [tPl0ch/composer](https://forge.puppetlabs.com/tPl0ch/composer) - to install composer

## Limitations
Depending on used puppet modules there can be some limitations on other guest os. The procedure is still the same, maybe
only config may vary. Currently tested for debian wheezy.

1. Install puppet on guest os
2. Install librarian-puppet on guest os
3. Run librarian-puppet to load puppet modules
4. Run puppet
