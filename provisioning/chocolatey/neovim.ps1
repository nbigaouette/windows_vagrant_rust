# Source common code from file
. $PSScriptRoot/../common.ps1

# https://chocolatey.org/packages/neovim
RunCommand -command "choco" -arguments @("install", "-y", "neovim")

# Refresh envrionment variables, including PATH
RefreshEnvironmentVariables
