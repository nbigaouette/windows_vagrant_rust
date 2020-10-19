Write-Host "Enabling OpenSSH..."
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
# Start the service
Write-Host "Configuring OpenSSH Windows service..."
Start-Service sshd
# Set service start to automatic
Set-Service -Name sshd -StartupType 'Automatic'
# Confirm the Firewall rule is configured.
Get-NetFirewallRule -Name *ssh*
# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled 

# Configuring OpenSSH
# https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_server_configuration
# Set PowerShell as the default shell
# See https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_server_configuration
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
