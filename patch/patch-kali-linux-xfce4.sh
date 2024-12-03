#/bin/sh

# Disable force authentication upon automatic suspending
sudo cp 85-suspend.rules /etc/polkit-1/rules.d/
