custom_setup_script="/host_folder/z_custom_vagrant_setup.sh"
if [ -f $custom_setup_script ];
then	
	cp $custom_setup_script /etc/profile.d/z_custom_vagrant_setup.sh
	chown root:root /etc/profile.d/z_custom_vagrant_setup.sh
	chmod 755 /etc/profile.d/z_custom_vagrant_setup.sh
fi