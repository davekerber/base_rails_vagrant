cd ~
updated_in_30=`find ./ -type f -mtime -30 -name .apt-get-updated`

if [ "$updated_in_30" = "" ]; then
  sudo /usr/bin/apt-get update
  touch ~/.apt-get-updated
fi