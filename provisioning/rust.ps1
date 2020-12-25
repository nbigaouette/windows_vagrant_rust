# Source common code from file
. $PSScriptRoot/common.ps1

$setupFilename = "rustup-init.exe"
# rustup version 1.23.1
$sha256sum = "beddae8ff6830419b5d24d719a6ef1dd67a280fe8e799963b257467ffc205560"

# Gnu toolchain, x86_64 build
$hostTriple = "x86_64-pc-windows-gnu"

$downloadUrl = "https://static.rust-lang.org/rustup/dist/$hostTriple/$setupFilename"

$setupFullPath = "$provisioningDirectory\$setupFilename"

$toolchainVersion = "stable"

# ----------------------------------------------------------------------
Write-Host "setupFilename:              $setupFilename"
Write-Host "sha256sum:                  $sha256sum"
Write-Host "downloadUrl:                $downloadUrl"
Write-Host "hostTriple:                 $hostTriple"
# ----------------------------------------------------------------------

DownloadFile -name "Rustup" -url $downloadUrl -downloadTo $setupFullPath

# Verify file integrity
SHA256Sum -setupFullPath $setupFullPath -sha256sum $sha256sum

$rustupProfile = "minimal"

if (-not (Get-Command rustup 2> $null)) {
    # Install
    Write-Host "Running $setupFullPath..."
    RunCommand -command "$setupFullPath" -arguments @("--verbose", "-y", "--default-toolchain", "$toolchainVersion", "--default-host", "$hostTriple", "--profile=$rustupProfile")
}
else {
    Write-Host "Rustup already installed"
}

RefreshEnvironmentVariables

if ($env:CI) {
    Write-Host "Not changing CARGO_TARGET_DIR"
    if ($env:CARGO_TARGET_DIR) {
        Write-Host "CARGO_TARGET_DIR: $env:CARGO_TARGET_DIR"
    }
}
else {
    # Instruct cargo to place its build artifacts in a different default directory.
    # Without this, cargo will fail to compile a project that is shared between the host
    # and guest VM (in C:\vagrant) due to the directory being shared through some kind
    # of network mount. 
    Write-Host "Setting CARGO_TARGET_DIR to C:\cargo_target"
    RunCommand -command setx -arguments @("CARGO_TARGET_DIR", "C:\cargo_target")
}

RunCommand -command rustup -arguments @("--version")
RunCommand -command rustc -arguments @("--version")
RunCommand -command cargo -arguments @("--version")

if ($env:CI) {
    Write-Host "Not installing extra rustup components in CI"
}
else {
    RunCommand -command rustup -arguments @("component", "add", "clippy", "--toolchain", "$toolchainVersion-$hostTriple")
    RunCommand -command rustup -arguments @("component", "add", "rustfmt", "--toolchain", "$toolchainVersion-$hostTriple")
    # RunCommand -command rustup -arguments @("component", "add", "rust-analysis", "--toolchain", "$toolchainVersion-$hostTriple")
    # RunCommand -command rustup -arguments @("component", "add", "rls", "--toolchain", "$toolchainVersion-$hostTriple")
    # RunCommand -command rustup -arguments @("component", "add", "llvm-tools-preview", "--toolchain", "$toolchainVersion-$hostTriple")
    # RunCommand -command rustup -arguments @("component", "add", "lldb-preview", "--toolchain", "$toolchainVersion-$hostTriple")
}