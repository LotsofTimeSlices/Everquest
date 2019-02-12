#Gets total list of Skills (not languages) from Magelo. Creates a CSV and Macro for importing your skills into your private EQEMU server.
#Make sure to create a toons.txt file with list of toons (1 per line)
#Make sure to create c:\temp or change the 3 paths below marked by many #####################

Clear-Host
#region ParseMageloAndDumptoFile
Write-Host 'Gathering Magelo data and writing to disk...' -ForegroundColor Cyan
$toons = Get-Content 'c:\temp\toons.txt' #####################Change to appropriate location
$TotalSkills = @()
foreach ($toon in $toons) #dumps skills to text files
{
	$Skills = Invoke-WebRequest "http://peqtgc.com/magelo/index.php?page=skills&char=$toon"
	$Skills.ParsedHtml.body.innerText | Out-File c:\temp\$($toon)Skill.txt -Force #################Change to appropriate location
}
#endregion ParseMageloAndDumptoFile

#region SkillCodes
$listCodes = @()
$numSkills = @"
0, 	1H Blunt
1,	1H Slashing
2, 	2H Blunt
3, 	2H Slashing
4, 	Abjuration
5, 	Alteration
6, 	Apply Poison
7, 	Archery
8, 	Backstab
9, 	Bind Wound
10, 	Bash
11, 	Block
12, 	Brass Instruments
13, 	Channeling
14, 	Conjuration
15, 	Defense
16, 	Disarm
17, 	Disarm Traps
18, 	Divination
19, 	Dodge
20, 	Double Attack
21, 	Dragon Punch
22, 	Dual Wield
23, 	Eagle Strike
24, 	Evocation
25, 	Feign Death
26, 	Flying Kick
27, 	Forage
28, 	Hand To Hand
29, 	Hide
30, 	Kick
31, 	Meditate
32, 	Mend
33, 	Offense
34, 	Parry
35, 	Pick Lock
36, 	Piercing
37, 	Riposte
38, 	Round Kick
39, 	Safe Fall
40, 	Sense Heading
41, 	Singing
42, 	Sneak
43, 	Specialize Abjure
44, 	Specialize Alteration
45, 	Specialize Conjuration
46, 	Specialize Divination
47, 	Specialize Evocation
48, 	Pick Pockets
49, 	Stringed Instruments
50, 	Swimming
51, 	Throwing
52, 	Tiger Claw
53, 	Tracking
54, 	Wind Instruments
55, 	Fishing
56, 	Make Poison
57, 	Tinkering
58, 	Research
59, 	Alchemy
60, 	Baking
61, 	Tailoring
62, 	Sense Traps
63, 	Blacksmithing
64, 	Fletching
65, 	Brewing
66, 	Alcohol Tolerance
67, 	Begging
68, 	Jewelry Making
69, 	Pottery
70, 	Percussion Instruments
71, 	Intimidation
72, 	Berserking
73, 	Taunt
74, 	Frenzy
75, 	Remove Traps
76, 	Tripple Attack
77, 	2H Piercing          
"@
$SkillCodes = $numSkills -split "`n"
foreach ($s in $SkillCodes)
{
	$split = $s -split ','
	$listCodes += [PSCustomObject] @{
		Code = $split[0].trim()
		Skill = $split[1].trim()
	}
}
#endregion SkillCodes

