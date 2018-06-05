set-location 'C:\PATH\RoF2\E3_RoF2\Macros\e3 Bot Inis'   #Location of Bot INIs
$files = (Get-ChildItem -file)
foreach ($file in $files)
{
    $name = $file -replace 'PEQTGC-',''  -replace '.ini',''
    $newname = $name + '_PEQTGC.ini'
    Rename-Item $file -NewName $newname -Force
}
