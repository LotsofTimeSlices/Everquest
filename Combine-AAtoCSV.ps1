<#
http://www.projecteq.net/forums/index.php?threads/aa-export.15942/
For use with the macro found in the link above. 
Call with "/bcaa //mac aap save".  This will create a text file in your macros folder - "AA_toonname.ini" which you can edit after saving.​
#> 
$macrosFolder = 'C:\RoF2\E3_RoF2\Macros' #Change to your MQ2 macro folder
$files = Get-ChildItem $macrosFolder | Where-Object {$_.Name -match 'AA_'} | Sort-Object
$List = @()
foreach ($file in $files) #Loop through each file
{
    $content = Get-Content "$macrosFolder\$($file.Name)"
    foreach ($AA in $content)
    {
        $toon = ($($file.Name) -split '.ini')[0].Trim()
        $toon = $toon.Substring(3)
        if ($AA -notmatch 'AAtoBuy' -and $AA -notmatch 'AACount')
        {            
            $AAName = ($AA -split '=')[1].Trim()
            $AASplit = ($AAName -split '\|').Trim()
            $List += [PSCustomObject] @{
                Toon = $toon
                Name = $AASplit[0]
                Level = $AASplit[1]
            }
        }
 
    }
}

$List | Export-Csv "$macrosFolder\AllAAs.csv" -NoTypeInformation -Force
Invoke-Item "$macrosFolder\AllAAs.csv"
