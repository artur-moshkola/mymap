param (
	[string]$inkscape = 'c:\Program Files\Inkscape\inkscape.exe'
)

.\Generate-Map

$command = "& `"$inkscape`" --export-filename=mymap.png -w 4960 -y 0 mymap.svg";
Invoke-Expression $command

$command = "& `"$inkscape`" --export-filename=mymapthb.png -w 800 -y 0 mymap.svg";
Invoke-Expression $command

$command = "& `"$inkscape`" --export-filename=mymapus.png -w 4960 -y 0 mymapus.svg";
Invoke-Expression $command

$command = "& `"$inkscape`" --export-filename=mymapusthb.png -w 800 -y 0 mymapus.svg";
Invoke-Expression $command

$command = "& `"$inkscape`" --export-filename=mymapca.png -w 4960 -y 0 mymapca.svg";
Invoke-Expression $command

$command = "& `"$inkscape`" --export-filename=mymapcathb.png -w 800 -y 0 mymapca.svg";
Invoke-Expression $command