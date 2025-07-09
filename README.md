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
```
sudo apt install -y kali-desktop-kde
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

### To-do 
- Optimize aliases and dot file, useful stuff on Chris Titus tool
- Make a config for non virtualized kali instances
- Add all the needed tools, wordlists, and so on to make sure kali is complete even on minimal installations
- Find a way to implement all customizations automatically and without rebooting.
  
