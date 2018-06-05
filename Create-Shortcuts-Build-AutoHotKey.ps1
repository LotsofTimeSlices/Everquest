$ini = @()
$lines = @()
$ShortcutPath = '' #Enter Path to new Shortcuts
if (!($ShortcutPath.EndsWith('\'))) #Ending slash requried - Set path to save new shortcuts
{
    $ShortcutPath = $ShortcutPath + '\'
}
$shorcuts = Get-ChildItem $ShortcutPath #New shortcuts folder
$toons = Import-Csv -Path '' #Enter path to Toons CSV
foreach ($toon in $toons ) 
{
    if ($toon.Login -ne '')
    {
    $ini += [pscustomobject]@{
	Login   = $toon.Login.Trim()
        Password  = $toon.Password.Trim()
        Server    = $toon.Server.Trim()
	Character = $toon.Character.Trim()
        EQPath    = $toon.EQPath.Trim()
        Shortcut  = $toon.ShortCut.Trim()  
      }
    }
}
Clear-Host
#Building shortcuts
Write-Host 'Building shortcuts...'
foreach ($i in $ini)
{    
    if ($i.EQPath.EndsWith('\')) #Removes extra slash if present
{
    $ShortcutPath = $ShortcutPath - '\'
}
    $TargetPathExe = $i.EQPath + '\eqgame.exe'
    $Arguments = "patchme /login:$($i.Login)"    
    $ShortcutName = $i.Character + '.lnk'
    $WorkingDirectory = $i.EQPath
    #$Description = ''
    
    $Shell = New-Object -ComObject ("WScript.Shell")
    $ShortCut = $Shell.CreateShortcut($ShortcutPath + $ShortcutName)
    $ShortCut.TargetPath= $TargetPathExe #"yourexecutable.exe"
    $ShortCut.Arguments= $Arguments #$Arguments #"-arguementsifrequired"
    $ShortCut.WorkingDirectory = $WorkingDirectory #"c:\your\executable\folder\path";
    #$ShortCut.WindowStyle = 1;
    #$ShortCut.Hotkey = "CTRL+SHIFT+F";
    #$ShortCut.IconLocation = "yourexecutable.exe, 0";
    #$ShortCut.Description = $Description #"Your Custom Shortcut Description";
    $ShortCut.Save() 
}

write-host 'Shortcut build complete'

#reorder to match toons spreadsheet order
foreach ($i in $ini)
{
     foreach ($s in $shorcuts)
     {
        if ($s.BaseName -eq $i.Character)
        {
            $lines += [PSCustomObject] @{
                FullName = $s.FullName
                Name     = $s.BaseName
            }
        }
     }
}


#Build AutoHotKey
Write-Host ''
Write-Host '----Copy/Paste lines below into AutoHotKey script----'
Write-Host ''
foreach ($l in $lines)
{
    'Run ' + $l.FullName
    'WinWaitActive, EverQuest'
    'WinSetTitle, ' + $l.Name
    ''
}
