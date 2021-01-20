# PowerShell profile file

# This function is used to "source" Visual Studio's "vcvars64.bat" file.
# The bat file sets environment variables giving access to Visual Studio tools from the command line.
function Source-VS {
    # Parameter values (optional):
    #   64          x64 Native
    #   amd64_x86   x86_x86 Cross
    #   32          x86 Native
    #   x86_amd64   x86_x64 Cross
    Param ([string]$arch = "64")

    # Source: https://www.cicoria.com/using-vcvars64-vcvars-bat-from-powershell-and-azure-devops/
    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

    $vcvarspath = &$vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
    Write-Output "vc tools located at: $vcvarspath"

    cmd.exe /c "call `"$vcvarspath\VC\Auxiliary\Build\vcvars$arch.bat`" && set > %temp%\vcvars.txt"

    Get-Content "$env:temp\vcvars.txt" | Foreach-Object {
        if ($_ -match "^(.*?)=(.*)$") {
            Set-Content "env:\$($matches[1])" $matches[2]
        }
    }
}
