# -*- mode: ruby -*-
# vi: set ft=ruby :

`git submodule init`
`git submodule update`

if File.file? (File.expand_path '~/vagrant_setup.rb')
  require '~/vagrant_setup.rb'
else 
  require 'ostruct'
  require 'etc'
  USER_CONFIG = OpenStruct.new(name: Etc.getlogin, email:"#{Etc.getlogin}@agapered.com", data_dir: (File.expand_path '~'))
end

if USER_CONFIG.ssh_private_key and USER_CONFIG.ssh_public_key and USER_CONFIG.data_dir
  require 'fileutils'
  FileUtils.cp File.expand_path(USER_CONFIG.ssh_private_key), "#{USER_CONFIG.data_dir}/id_rsa"
  FileUtils.cp File.expand_path(USER_CONFIG.ssh_public_key), "#{USER_CONFIG.data_dir}/id_rsa.pub"
end

if USER_CONFIG.startup_script
  FileUtils.cp File.expand_path(USER_CONFIG.startup_script), "#{USER_CONFIG.data_dir}/custom_vagrant_setup.sh"
end

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "2"]
  end

  config.vm.network :private_network, ip: "85.85.85.1"
  config.vm.synced_folder USER_CONFIG.data_dir, "/host_folder"
 
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 1080, host: 1080  
 
  config.vm.provision :shell, :path => 'apt-get-update.sh'
  config.vm.provision :shell, :path => 'install_custom_setup.sh'
 
  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "base.pp"
     puppet.module_path = 'modules'
	 puppet.facter = { 'git_name'  => USER_CONFIG.name,
	                   'git_email' => USER_CONFIG.email,
	                 }
  	 #puppet.options = "--verbose --debug" #uncomment this to debug puppet issues
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "rvm.pp"
    puppet.module_path = 'modules'
  end
end
