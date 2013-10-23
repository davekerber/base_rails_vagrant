gem_version=`/opt/vagrant_ruby/bin/gem --version`
if [ "$gem_version" != "1.4.2" ]
then
  sudo /opt/vagrant_ruby/bin/gem install rubygems-update -v='1.4.2'
  sudo /opt/vagrant_ruby/bin/update_rubygems
fi

bundler=`which bundle`
if [ "$bundler" == "" ]
then
  sudo /opt/vagrant_ruby/bin/gem install bundler
fi 