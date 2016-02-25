Clear-Host

# SomeComputerUser
$userName = $env:USERNAME

# C:\Users\username
$userHome = "$env:HOMEDRIVE$env:HOMEPATH" 

# Read the PATH environment variable for the user, and parse the paths to an array.
# cmd> echo %PATH%
$userPathVars = $env:Path -split ";"


#region Test data

# Example raw cmd command line dumps to test with.
# cmd> set
$sample_cmd_pathvars = @"
C:\Ruby22-x64\bin;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\Program Files (x86)\Intel\OpenCL SDK\2.0\bin\x86;C:\Program Files (x86)\Intel\OpenCL SDK\2.0\bin\x64;C:\Program Files\Microsoft SQL Server\110\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files\Microsoft\Web Platform Installer\;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files (x86)\Microsoft Team Foundation Server 2013 Power Tools\;C:\Program Files (x86)\Microsoft Team Foundation Server 2013 Power Tools\Best Practices Analyzer\;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files (x86)\Microsoft SDKs\TypeScript\1.0\;C:\Program Files (x86)\Git\cmd;C:\Program Files\nodejs\;C:\Program Files\Amazon\AWSCLI\;C:\Program Files (x86)\Amazon\AWSCLI\;C:\Program Files (x86)\Windows Kits\10\Windows Performance Toolkit\;C:\Program Files (x86)\Skype\Phone\;C:\Program Files (x86)\Brackets\command;D:\Program Files\1E\NomadBranch\;C:\Program Files (x86)\WebEx\Productivity Tools;C:\Program Files\Microsoft DNX\Dnvm\;C:\Users\$userName\.dnx\runtimes\dnx-clr-win-x86.1.0.0-rc1-update1\bin;C:\Users\$userName\.dnx\bin;C:\Users\$userName\AppData\Roaming\npm
"@

# Example raw bash command line dumps to test with.
#
# bash> echo $PATH
$sample_bash_pathvars = @"
"C\:/Program Files/Amazon/AWSCLI/";/c/Users/$userName/bin:/mingw64/bin:/usr/local/bin:/usr/bin:/bin:/cmd:/mingw64/bin:/usr/bin:/c/ProgramData/Oracle/Java/javapath:/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/c/Program Files (x86)/Intel/iCLS Client:/c/Program Files/Intel/iCLS Client:/c/WINDOWS/system32:/c/WINDOWS:/c/WINDOWS/System32/Wbem:/c/WINDOWS/System32/WindowsPowerShell/v1.0:/c/Program Files/Intel/Intel(R) Management Engine Components/DAL:/c/Program Files/Intel/Intel(R) Management Engine Components/IPT:/c/Program Files (x86)/Intel/Intel(R) Management Engine Components/DAL:/c/Program Files (x86)/Intel/Intel(R) Management Engine Components/IPT:/c/Program Files (x86)/Lenovo/Motion Control:/c/Program Files/Intel/WiFi/bin:/c/Program Files/Common Files/Intel/WirelessCommon:/c/Program Files/Microsoft SQL Server/120/Tools/Binn:/c/Program Files (x86)/Brackets/command:/c/Program Files/Microsoft/Web Platform Installer:/c/Program Files (x86)/Windows Kits/8.1/Windows Performance Toolkit:/c/Program Files/nodejs:/c/Python27:/c/Program Files/MongoDB/Server/3.0/bin:/c/Program Files/Amazon/AWSCLI:/c/Program Files (x86)/Skype/Phone:/c/Users/$userName/.dnx/bin:/c/Users/$userName/AppData/Roaming/npm:/usr/bin/vendor_perl:/usr/bin/core_perl
"@

#endregion


# Make a simple hashtable config object to read from
$config = @{ DevTooling = @{}; }

# Java
$config.DevTooling.Java = @{
    cmd_java = "C:\ProgramData\Oracle\Java\javapath";
}

# Python
$config.DevTooling.Python = @{
    cmd_27 = "C:\Python27";
}

# Ruby
$config.DevTooling.Ruby = @{
    cmd_22_x64 = "C:\Ruby22-x64\bin";
}

# Node/NPM
$config.DevTooling.Node = @{
    cmd_nodeJs = "C:\Program Files\nodejs\";
}

