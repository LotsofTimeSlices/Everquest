[int32]$ProcAffinity = [math]::pow(2,((Get-WmiObject -class Win32_processor).NumberOfLogicalProcessors))-1; Get-Process eqgame | ForEach-Object { $_.ProcessorAffinity=$ProcAffinity }
