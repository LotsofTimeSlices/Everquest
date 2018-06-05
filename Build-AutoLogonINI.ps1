#Builds MQ2AutoLogin INI data.  Copy and Paste results to MQ2AutoLogin.ini.  
$ini = @()
$toons = Import-Csv -Path 'c:\PATH\Toons.csv' #change to path of toons.csv
foreach ($toon in $toons ) 
{
    if ($toon.Login -ne '')
    {
    $ini += [pscustomobject]@{
	Login   = '['+$toon.Login.Trim()+']'
        Password  = 'Password='+$toon.Password.Trim()
        Server    = 'Server='+$toon.Server.Trim()
	Character = 'Character='+$toon.Character.Trim()
        EQPath    = 'EQPath='+$toon.EQPath.Trim()    
        }
    }
}
Clear-Host
foreach ($i in $ini)
{
    $i.Login
    $i.Password
    $i.Server
    $i.Character
    $i.EQPath
    ''
}
