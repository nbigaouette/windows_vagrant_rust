# Source common code from file
. $PSScriptRoot/../provision_common.ps1

$version = "1.50.1"

# https://chocolatey.org/packages/vscode
RunCommand -command choco -arguments @("install", "-y", "vscode", "--version=$version")

# Refresh envrionment variables, including PATH
RefreshEnvironmentVariables
