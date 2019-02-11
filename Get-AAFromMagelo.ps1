#Gets total list of AA from magelo
#Make sure to create a toons.txt file with list of toons to get AA information on
$toons = Get-Content 'c:\temp\toons.txt' #change to appropriate location
$TotalAAs = @()

foreach ($toon in $toons)
{
    $AAs = Invoke-WebRequest "http://peqtgc.com/magelo/index.php?page=aas&char=$toon"
    $AAs.ParsedHtml.body.innerText | Out-File c:\temp\$($toon)AA.txt -Force
    $content = Get-Content c:\temp\$($toon)AA.txt
    $AA = $content | Where-Object {$_ -match 'AA Points:' -or $_ -match 'Point Spent'}
    $TotalAAs += [PSCustomObject] @{
        Toon = $toon
        AAs  = [int]($AA[0].Split(':')[1]) + [int]($AA[1].Split(':')[1])
    }
}

#$TotalAAs | Export-Csv c:\temp\TotalAAs.csv
