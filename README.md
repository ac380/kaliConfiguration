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

## For XFCE
Run the config.yaml  
```
sudo ansible-playbook /tmp/kaliConfiguration/config.yaml

ansible-playbook /tmp/kaliConfiguration/configNew.yaml -K

ansible-playbook /tmp/kaliConfiguration/configMinimal.yaml -K
```

### Information
Run the playbook as sudo as some changes require sudo configuration, pay attention to the post installation steps once it all ran.

# To-do 
- Optimize aliases and dot file, useful stuff on Chris Titus tool
- Automate burp certificate properly (Should be working now)
  
