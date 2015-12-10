# List all available Performance Counter Set names
Get-Counter -ListSet * | Sort-Object CounterSetName | Select-Object CounterSetName

# List available Performance Counter Set names for .NET CLR
#Get-Counter -ListSet ".NET CLR*" | Sort-Object CounterSetName | Select-Object CounterSetName

# List available Performance Counter Set names for .NET Data Providers
#Get-Counter -ListSet ".NET Data Provider*" | Sort-Object CounterSetName | Select-Object CounterSetName

# List available Performance Counter Set names for ASP.NET
#Get-Counter -ListSet "ASP.NET*" | Sort-Object CounterSetName | Select-Object CounterSetName

# List available Performance Counter Set names for the Application Pools in IIS
#Get-Counter -ListSet APP_POOL_WAS | Sort-Object CounterSetName | Select-Object CounterSetName

# List available Performance Counter Set names for ETW
#Get-Counter -ListSet "Event Tracing*" | Sort-Object CounterSetName | Select-Object CounterSetName

# List available Performance Counter Set names for the HTTP Service
#Get-Counter -ListSet "HTTP Service*" | Sort-Object CounterSetName | Select-Object CounterSetName

# List available Performance Counter Set names for the IIS Worker Processes
#Get-Counter -ListSet "W3SVC_W3WP" | Sort-Object CounterSetName | Select-Object CounterSetName

# List available Performance Counter Set names for Web Service
#Get-Counter -ListSet "Web Service" | Sort-Object CounterSetName | Select-Object CounterSetName
