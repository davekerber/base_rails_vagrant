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
  FileUtils.cp File.expand_path(USER_CONFIG.startup_script), "#{USER_CONFIG.data_dir}/z_custom_vagrant_setup.sh"
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  host = RbConfig::CONFIG['host_os']

  config.vm.define "base" do |foohost|
  end
  
  config.vm.provider :virtualbox do |vb|
    # Give VM 1/4 system memory & access to all cpu cores on the host
      if host =~ /darwin/
        cpus = `sysctl -n hw.ncpu`.to_i
        # sysctl returns Bytes and we need to convert to MB
        mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 2
      elsif host =~ /linux/
        cpus = `nproc`.to_i
        # meminfo shows KB and we need to convert to MB
        mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 2
      else # sorry Windows folks, I can't help you
        cpus = 2
        mem = 1024
      end
      
    vb.customize ["modifyvm", :id, "--memory", mem, "--cpus", cpus]
  end

  config.vm.network :private_network, ip: "85.85.85.2"
  config.vm.synced_folder USER_CONFIG.data_dir, "/host_folder"
 
  config.vm.network :forwarded_port, guest: 3000, host: 3000, auto_correct: true
  config.vm.network :forwarded_port, guest: 1080, host: 1080, auto_correct: true
 
  config.vm.provision :shell, :path => 'apt-get-update.sh'
  if USER_CONFIG.startup_script
    config.vm.provision :shell, :path => 'install_custom_setup.sh'
  end
  
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
