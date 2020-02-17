##Get's charater flag data from ProjectEQ Magelo and exports to CSV
##if anything changes on Magelo, it will likely break this script
##############Paste toon names here##############
$toons = @"
Toon1
Toon2
Toon3
Toon4
"@
$toons = ($toons -split "`n").Trim()

$FlagsOrderedFull = @()
Clear-Host
if (($ToonCSV = Read-Host -Prompt "Would you like one CSV per toon name [Y/N]") -eq "Y")
{
	$ToonCSV = $true
}
if (($CSVSavePath = Read-Host -Prompt "Enter CSV save Path [or press ENTER for $env:TEMP] (Make sure the folder exists)") -eq "")
{
	$CSVSavePath = $env:TEMP
}
$CSVFileName = 'CharacterFlags.csv'
$CSVSavePathFull = Join-Path $CSVSavePath $CSVFileName
Write-Host 'Please make sure all flag CSV files are closed before continuing' -ForegroundColor Cyan
pause

foreach ($toon in $toons)
{
	Write-Host "Beginning parse of $toon" -ForegroundColor Cyan
	$HTML = Invoke-WebRequest "http://projecteq.net/magelo/index.php?page=flags&char=$toon"
	$outer = $HTML.ParsedHtml.body.outerHTML
	$inner = $HTML.ParsedHtml.body.innerText
	$outerContent = $outer -split "`n"
	$innerContent = ($inner -split "`n").trim()
	$trimmedInnerContent = $innerContent[50 .. 222] #Starts on line 50 of Magelo - needs to be update if/when Magelo is updated
	$a = 1
	$ArrayForEach = @(foreach ($line in $outerContent) #Add Line numbers
		{
			"$a `t" + $line
			$a++
		})
	$b = 1
	$ArrayForEachInner = @(foreach ($line in $innerContent) #Add Line numbers
		{
			"$b `t" + $line
			$b++
		})
	
	$checkMatches = ($ArrayForEach | Where-Object { $_ -match 'check' }) #Get lines where that conatain the word check
	
	$Flags = @(foreach ($check in $checkMatches) #Massage data
		{
			$CheckNumber = ($check).split("`t")[0].Trim()
			$Checked = ($check).split("`t")[1]
			if ($checked -match 'check1')
			{
				$checked = $true
			}
			else
			{
				$Checked = $false
			}
			$NewCheckNumber = [int]$CheckNumber + 1 #Added [int] to force integer else the number was just appended to the end of a string
			$FlagName = $ArrayForEach | Where-Object { $_ -match "^" + [regex]::escape($NewCheckNumber) } #https://stackoverflow.com/questions/10400035/match-strings-stored-in-variables-using-powershell
			$FlagName = ($FlagName -split '<TD vAlign=middle width="100%" noWrap>')
			$FlagName = ($FlagName[1] -split '</TD>')[0]
			if ($FlagName -match '&nbsp;') #Gets rid of HTML code
			{
				$FlagName = ($FlagName -split '&nbsp;')[1]
				$FlagName = ($FlagName -split '...</A>')[0]
			}
			if ($FlagName -match '&amp;') #Changes &amp; to &
			{
				$FlagName = ($FlagName -replace '&amp;', '&')
			}
			[PSCustomObject] @{
				Name	 = $toon
				Flagged  = $Checked
				FlagName = $FlagName
			}
		})
	
	$FlagsOrdered = @(foreach ($t in $trimmedInnerContent) #Sort and order data
		{
			$switch = 0
			foreach ($Flag in $Flags)
			{
				if (($t -eq $Flag.FlagName) -and ($switch -eq 0)) #adding the switch avoids duplicate entries
				{
					$switch = 1
					[PSCustomObject] @{
						Name = $Flag.Name
						Flagged = $Flag.Flagged
						FlagName = $Flag.FlagName
					}
				}
			}
			
			if ($t -eq '')
			{
				[PSCustomObject] @{
					Name	 = ''
					Flagged  = ''
					FlagName = ''
				}
			}
		})
	
	
	foreach ($t in $trimmedInnerContent) #Sort and order data.  Store all flags in $FlagsOrderedFull array.
	{
		$switch = 0
		foreach ($Flag in $Flags)
		{
			if (($t -eq $Flag.FlagName) -and ($switch -eq 0)) #adding the switch avoids duplicate entries
			{
				$switch = 1
				$FlagsOrderedFull += [PSCustomObject] @{
					Name = $Flag.Name
					Flagged = $Flag.Flagged
					FlagName = $Flag.FlagName
				}
			}
		}
		
		if ($t -eq '')
		{
			$FlagsOrderedFull += [PSCustomObject] @{
				Name	 = ''
				Flagged  = ''
				FlagName = ''
			}
		}
	}
	
	Start-Sleep -Seconds 1
	if ($ToonCSV -eq 'y')
	{
		$toonflags = $toon + 'Flags'
        Write-Host "Writing $toon's flag data to $CSVSavePath\$toonflags.csv..." -ForegroundColor Yellow
		$FlagsOrdered | Export-Csv -Path "$CSVSavePath\$toonflags.csv" -NoTypeInformation
		
	}
}
Write-Host "Saving all flag data to $CSVSavePathFull..." -ForegroundColor Yellow
$FlagsOrderedFull | Export-Csv -Path $CSVSavePathFull -NoTypeInformation
Invoke-Item $CSVSavePath
