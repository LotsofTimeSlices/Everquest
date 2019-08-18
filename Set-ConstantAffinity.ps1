$host.ui.RawUI.WindowTitle = 'Set-ConstantAffinity'
$procAffinity = [Int32]([math]::pow(2, $(Get-WmiObject -class Win32_processor).NumberOfLogicalProcessors) - 1) #processor affinity number based on # of logical cores
Do
{
	Do
	{
		Start-Sleep -Seconds 4
	}
	While ((Get-Process eqgame).MainWindowTitle -match 'Everquest') #does nothing until all EQ windows have been renamed by MQ2AutoLogin    
	Write-Host 'Checking Processor Affinity...'
	$AffinityNotSet = Get-Process eqgame | Where-Object { $_.ProcessorAffinity -ne $procAffinity }
	ForEach ($A in $AffinityNotSet) #Set processes to affinity who are not set
	{
		Write-Host "Setting toon to affinity:  $($A.MainWindowTitle)"
		$A.ProcessorAffinity = $procAffinity
	}
	Write-Host 'Deep Sleep...'
	Start-Sleep -Seconds 25 #Deep Sleep
}
while (Get-Process eqgame) #Runs until EQ is closed