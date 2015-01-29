# Vagrant Example Box

## Overview
This is an example Vagrant configuration that will:

1. Run `apt-get update` once every 30 days
2. Install Ruby 2.1.4 along with a couple gems
3. Install and configure PostgreSQL 9.3 via a custom puppet module

The box is is running Ubuntu 14.04

With this setup, you should be able to immediately start building Ruby apps that use PostgreSQL

## Usage
	git clone git@github.com:davekerber/base_rails_vagrant.git
	cd base_rails_vagrant
	vagrant up
If you want an example of a `vagrant_setup.rb` you can put into your home folder just copy `vagrant_setup_example.rb` to your home folder as `vagrant_setup.rb` and edit to your hearts content!



