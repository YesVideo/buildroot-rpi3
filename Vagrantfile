# -*- mode: ruby -*-
# vi: set ft=ruby :

################################################################################
#
# Vagrantfile
#
################################################################################

### Change here for more memory/cores ###
#VM_MEMORY=4096
VM_MEMORY=2048
VM_CORES=4

Vagrant.configure('2') do |config|
	config.vm.box = 'ubuntu/trusty64'
	config.vm.hostname = 'buildroot'
    config.vm.network "private_network", type: "dhcp"

	config.vm.provider :vmware_fusion do |v, override|
		v.vmx['memsize'] = VM_MEMORY
		v.vmx['numvcpus'] = VM_CORES
	end

	config.vm.provider :virtualbox do |v, override|
		v.memory = VM_MEMORY
		v.cpus = VM_CORES
        v.customize ["modifyvm", :id, "--ioapic", "on"]

		required_plugins = %w( vagrant-vbguest )
		required_plugins.each do |plugin|
		  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
		end
	end

	config.vm.provider :virtualbox do |v, override|
        v.customize ["modifyvm", :id, "--nictype1", "virtio"]
        v.customize ["modifyvm", :id, "--nictype2", "virtio"]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

	config.vm.provision 'shell' do |s|
		s.inline = 'echo Setting up machine name'

		config.vm.provider :vmware_fusion do |v, override|
			v.vmx['displayname'] = "buildroot"
		end

		config.vm.provider :virtualbox do |v, override|
			v.name = "buildroot"
		end
	end

	config.vm.provision 'shell', inline:
		"sudo dpkg --add-architecture i386
		sudo apt-get -q update
		sudo apt-get -q -y install build-essential libncurses5-dev \
			git bzr cvs mercurial subversion libc6:i386 unzip emacs24 samba avahi-daemon
		sudo apt-get -q -y autoremove
		sudo apt-get -q -y clean"

	config.vm.provision 'shell', privileged: false, inline:
		"echo 'Downloading and extracting buildroot'
        git clone https://github.com/YesVideo/buildroot-rpi3.git
        cd buildroot-rpi3
        git checkout ufo"
end
