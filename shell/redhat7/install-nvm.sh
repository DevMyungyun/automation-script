NODE_VERSION="14.21.1"

# Installing NVM on CentOS 7
sudo yum install curl -y 

curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash   

source ~/.bashrc

nvm ls-remote 

nvm install $NODE_VERSION
# nvm install lts/*

nvm use $NODE_VERSION

node -v
npm -v