$config.DevTooling.NPM = @{
    cmd_npm_roaming = "C:\Users\$userName\AppData\Roaming\npm"
}

# DNX
$config.DevTooling.DNX = @{
    cmd_dnx_dnvm = "C:\Program Files\Microsoft DNX\Dnvm\";
    cmd_dnx_clr_x64 = "C:\Users\$userName\.dnx\runtimes\dnx-clr-win-x64.1.0.0-rc1-update1\bin";
    cmd_dnx_coreclr_x64 = "C:\Users\$userName\.dnx\runtimes\dnx-coreclr-win-x64.1.0.0-rc1-update1\bin";
    cmd_dnx_bin = "C:\Users\$userName\.dnx\bin";
}

# AWS
$config.DevTooling.DNX = @{
    cmd_aws_cli = "C:\Program Files\Amazon\AWSCLI";
}

# MongoDB
$config.DevTooling.Mongo = @{
    cmd_mongodb_server_30 = "C:\Program Files\MongoDB\Server\3.0\bin";
}


"Discovering PATH vars to add."
"---------------------------------"
#$userPathVars
$pathvars_toAdd = @()
$config.DevTooling | Select -Expand Values | Select -Expand Values | ForEach($_) {
    if (-not ($userPathVars.Contains($_))) {
        "[{0}] does not exist in current PATH. Adding to the update list." -f $_
        $pathvars_toAdd += $_
    }
}


"`n{0} PATH var(s) to be added." -f $pathvars_toAdd.Count
"---------------------------------"
$pathvars_toAdd


"`nPATH environment variable expanded."
"---------------------------------"
$pathExpansion = $pathvars_toAdd -join ";"
$expandedPath = $env:Path + ";" + $pathExpansion
[Environment]::SetEnvironmentVariable("PATH",$expandedPath,"User")
Write-Host ([Environment]::GetEnvironmentVariable("PATH", "User")) -ForegroundColor Gray

"`nDone.`n"




# BASH setup

# Template for .bashrc
# bash> cd ~
# bash> vim .bashrc
$bashrc = @'
'@

# Template for .bash_profile
# bash> cd ~
# bash> vim .bash_profile
$bash_profile = @'
#!/bin/sh

# Source the .bashrc file if it exists
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

# Expanding the Path to include AWS CLI
export PATH="${PATH}:/c/Program Files/Amazon/AWSCLI/"

# Setup alias to Adobe Brackets editor
alias brackets="'/c/Program Files (x86)/Brackets/command/Brackets.exe' $1"
'@

# List of example PATH vars for bash
$bash_pathvars = @"
/mingw64/bin
.
/bin
/cmd
/usr/bin
/usr/bin/vendor_perl
/usr/bin/core_perl
/usr/local/bin
/c/Windows
/c/Windows/System32
/c/Windows/System32/WindowsPowerShell/v1.0
/c/ProgramData/Oracle/Java/javapath
/c/Program Files/Microsoft/Web Platform Installer/
/c/Program Files (x86)/Amazon/AWSCLI/
/c/Program Files (x86)/Brackets/command
/c/Program Files (x86)/Microsoft SDKs/TypeScript/1.0/
/c/Program Files (x86)/Windows Kits/8.1/Windows Performance Toolkit
/c/Program Files/Amazon/AWSCLI
/c/Program Files/Microsoft DNX/Dnvm/
/c/Program Files/Microsoft/Web Platform Installer
/c/Program Files/MongoDB/Server/3.0/bin
/c/Program Files/nodejs
/c/Python27
/c/Ruby22-x64/bin
/c/Users/$userName/.dnx/bin
/c/Users/$userName/.dnx/runtimes/dnx-clr-win-x64.1.0.0-rc1-update1/bin
/c/Users/$userName/.dnx/runtimes/dnx-coreclr-win-x64.1.0.0-rc1-update1/bin
/c/Users/$userName/bin
/c/Users/$userName/AppData/Roaming/npm
"@

#$pathvars = $bash_pathvars -split "`n"
#$i = 0
#$pathvars | ForEach($_) { $i++; Write-Host ("var {0}: [{1}]" -f $i, $_) }

