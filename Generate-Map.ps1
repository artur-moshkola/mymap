$homes = Select-Xml -Path mytrips.xml -XPath "/trips/home" | Select-Object -ExpandProperty Node
$countries = Select-Xml -Path mytrips.xml -XPath "/trips/trip/country" | Select-Object -ExpandProperty Node | Group-Object -Property id
$summary = @{}
$countries | %{
	$i = @{count = $_.Count}
	$i.staysum = $_.Group | Measure-Object -Property stay -Sum | Select-Object -ExpandProperty Sum
	$o = New-Object -TypeName PSObject -Prop $i
	$summary.Add($_.Name, $o)
}

function Generate-Color {
	param(
		[Parameter(Position = 0, Mandatory=$true)]
		[Int32] $rate
	)
	if ($rate -gt 100) { $rate = 100 }
	[Int32] $g = (100 - $rate) * 2 + 55
	[Int32] $r = $g * 0.8
	[Int32] $b = 0
	'#{0:x2}{1:x2}{2:x2}' -f $r, $g, $b
}

$css = ""
$summary.Keys | %{
	$itm = $summary.Item($_)
	$rate = $itm.staysum * 3.33
	$color = Generate-Color $rate
	$css = "$css.$_ { fill: $color; }`n"
}

$homes | %{
	$id = $_.id
	$css = "$css.$id { fill: #00aaff; }`n"
}

$src = Get-Content template.svg -Raw -Encoding UTF8
$dst = $src.Replace("/* DYN STYLE PLACEHOLDER */", $css)
$dst | Set-Content -Encoding UTF8 -Path mymap.svg

$states = Select-Xml -Path mytrips.xml -XPath "/trips/trip/country[@id=""us""]/state" | Select-Object -ExpandProperty Node | Group-Object -Property id

$summary_states = @{}
$states | %{
	$i = @{count = $_.Count}
	$i.staysum = $_.Group | Measure-Object -Property stay -Sum | Select-Object -ExpandProperty Sum
	$o = New-Object -TypeName PSObject -Prop $i
	$summary_states.Add($_.Name, $o)
}
$css_states = ""
$summary_states.Keys | %{
	$itm = $summary_states.Item($_)
	$rate = $itm.staysum * 3.33
	$color = Generate-Color $rate
	$css_states = "$css_states.$_ { fill: $color; }`n"
}

$src = Get-Content template-us.svg -Raw -Encoding UTF8
$dst = $src.Replace("/* DYN STYLE PLACEHOLDER */", $css_states)
$dst | Set-Content -Encoding UTF8 -Path mymapus.svg