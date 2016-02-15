Import-Module ServerManager

# To list the feature names
#Get-WindowsFeature

# For a single feature and rebooting after
#Add-WindowsFeature SomeFeatureName -restart

# For multiple features at once
#Add-WindowsFeature Web-WebServer,NET-Framework-45-ASPNET,Web-Mgmt-Tools


# Enable IIS Features
Add-WindowsFeature Web-WebServer,NET-Framework-45-ASPNET,Web-Mgmt-Tools
