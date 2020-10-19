# Source common code from file
. $PSScriptRoot/../common.ps1

$version = "11.0.0"

# https://chocolatey.org/packages/git
RunCommand -command "choco" -arguments @("install", "-y", "llvm", "--version=$version")

# Refresh envrionment variables, including PATH
RefreshEnvironmentVariables

RunCommand -command "clang" -arguments @("version")