#region ParseLocalFiles
Write-Host 'Importing files and parsing data...' -ForegroundColor Cyan
$SkillList = @()
foreach ($toon in $toons) #parses each file and stores in an custom object
{
	$toonSkills = Get-Content "C:\temp\$($toon)Skill.txt" ######################Change to appropriate location
	foreach ($b in $toonSkills)
	{
		$Skill = $b | Where-Object { $_ -notmatch 'Name:' -and $_ -notmatch 'Signature Builder' -and $_ -notmatch 'AAs' -and $_ -notmatch 'Keys' -and $_ -notmatch 'Flags' -and $_ -notmatch 'Corpse' -and $_ -notmatch 'Corpse' -and $_ -notmatch 'Faction' -and $_ -notmatch 'Move' -and $_ -notmatch 'Link' -and $_ -notmatch 'Done' -and $_ -notmatch 'Skills' -and $_ -notmatch 'Profile' -and $_ -notmatch 'Common Tongue' -and $_ -notmatch 'Gnomish' -and $_ -notmatch 'Dwarvish' -and $_ -notmatch 'Barbarian' -and $_ -notmatch 'Erudian' -and $_ -notmatch 'Elvish' -and $_ -notmatch 'Ogre' -and $_ -notmatch 'Dark Speech'-and $_ -notmatch 'Troll' -and $_ -notmatch 'Thieves Cant' -and $_ -notmatch 'Froglok' -and $_ -notmatch 'Halfling' -and $_ -notmatch 'Goblin' -and $_ -notmatch 'Gnoll' -and $_ -notmatch 'Combine Tongue' -and $_ -notmatch 'Elder Tierdal' -and $_ -notmatch 'LizardMan' -and $_ -notmatch 'Orcish' -and $_ -notmatch 'Faerie' -and $_ -notmatch 'Dragon' -and $_ -notmatch 'Elder Dragon' -and $_ -notmatch 'Vah Shir' -and $_ -notmatch 'Elder Tierdal'}     
		$line = $null
		$line2 = $null
		if ($Skill) #Removes NULL entries
		{
			if ($Skill[0] -eq '1') #for 1hb/1hs
			{
				foreach ($a in $Skill.ToCharArray()) #split each line into single characters
				{
					if ($a -match '[a-z]' -or $a -match ' ')
					{
						$line += $a
					}
					elseif ($a -match '[0-9]')
					{
						$line2 += $a
					}
				}
				$line = $line.Insert(0, '1')
				$line2 = $line2.Remove(0, '1')
			}
			
			elseif ($Skill[0] -eq '2') # for 2hb/2hs/2hp
			{
				foreach ($a in $Skill.ToCharArray()) #split each line into single characters
				{
					if ($a -match '[a-z]' -or $a -match ' ')
					{
						$line += $a
					}
					elseif ($a -match '[0-9]')
					{
						$line2 += $a
					}
				}
				$line = $line.Insert(0, '2')
				$line2 = $line2.Remove(0, '1')
			}
			
			else #everything else
			{
				foreach ($a in $Skill.ToCharArray()) #split each line into single characters
				{
					if ($a -match '[a-z]' -or $a -match ' ')
					{
						$line += $a
					}
					elseif ($a -match '[0-9]')
					{
						$line2 += $a
					}
				}
			}
			
            $Code = $listCodes | Where-Object {$_.Skill -eq $line.Trim()} | Select-Object -ExpandProperty Code
			$SkillList += [PSCustomObject] @{
				Name	  = $toon
				SkillName = $line.trim()
				SkillLevel = $line2
                Code       = $Code
			}
		}
	}
}
#$SkillList | Where-Object { $_.SkillLevel -ne '0' }
#Write-Output ''
#Write-Output "Total toons: $(($SkillList | Select-Object name -Unique).count)"
#endregion ParseLocalFiles

#region CreateMacro
Write-Host 'Creating macro and CSV.  This can take several minutes.  Please wait...' -ForegroundColor Cyan
Write-Output '#turbo' | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Force # -Encoding ascii #Create a blank file - overwrites
Write-Output '' | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append
Write-Output 'Sub Main' | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append
Write-Output '' | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append
Write-Output '/bca //endmac' | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append
write-output "/delay 5" | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append
Write-Output '/bca //pet get lost' | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append
Write-Output '/delay 5' | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append

foreach ($sl in $SkillList)
{	
    Write-Output "/tar $($sl.Name)" | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append
	Write-Output '/delay 2' | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append
	Write-Output "/say #setskill $($sl.Code) $($sl.SkillLevel)" | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append #setskill [skillnum] [value] - Set your target's skill skillnum to value
	Write-Output '/delay 2' | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append
}
Write-Output '' | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append
Write-Output '/return' | Out-File "$env:TEMP\EQSkillSync.mac" -Encoding ascii -Append
$SkillList | Export-Csv "$env:TEMP\EQSkillSync.csv" -NoTypeInformation -Force #out full skill list
Write-Host ''
Write-Host "Full skill list saved to $env:TEMP\EQSkillSync.csv" -ForegroundColor Yellow
Write-Host "Macro saved to $env:TEMP\EQSkillSync.mac" -ForegroundColor Yellow
Write-Host "Copy this macro to your macros folder and run it on your personal server from your GM toon.  It will target each bot and update their skills to match your live emulated toon." -ForegroundColor DarkYellow
Write-Host "This assumes your toons are named exactly as they are on the emulated server." -ForegroundColor DarkYellow
#endregion 
