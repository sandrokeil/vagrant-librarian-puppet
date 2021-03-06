# Vagrant Librarian Puppet examples

> You want host OS independent box provisioning?

> You want only Vagrant and VirtualBox as host dependencies?

> You want to handle all the stuff inside the box?

> This project comes to the rescue!

This project contains some examples to use Vagrant with Puppet provisioner. All the things are processed in the box, so it's
really host operating system independent and works on linux, windows and mac.

## Installation (on host system)

* Install latest [Vagrant](https://www.vagrantup.com/downloads.html) version
* Install latest [VirtualBox](https://www.virtualbox.org/wiki/Downloads) version

## Test
Download this project and run `vagrant up` inside the extracted folder where `Vagrantfile` file is located. This installs
PHP and Composer. Also php.ini and xdebug.ini will be configured for development.

## Documentation
There is a `puppet` folder and a [Vagrantfile](Vagrantfile) file. You must copy this to you project and configure to your needs.
The files contains some comments to get a quick start of using Vagrant and Puppet.

Please see docs for more information:

* [Vagrant](https://docs.vagrantup.com/v2/) (Vagrant documentation)
* [Librarian Puppet](http://librarian-puppet.com/) (Installs puppet modules e.g. from forge.puppetlabs.com)
* [Puppet](https://docs.puppetlabs.com/puppet/) (Puppet documentation)
* [Puppet Forge](https://forge.puppetlabs.com/) (Puppet modules)

### Vagrantfile
Contains Vagrant config example with nfs/rsync and more. Please read comments in file.

### Puppetfile
Definitions of Puppet modules which configures box. This is file is used by Librarian Puppet.

### hiera.yaml
Puppet hiera definition file.

### composer.yaml
Contains settings to install composer. Uses tPl0ch/composer Puppet module.

### php.yaml
Contains settings to install php. Uses mayflower/php Puppet module.

### site.pp
Puppet manifest file.

## Used Puppet modules
A list of more Puppet modules can be found under [Puppet Forge](https://forge.puppetlabs.com/).

* [mayflower/php](https://forge.puppetlabs.com/mayflower/php) - to install PHP
* [tPl0ch/composer](https://forge.puppetlabs.com/tPl0ch/composer) - to install Composer
* [jfryman/nginx](https://forge.puppetlabs.com/jfryman/nginx) - to install nginx

## Limitations
Depending on used Puppet modules there can be some limitations on other guest os. The procedure is still the same, maybe
only config may vary. Currently tested for debian wheezy.

### Shell provisioner
[Shell provisioners](provisioner/shell) are needed which does the following:

1. Install Ruby on guest OS
1. Install Puppet on guest OS
2. Install librarian-puppet on guest OS
3. Run librarian-puppet to load Puppet modules
