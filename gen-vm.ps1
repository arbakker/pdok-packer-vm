param (
[Parameter(Mandatory)]
[ValidateNotNullOrEmpty()]
[ValidateSet('eoan','bionic')]
[string]$versionName,
[Parameter(Mandatory)]
[ValidateNotNullOrEmpty()]
[string]$name,
[Parameter(Mandatory)]
[ValidateNotNullOrEmpty()]
[string]$sha256
)

# name for instance pdok-ubuntu-18.04
echo "creating Ubuntu $versionName image named $name"
$Env:NAME=$name
$Env:UBUNTU_CODENAME=$versionName
$Env:SHA256=$sha256
& 'C:\Program Files\packer\packer.exe' build ubuntu-desktop.json
