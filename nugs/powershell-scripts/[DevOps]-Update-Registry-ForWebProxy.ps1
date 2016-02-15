# If a Windows system needs to have the web proxy set globally for internet access,
# an option is to change the LAN settings from the IE browser options dialog if the 
# group policy allows for it. This essentially updates the registry with the settings.


$RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
$Proxy = "http://some-proxy.some-domain.net:1234"
$NoProxy = "<local>;192.168.*;*.some-domain.net;*.some-subdomain.some-domain.com"

Set-ItemProperty -Path $RegistryPath -Name ProxyEnable -Value 1
Set-ItemProperty -Path $RegistryPath -Name ProxyServer -Value $Proxy
Set-ItemProperty -Path $RegistryPath -Name ProxyOverride -Value $NoProxy

# To tell IE to load the new proxy settings
$IE = New-Object -ComObject InternetExplorer.Application
$IE.Quit()
