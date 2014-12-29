#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# configure puppet
PUPPET_DIR=/etc/puppet/
PUPPET_VERSION=3.7.3-1puppetlabs1
LIBRARIAN_PUPPET_VERSION=2.0.1

# No changes required after this line
if [[ ! -d /.puphpet-stuff ]]; then
    mkdir /.puphpet-stuff
    echo "Created directory /.puphpet-stuff"
fi

cat << EOF > /etc/apt/preferences.d/00-puppet.pref
Package: puppet puppet-common
Pin: version ${PUPPET_VERSION}
Pin-Priority: 501
EOF

if [[ ! -f /.puphpet-stuff/puppetlabs-repo ]]; then
    puppet_release="puppetlabs-release-wheezy.deb"
    wget -q http://apt.puppetlabs.com/${puppet_release}
    dpkg -i $puppet_release
    rm $puppet_release

    touch /.puphpet-stuff/puppetlabs-repo
fi

echo "Running apt-get update"
apt-get update --fix-missing >/dev/null
echo "Finished running apt-get update"

echo "Install puppet version $PUPPET_VERSION"
apt-get install -y puppet=${PUPPET_VERSION} >/dev/null
echo "Finished installing puppet"

echo "Installing git"
apt-get -q -y install git-core >/dev/null
echo "Finished installing git"

if [[ ! -d "$PUPPET_DIR" ]]; then
    mkdir -p "$PUPPET_DIR"
    echo "Created directory $PUPPET_DIR"
fi

ln -fs "/vagrant/puppet/Puppetfile" "$PUPPET_DIR/Puppetfile"

if [[ ! -f /.puphpet-stuff/librarian-puppet-installed ]]; then
    echo "Installing librarian-puppet $LIBRARIAN_PUPPET_VERSION"
    gem install librarian-puppet -v $LIBRARIAN_PUPPET_VERSION >/dev/null
    echo 'Finished installing librarian-puppet'

    echo 'Running initial librarian-puppet'
    cd "$PUPPET_DIR" && librarian-puppet install --clean >/dev/null
    echo 'Finished initial librarian-puppet'

    touch /.puphpet-stuff/librarian-puppet-installed
else
    echo 'Running update librarian-puppet'
    cd "$PUPPET_DIR" && librarian-puppet update >/dev/null
    echo 'Finished update librarian-puppet'
fi

echo "Running librarian-puppet to load puppet dependencies"
librarian-puppet install
