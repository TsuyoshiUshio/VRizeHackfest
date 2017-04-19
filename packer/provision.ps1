$UNITY_URL= "http://download.unity3d.com/download_unity/497a0f351392/Windows64EditorInstaller/UnitySetup64-5.6.0f3.exe"
$UNITY_OUTPUT="UnitySetup64.exe"
$UNITY_SCRIPT=".\" + $UNITY_OUTPUT + " /S"


# install choco depndencies
Get-ExecutionPolicy
Set-ExecutionPolicy Bypass -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco upgrade chocolatey
Import-Module BitsTransfer

# install Unity
Start-BitsTransfer -Source $UNITY_URL -Destination $UNITY_OUTPUT
Invoke-Expression $UNITY_SCRIPT
choco install -y git python3 jdk8
# choco install -y jenkins

# install python dependencies
refreshenv
pip install pywinauto

# # install android studio
#$ANDROID_LIB="android-25,build-tools-25.0.2"
#Write-Host "y" | .\android.bat update sdk --no-ui --filter $ANDROID_LIB
