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
Run one of the configs
```
sudo ansible-playbook /tmp/kaliConfiguration/config.yaml
```
```
ansible-playbook /tmp/kaliConfiguration/configNew.yaml -K
```
```
ansible-playbook /tmp/kaliConfiguration/configMinimal.yaml -K
```

## Todo
- Add pspy in staging
- Add tmux bars notifying when needed
- Ensure tmux tabs dont sleep(?)
- Add naabu, add naabu alias to scan all hosts properly
