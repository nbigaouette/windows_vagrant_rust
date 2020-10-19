# Source common code from file
. $PSScriptRoot/../common.ps1

# From https://chocolatey.org/install
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Refresh envrionment variables, including PATH
RefreshEnvironmentVariables
