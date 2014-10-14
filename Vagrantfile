# -*- mode: ruby -*-
# vi: set ft=ruby :

# global configuration
VAGRANTFILE_API_VERSION = "2"
VAGRANT_BOX = "puphpet/debian75-x64"
VAGRANT_BOX_MEMORY = 512
VIRTUAL_BOX_NAME = "puppetdemo"

# nfs is disabled on windows automatically
NFS_ENABLED = true
NFS_MOUNT_OPTIONS  = ["proto=tcp", "vers=3", "actimeo=2"]
NFS_EXPORT_OPTIONS = ["async", "rw", "no_subtree_check", "all_squash"]

# only change these lines if you know what you do
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    nfs_enabled = NFS_ENABLED && RbConfig::CONFIG['host_os'] =~ /linux/
    mount_options = nfs_enabled ? NFS_MOUNT_OPTIONS  : []
    export_options = nfs_enabled ? NFS_EXPORT_OPTIONS : []

    config.vm.box = VAGRANT_BOX
    config.vm.hostname = VIRTUAL_BOX_NAME + ".dev"

    # configure vhost ports, more vhosts => more port forwarding definitions
    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :forwarded_port, guest: 443, host: 8443

    config.vm.network :private_network, ip: "192.168.56.2", nic_type: "virtio"

    # rsync example
    #config.vm.synced_folder ".", "/home/vagrant/project", type: "rsync", rsync__auto: true, rsync__exclude: [".git/", ".vagrant", ".idea"]

    # nfs example
    config.vm.synced_folder ".", "/home/vagrant/project", :nfs => nfs_enabled, :mount_options => mount_options, :linux__nfs_options =>  export_options

    # forward ssh requests for public keys
    config.ssh.forward_agent = true

    # ensure box name
    config.vm.define VIRTUAL_BOX_NAME do |t|
    end

    # configure virtual box
    config.vm.provider :virtualbox do |vb|
        vb.name = VIRTUAL_BOX_NAME
        vb.customize ["modifyvm", :id, "--memory", VAGRANT_BOX_MEMORY]
    end

    # script for installing puppet, librarian-puppet and load puppet dependencies
    config.vm.provision :shell, :path => "https://raw.githubusercontent.com/sandrokeil/vagrant-librarian-puppet/master/provisioner/shell/debian.sh"

    # puppet provisioner
    config.vm.provision :puppet do |puppet|
        puppet.facter = {
            "ssh_username" => "vagrant"
        }
        puppet.manifests_path = ["puppet/manifests", "/home/vagrant/project/puppet/manifests"]
        puppet.manifest_file = "site.pp"
        puppet.options = ["--verbose", "--debug", "--hiera_config /home/vagrant/project/puppet/hiera.yaml", "--parser future"]
    end
end
