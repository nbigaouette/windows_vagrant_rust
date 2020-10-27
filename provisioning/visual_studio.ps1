# Source common code from file
. $PSScriptRoot/common.ps1

$setupFilename = "vs_buildtools.exe"
$downloadUrl = "https://aka.ms/vs/16/release/$setupFilename"
$userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML like Gecko) Chrome/51.0.2704.79 Safari/537.36 Edge/14.14931"
$setupFullPath = "$provisioningDirectory\$setupFilename"

# ----------------------------------------------------------------------
Write-Host "setupFilename:              $setupFilename"
Write-Host "downloadUrl:                $downloadUrl"
Write-Host "userAgent:                  $userAgent"
Write-Host "setupFullPath:              $setupFullPath"
# ----------------------------------------------------------------------

DownloadFile -name "Visual C++ Build Tools" -url $downloadUrl -downloadTo $setupFullPath

# Documentation for:
#   svs_builttools.exe's command line arguments
#       https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio?view=vs-2019
#   How to export a setup config file:
#       https://docs.microsoft.com/en-us/visualstudio/install/import-export-installation-configurations?view=vs-2019
#       To obtain the list of components to install, use the 'export' functionality described above,
#       select the packages you want to install and inspect the generated file.
#   Full list of available components:
#       https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2019#c-build-tools

Write-Host "Running $setupFullPath..."
RunCommand -command "$setupFullPath" -arguments @(
    "--quiet",
    "--includeRecommended",
    "--add", "Microsoft.Component.MSBuild",
    "--add", "Microsoft.Component.VC.Runtime.UCRTSDK",
    "--add", "Microsoft.VisualStudio.Component.CoreBuildTools",
    "--add", "Microsoft.VisualStudio.Component.VC.ASAN",
    "--add", "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
    "--add", "Microsoft.VisualStudio.Component.Windows10SDK",
    # advapi32.lib
    "--add", "Microsoft.VisualStudio.Workload.VCTools"
)

RefreshEnvironmentVariables
