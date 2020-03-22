#For use with /bcaa //outputfile inventory
#It's a good idea to search for *-inventory.txt and delete any old files as they will be parsed as well.
#***This output macro will end all running macros and removes current pets****
clear-host
$InvPath = @()
Write-Host '-----------------------------------------------------'
write-host 'You must first run /bcaa //outputfile inventory to generate inventory files'
write-host 'Then enter how many instances of eq you have installed below'
Write-Host '-----------------------------------------------------'
Write-Host ''
try 
{
    [int32]$FolderCount = Read-Host 'How many folders have inventory files?'
}
catch 
{
    Write-Host 'Numbers only please.  Exiting...'
    Break
}
Write-Host ''
Write-Host '-----------------------------------------------------'
Write-Host 'Enter your path for each instance of EQ such as:'
write-host '(1 of 2) Enter your path here: C:\RoF2\Everquest'
write-host '(2 of 2) Enter your path here: C:\RoF2\Everquest_Bots'
Write-Host '-----------------------------------------------------'
Write-Host ''
$f = 0
do 
{
    $InvPath += Read-Host "($($f+1) of $FolderCount) Enter your path here"
    $f++
}
until ($f -eq $FolderCount)
Write-Host "Parsing inventory - Please wait..." -ForegroundColor Cyan

Write-Output '#turbo' | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Force # -Encoding ascii #Create a blank file - overwrites
Write-Output '' | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
Write-Output 'Sub Main' | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
Write-Output '' | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
Write-Output '/bca //endmac' | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
write-output "/delay 5" | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
Write-Output '/bca //pet get lost' | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
Write-Output '/Echo Importing inventory...' | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append

$inv = @()
$files = @()
foreach ($i in $InvPath) 
{
    $files = Get-ChildItem -Path $i | Where-Object { $_ -match '-Inventory.txt'} | Select-Object -ExpandProperty Name

    
    ForEach ($file in $files) 
    {
        try {
            $csv = Import-Csv $i\$file -Delimiter "`t" #| Select-Object location,name,ID -first 55    
            write-output "/delay 10" | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
            write-output "/tar $($file.replace('-Inventory.txt',''))" | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
            write-output "/delay 10" | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
            foreach ($c in $csv) {     
                if (($c.Location -match 'Ammo') -or ($c.Location -match 'Arms') -or ($c.Location -match 'Back') -or ($c.Location -match 'Charm') -or ($c.Location -match 'Chest') -or ($c.Location -match 'Ear') -or ($c.Location -match 'Face') -or ($c.Location -match 'Feet') -or ($c.Location -match 'Fingers') -or ($c.Location -match 'Hands') -or ($c.Location -match 'Head') -or ($c.Location -match 'Legs') -or ($c.Location -match 'Neck') -or ($c.Location -match 'Primary') -or ($c.Location -match 'Range') -or ($c.Location -match 'Secondary') -or ($c.Location -match 'Shoulders') -or ($c.Location -match 'Waist') -or ($c.Location -match 'Wrist')) {    
                    $inv += [pscustomobject]@{
                        Toon = $file.replace('-Inventory.txt', '')
                        Slot = $c.Location
                        Name = $c.Name
                        ID   = $c.ID
                    }
                    if ($c.ID -ne 0) {
                        write-output "/say #giveitem $($c.ID)" | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
                        write-output "/delay 5" | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
                    }
                }
            }
        }
        catch
        {}
    }
}
Write-Output '/echo Done importing inventory...' | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
Write-Output '' | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
Write-Output '/return' | Out-File "$env:TEMP\EQInventorySync.mac" -Encoding ascii -Append
$Inv | Export-Csv "$env:TEMP\EQInventory.csv" -NoTypeInformation -Force #out full inventory
Write-Host ''
Write-Host "Full inventory saved to $env:TEMP\EQInventory.csv" -ForegroundColor Yellow
Write-Host "Macro saved to $env:TEMP\EQInventorySync.mac" -ForegroundColor Yellow
Write-Host "Copy this macro to your macros folder and run it on your personal server from your GM toon.  It will target each bot and create the armor/aug on the targeted toon." -ForegroundColor DarkYellow
Write-Host "This assumes your toons are named exactly as they are on the emulated server." -ForegroundColor DarkYellow
$ToonCount = Get-Content "$env:TEMP\EQInventorySync.mac" | Where-Object {$_ -match '/tar'}
Write-Host "Total toons written to EQInventorySync.mac - $($ToonCount.count)" -ForegroundColor Green
