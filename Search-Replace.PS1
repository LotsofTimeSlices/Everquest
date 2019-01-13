$INIFile = 'C:\RoF2\E3_RoF2\Macros\e3 Macro Inis\Loot Settings.ini' #Change to where INI file lives
$SearchTerm = 'Grade A' #Set your search term here -- This line will be altered if it contains the $BaseAction string else it will be skipped
$BaseAction = '=Skip' #Set your current string here -- This is the string you want replaced
$ReplaceAction = '=Keep' #Set your new/updated string here -- This is the replacement string

clear
$INIContent = Get-Content $INIFile
$content = @()
$before = @()
$after = @()
$final = @()
####Backup Check####
$BackupFile = (Split-Path -Path $INIFile -Leaf).Split('.')[0] #get filename only
$BackupFileCheck = Get-ChildItem (Split-Path -Path $INIFile) #get path only
if (($BackupFileCheck.Name -match $backupFile).count -le 1) #check if there is another file with a similar name.  This is only a guess the backup name is similar and in the same folder but an added precaution all the same.
{
    $MakeBackup = 'Please make a backup of this file!'
}
####Backup Check End####

$content += $INIContent | ForEach-Object {
    if ($_ -match $SearchTerm)
    {        
        $before += $_ + "`n"
        $_ -replace $BaseAction,$ReplaceAction      
    }
 }
write-host "$($content.count) matching results found:"
Write-Host $before -ForegroundColor Yellow

$content | ForEach-Object {
    if ($_ -match $searchterm)
    {
        $after += $_ + "`n"
    }
}

write-host "$($content.count) items after change:"
Write-Host $after -ForegroundColor Green
if ($MakeBackup)
{
    Write-Host $MakeBackup -ForegroundColor Yellow
}

$confirmation = Read-Host "Are you Sure You Want To Proceed? [y/n]"
if ($confirmation -eq 'y') 
{
    $INIContent | ForEach-Object {
        if ($_ -match $searchterm )
        {           
            $_ -replace $BaseAction,$ReplaceAction
        }
        else
        {
            $_
        }
    } | Set-Content $INIFile -Force -Verbose
    ####Verify content####
    $INIContentAfter = Get-Content $INIFile #Refresh content
    $content += $INIContentAfter | ForEach-Object {
        if ($_ -match $SearchTerm)
        {        
            $final += $_ + "`n"
            $_ -replace $BaseAction,$ReplaceAction      
        }
    }
    Write-Host "`n"
    Write-Host "Updated content from $inifile" -ForegroundColor Magenta
    Write-Host $final -ForegroundColor Green
    Write-host "$($INIContent.Count) total lines of data before change"
    Write-host "$($INIContentAfter.Count) total lines of data after change"
}


