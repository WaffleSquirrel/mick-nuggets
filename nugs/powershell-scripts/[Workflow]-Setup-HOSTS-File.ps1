# Sometimes it is convenient to update the HOSTS file to locally test multiple web apps on a local instance of IIS.
# The HOSTS file may have entries such as the following to allow for hostname bindings to route to your localhost.
#
#127.0.0.1	api.my-app.com
#127.0.0.1	api.their-app.com
#127.0.0.1	client.my-app.com
#127.0.0.1	client.their-app.com
#
# This script just adds those entries based on some naming conventions.


Clear-Host

$hostsFilepath = 'C:\WINDOWS\System32\drivers\etc\hosts'

# Uncomment to have a quick peek at the contents of the existing HOSTS file via notepad.
#notepad $hostsFilepath

$hostsFileContent = Get-Content $hostsFilepath

# Parse the hosts file into two separate arrays. One for comment lines, and the other for existing host entries.
$hostEntries = @()
$skippedLines = @()
$i = 0

$hostsFileContent | ForEach($_) {
    $line = $_.ToString().Trim()
    $isHostEntry = (-not $line.StartsWith("#")) -and ($line.Length -gt 0)

    if ($isHostEntry -eq $True) {
        "`nFound host entry `n[{0}]`n" -f $_ 
        $hostEntry = $_.ToString().Replace(" ","`t").Split("`t", [StringSplitOptions]::RemoveEmptyEntries)

        # index[0] would be the IP Address such as 127.0.0.1
        # index[1] would be the host address such as mylocalwebsite.whatever.com
        if ($hostEntry.Count -eq 2) {
            $hostEntries += @{IpAddress = $hostEntry[0]; HostAddress = $hostEntry[1];};        
        }
    }
    else {
        "`nSkipped line `n[{0}]`n" -f $_
        $skippedLines += $_
    }    
}

Write-Host ("`n{0} line(s) skipped in host file." -f $skippedLines.Count) -ForegroundColor Yellow
Write-Host ($skippedLines | Format-Table | Out-String) -ForegroundColor Gray

Write-Host ("`n{0} host entries found:" -f $hostEntries.Count) -ForegroundColor Yellow
Write-Host ($hostEntries | Select -Property @{Name="IpAddress"; Expression={$_.IpAddress};},@{Name="HostAddress"; Expression={$_.HostAddress};} | Format-Table | Out-String) -ForegroundColor Gray

# Add custom host entries in the hosts file.
$apps = "my-app","their-app"

$urlFormatString1 = "api.{0}.com"
$urlFormatString2 = "client.{0}.com"

$newHostEntries = @() 

$apps | ForEach($_) {
    $newHostEntries += @{IpAddress = "127.0.0.1"; HostAddress = ($urlFormatString1 -f $_);};
}

$apps | ForEach($_) {
    $newHostEntries += @{IpAddress = "127.0.0.1"; HostAddress = ($urlFormatString2 -f $_);};
}

# inline lambda-style function to call to simply append content to a file
$appendToHostsFile = { param($content) $content | Out-File -FilePath $hostsFilepath -Encoding utf8 -Append};

$i = 0
ForEach($entry in $newHostEntries) {
    $ip = $entry["IpAddress"]
    $address = $entry["HostAddress"]    

    if(!(($hostEntries | ForEach($_) { $_["HostAddress"]}) -contains $address)) {
        Write-Host "Adding " -ForegroundColor White -NoNewline; Write-Host $address -ForegroundColor Yellow -NoNewline; Write-Host " to host file..."  -ForegroundColor White -NoNewline

        $newLine = ""

        if($i -eq 0) {
            $i = 1
            $newLine = "`r`n"
        }

        &$appendToHostsFile ("{0}{1}`t{2}" -f $newLine, $ip, $address)
        "Done."
    }
}

# Uncomment to take a peek at the updated HOSTS file via notepad.
#notepad $hostsFilepath
