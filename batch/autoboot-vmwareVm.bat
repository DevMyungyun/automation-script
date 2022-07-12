@echo off 
pushd %~dp0 
set vmrun=”D:\vmware\vmrun.exe” 
%vmrun% -T ws start “D:\vm\automation\automation.vmx” nogui 
exit