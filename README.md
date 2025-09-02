# kaliConfiguration
Prepares a brand new Kali installation with all the tools and customizations needed for pentesting.

## Shortcuts
Install Ansible  
```
sudo apt update && sudo apt install ansible -y
```

Clone the repository  
```
git clone https://github.com/ac380/kaliConfiguration.git /tmp/kaliConfiguration
```

Run the config

```
ansible-playbook /tmp/kaliConfiguration/config.yaml -K
```
