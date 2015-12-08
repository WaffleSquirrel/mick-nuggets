# Copy all folder contents that start with the letter B

$fromHere = "\\SHINY-PC\Users\Me\Music\iTunes\iTunes Media\Music\B*"
$toHere = "C:\Users\Elvis\Music"

Copy-Item -Path ($fromHere) -Destination ($toHere) -Force -Recurse