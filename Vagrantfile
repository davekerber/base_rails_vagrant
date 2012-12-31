# -*- mode: ruby -*-
# vi: set ft=ruby :

`git submodule init`
`git submodule update`

if File.file? (File.expand_path '~/vagrant_setup.rb')
  require '~/vagrant_setup.rb'
else 
  require 'ostruct'
  require 'etc'
  USER_CONFIG = OpenStruct.new(name: Etc.getlogin, email:"#{Etc.getlogin}@agapered.com")
end

if USER_CONFIG.ssh_private_key and USER_CONFIG.ssh_public_key and USER_CONFIG.data_dir
  require 'fileutils'
  FileUtils.cp File.expand_path(USER_CONFIG.ssh_private_key), "#{USER_CONFIG.data_dir}/id_rsa"
  FileUtils.cp File.expand_path(USER_CONFIG.ssh_public_key), "#{USER_CONFIG.data_dir}/id_rsa.pub"
end

Vagrant::Config.run do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box" # The url from where the 'config.vm.box' box will be fetched if it doesn't already exist on the user's system.

  config.vm.customize ["modifyvm", :id,
                       "--memory", "512",
                       "--cpus", "2"] 

  config.vm.network :hostonly, "85.85.85.101"

  config.vm.forward_port 1080, 1080
  config.vm.forward_port 3000, 3000

  config.vm.share_folder "host_folder", "/host_folder", USER_CONFIG.data_dir, :nfs => true
  
  #run apt-get update every 30 days
  config.vm.provision :shell, :inline => %Q{
  cd ~
  updated_in_30=`find ./ -type f -mtime -30 -name .apt-get-updated`

  if [ "$updated_in_30" = "" ]; then
    sudo /usr/bin/apt-get update
    touch ~/.apt-get-updated
  fi
}
  
  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "base.pp"
     puppet.module_path = 'modules'
	 puppet.facter = { 'git_name'  => USER_CONFIG.name,
	                   'git_email' => USER_CONFIG.email,
	                 }
  	 #puppet.options = "--verbose --debug" #uncomment this to debug puppet issues
  end
end
