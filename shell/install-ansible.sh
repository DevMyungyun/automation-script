hostnamectl set-hostname automation

# Install Basic Tool
yum update -y
yum install git htop net-tools telnet vim -y

# Install Ansible
yum install epel-release -y
yum install ansible -y

# Ansible ADHOC Test
ansible -m ping localhost

# Alias Setting
cat << EOF > /root/.bashrc
# Ansible Command Setting
alias ap='ansible-playbook'
alias av='ansible-vault'
EOF

source .bashrc