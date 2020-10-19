# Source common code from file
. $PSScriptRoot/../common.ps1

# https://chocolatey.org/packages/sysinternals
RunCommand -command choco -arguments @("install", "-y", "sysinternals")

# https://chocolatey.org/packages/procexp
RunCommand -command choco -arguments @("install", "-y", "procexp")

# https://chocolatey.org/packages/procmon
RunCommand -command choco -arguments @("install", "-y", "procmon")

# Refresh envrionment variables, including PATH
RefreshEnvironmentVariables
