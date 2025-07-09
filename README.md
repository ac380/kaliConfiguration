# kaliConfiguration
Contains all files and automations for the kali configuration

## Shortcuts
Install Ansible  
```
sudo apt update && sudo apt install ansible -y
```

Clone the repository  
```
git clone https://github.com/ac380/kaliConfiguration.git /tmp/kaliConfiguration
```

## For Gnome
Everything should work as expected, just make sure you have Gnome already installed and XFCE fully removed.

TO TEST: NEW VERSION AUTOMATICALLY INSTALLS GNOME, PURGES FILES AND REBOOTS.
```
sudo apt install -y kali-desktop-gnome
sudo apt purge --autoremove --allow-remove-essential kali-desktop-xfce

Reboot

sudo ansible-playbook /tmp/kaliConfiguration/configGnome.yaml
```

## For XFCE
Run the config.yaml  
```
sudo ansible-playbook /tmp/kaliConfiguration/config.yaml
```

### Information
Run the playbook as sudo as some changes require sudo configuration, pay attention to the post installation steps once it all ran.

# To-do 
- Optimize aliases and dot file, useful stuff on Chris Titus tool
- GNOME: Double check initial background change, automate bloodhound port change, 
  
