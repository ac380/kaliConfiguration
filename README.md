# kaliConfiguration
Contains all files and automations for the kali configuration

## Shortcuts
Install Ansible  
```
sudo apt update && apt install ansible -y
```

Clone the repository  
```
git clone https://github.com/ac380/kaliConfiguration.git /tmp/kaliConfiguration
```

Run the config.yaml  
```
sudo ansible-playbook /tmp/kaliConfiguration/config.yaml
```

## Information
Run the playbook as sudo as some changes require sudo configuration, pay attention to the post installation steps once it all ran.

## To-do 
- Make a config for non virtualized kali instances
- Add all the needed tools, wordlists, and so on to make sure kali is complete even on minimal installations
- Find a way to implement all customizations automatically and without rebooting.
  
