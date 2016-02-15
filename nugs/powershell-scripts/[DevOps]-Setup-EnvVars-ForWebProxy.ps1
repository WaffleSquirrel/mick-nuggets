
# To see all environment variables via PowerShell Cmdlet
#Get-ChildItem Env:

# To get an environment variable via .NET Framework
#[Environment]::GetEnvironmentVariable("SystemDrive", "Machine")

# To set an environment variable via .NET Framework
#[Environment]::SetEnvironmentVariable("TestVariable", "Test value.", "User")


# If a proxy server is required to connect to the outside, environment variables
# can be exported via command line. Sometimes different source/package management 
# services read one, some, or all of the default environment variables. This may
# require setting http, https, and no proxy.
# 
# export http_proxy=http://some-proxy.some-domain.net:1234
# export HTTP_PROXY=$http_proxy
# export https_proxy=$http_proxy
# export HTTPS_PROXY=$http_proxy
# export no_proxy="127.0.0.1,192.168.0.0/16,*.some-domain.net,*.some-subdomain.some-domain.com"

Clear-Host

$http_proxy = "http://some-proxy.some-domain.net:1234"
$no_proxy = "127.0.0.1,192.168.0.0/16,*.some-domain.net,*.some-subdomain.some-domain.com"

Write-Host "Setting machine-level environment variables for the web proxy..." -NoNewline
[Environment]::SetEnvironmentVariable("http_proxy",$http_proxy,"Machine")
[Environment]::SetEnvironmentVariable("HTTP_PROXY",$http_proxy,"Machine")
[Environment]::SetEnvironmentVariable("https_proxy",$http_proxy,"Machine")
[Environment]::SetEnvironmentVariable("HTTPS_PROXY",$http_proxy,"Machine")
[Environment]::SetEnvironmentVariable("no_proxy",$no_proxy,"Machine")
"Done."
