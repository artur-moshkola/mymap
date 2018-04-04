param (
	[string]$inkscape = 'c:\Program Files\Inkscape\inkscape.exe'
)

.\Generate-Map

$command = "& `"$inkscape`" -z -e mymap.png -w 1280 -y 0 mymap.svg";
Invoke-Expression $command