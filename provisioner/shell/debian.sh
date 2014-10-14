#!/usr/bin/env bash

# configure puppet
PUPPET_DIR=/etc/puppet/
PUPPET_VERSION=3.7.1-1puppetlabs1
LIBRARIAN_PUPPET_VERSION=1.3.2

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

echo "Running apt-get update"
apt-get update --fix-missing >/dev/null
echo "Finished running apt-get update"

echo "Installing git"
apt-get -q -y install git-core >/dev/null
echo "Finished installing git"

echo "Install puppet version $PUPPET_VERSION"
apt-get install -q -y puppet >/dev/null
PUPPET_VERSION=$(puppet help | grep 'Puppet v')
echo "Finished installing puppet to version: $PUPPET_VERSION"

if [[ ! -d "$PUPPET_DIR" ]]; then
    mkdir -p "$PUPPET_DIR"
    echo "Created directory $PUPPET_DIR"
fi

ln -fs "/vagrant/puppet/Puppetfile" "$PUPPET_DIR/Puppetfile"

if [[ ! -f /.puphpet-stuff/librarian-base-packages ]]; then
    echo 'Installing base packages for librarian'
    apt-get install -y build-essential ruby-dev >/dev/null
    echo 'Finished installing base packages for librarian'

    touch /.puphpet-stuff/librarian-base-packages
fi

if [[ ! -f /.puphpet-stuff/librarian-puppet-installed ]]; then
    echo 'Installing librarian-puppet $LIBRARIAN_PUPPET_VERSION'
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
