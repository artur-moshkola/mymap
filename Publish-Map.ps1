param (
	[string]$inkscape = 'c:\Program Files\Inkscape\inkscape.exe'
)

.\Generate-Map

$command = "& `"$inkscape`" -z -e mymap.png -w 4960 -y 0 mymap.svg";
Invoke-Expression $command

$command = "& `"$inkscape`" -z -e mymapthb.png -w 800 -y 0 mymap.svg";
Invoke-Expression $command

$command = "& `"$inkscape`" -z -e mymapus.png -w 4960 -y 0 mymapus.svg";
Invoke-Expression $command

$command = "& `"$inkscape`" -z -e mymapusthb.png -w 800 -y 0 mymapus.svg";
Invoke-Expression $command