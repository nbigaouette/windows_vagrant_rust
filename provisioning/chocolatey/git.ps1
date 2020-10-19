# Source common code from file
. $PSScriptRoot/../provision_common.ps1

$version = "2.28.0"

# https://chocolatey.org/packages/git
RunCommand -command "choco" -arguments @("install", "-y", "git", "--version=$version")

# Refresh envrionment variables, including PATH
RefreshEnvironmentVariables

Write-Host "Force 'LF' over 'CRLF'"
# Make sure we use the 'LF' as committed in the repo, not the 'CRLF' that Windows want to
# checkout files with.
RunCommand -command "git" -arguments @("config", "--global", "core.autocrlf", "false")

RunCommand -command "git" -arguments @("version")
