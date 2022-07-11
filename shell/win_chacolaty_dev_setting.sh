# Win Chocolaty Setting

Get-ExecutionPolicy
='
Restricted
'

Set-ExecutionPolicy
='
AllSigned
'

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Java 11 Install
choco install openjdk11

# Node.JS Install
# NVM Install Seperately 
# https://github.com/coreybutler/nvm-windows/releases
nvm install 12 latest

nvm use 12.22.10

