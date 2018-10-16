#region Source: Startup.pss
#----------------------------------------------
#region Import Assemblies
#----------------------------------------------
#endregion Import Assemblies

#Define a Param block to use custom parameters in the project
#Param ($CustomParameter)

function Main {
<#
    .SYNOPSIS
        The Main function starts the project application.
    
    .PARAMETER Commandline
        $Commandline contains the complete argument string passed to the script packager executable.
    
    .NOTES
        Use this function to initialize your script and to call GUI forms.
		
    .NOTES
        To get the console output in the Packager (Forms Engine) use: 
		$ConsoleOutput (Type: System.Collections.ArrayList)
#>
	Param ([String]$Commandline)
		
	#--------------------------------------------------------------------------
	#TODO: Add initialization script here (Load modules and check requirements)
	
	
	#--------------------------------------------------------------------------
	
	if((Show-MainForm_psf) -eq 'OK')
	{
		
	}
	
	$script:ExitCode = 0 #Set the exit code for the Packager
}



#endregion Source: Startup.pss

#region Source: MainForm.psf
function Show-MainForm_psf
{
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$MainForm = New-Object 'System.Windows.Forms.Form'
	$labelPEQConfiguratorIsDes = New-Object 'System.Windows.Forms.Label'
	$buttonBuildSampleTOONSCSV = New-Object 'System.Windows.Forms.Button'
	$labelPEQConfigurator = New-Object 'System.Windows.Forms.Label'
	$richtextbox1 = New-Object 'System.Windows.Forms.RichTextBox'
	$buttonBuildMQ2AutoLogin = New-Object 'System.Windows.Forms.Button'
	$buttonBuildAutoHotKey = New-Object 'System.Windows.Forms.Button'
	$buttonBuildShortcuts = New-Object 'System.Windows.Forms.Button'
	$labelToonsCsvLocation = New-Object 'System.Windows.Forms.Label'
	$buttonBrowse = New-Object 'System.Windows.Forms.Button'
	$toonsFile = New-Object 'System.Windows.Forms.TextBox'
	$folderbrowserdialog1 = New-Object 'System.Windows.Forms.FolderBrowserDialog'
	$openfiledialog1 = New-Object 'System.Windows.Forms.OpenFileDialog'
	$openfiledialog2 = New-Object 'System.Windows.Forms.OpenFileDialog'
	$openfiledialog3 = New-Object 'System.Windows.Forms.OpenFileDialog'
	$openfiledialog4 = New-Object 'System.Windows.Forms.OpenFileDialog'
	$tooltip1 = New-Object 'System.Windows.Forms.ToolTip'
	$folderbrowserdialog2 = New-Object 'System.Windows.Forms.FolderBrowserDialog'
	$folderbrowserdialog3 = New-Object 'System.Windows.Forms.FolderBrowserDialog'
	$savefiledialog1 = New-Object 'System.Windows.Forms.SaveFileDialog'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	$MainForm_Load = {
		#Disable buttons
		$buttonBuildShortcuts.Enabled = $false
		$buttonBuildAutoHotKey.Enabled = $false
		$buttonBuildMQ2AutoLogin.Enabled = $false
	
	}
	
	$buttonCallChildForm_Click = {
		#TODO: Place custom script here
		if ((Show-ChildForm_psf) -eq 'OK')
		{
			
		}
	}
	
	$buttonBrowse_Click = {
		$openfiledialog1.Title = "Open Toons.CSV"
		#$openfiledialog1.InitialDirectory = $share
		#$openfiledialog1.DefaultExt = "CSV"
		$openfiledialog1.Filter = "CSV (*.csv)|*.CSV|All files (*.*)|*.*"
		if ($openfiledialog1.ShowDialog() -eq 'OK')
		{
			
			$toonsFile.Text = $openfiledialog1.FileName
			
		}
	}
	
	$toonsFile_TextChanged = {
		if ($toonsFile.Text -ne '')
		{
			$buttonBuildShortcuts.Enabled = $true
			$buttonBuildAutoHotKey.Enabled = $true
			$buttonBuildMQ2AutoLogin.Enabled = $true
		}
		else
		{
			$buttonBuildShortcuts.Enabled = $false
			$buttonBuildAutoHotKey.Enabled = $false
			$buttonBuildMQ2AutoLogin.Enabled = $false		
			
		}
	}
	
	$buttonBuildShortcuts_Click = {
		buttondown
		$richtextbox1.Clear()
		if ($folderbrowserdialog1.ShowDialog() -eq 'OK')
		{
			$script:shortcutFolder = $folderbrowserdialog1.SelectedPath
			
			$ini = @()
			$toons = Import-Csv -Path $toonsFile.Text #Toons CSV location
			foreach ($toon in $toons)
			{
				if ($toon.Login -ne '')
				{
					$ini += [pscustomobject]@{
						Login = $toon.Login.Trim()
						Password = $toon.Password.Trim()
						Server = $toon.Server.Trim()
						Character = $toon.Character.Trim()
						EQPath = $toon.EQPath.Trim()
					}
				}
			}
			
			if (-not ($shortcutFolder.EndsWith('\')))
			{
				$shortcutFolder = $shortcutFolder + '\'
			}
			
			Update-Display "Building Shortcuts..." -color 'Orange'
			foreach ($i in $ini)
			{
				$TargetPathExe = $i.EQPath + '\eqgame.exe'
				$Arguments = "patchme /login:$($i.Login)"
				$ShortcutName = $i.Character + '.lnk'
				$WorkingDirectory = $i.EQPath
				#$Description = ''
				
				#$FullLink = $ShortcutPath + $Shortcut
				$Shell = New-Object -ComObject ("WScript.Shell")
				$ShortCut = $Shell.CreateShortcut($shortcutFolder + $ShortcutName)
				$ShortCut.TargetPath = $TargetPathExe #"yourexecutable.exe"
				$ShortCut.Arguments = $Arguments #$Arguments #"-arguementsifrequired"
				$ShortCut.WorkingDirectory = $WorkingDirectory #"c:\your\executable\folder\path";
				#$ShortCut.WindowStyle = 1;
				#$ShortCut.Hotkey = "CTRL+SHIFT+F";
				#$ShortCut.IconLocation = "yourexecutable.exe, 0";
				#$ShortCut.Description = $Description #"Your Custom Shortcut Description";
				$ShortCut.Save()
			}
			Update-Display "Finished Building Shortcuts!" -color 'Green'
			Update-Display "Shortcuts saved to:" -color 'Orange'
			Update-Display "File:///$($shortcutFolder)"
			$buttonBuildAutoHotKey.Enabled = $true
		}
		else
		{
			Update-Display 'Operation Cancelled' -color 'Red'
		}
		
		buttonup
		
	}
	
	$buttonBuildAutoHotKey_Click = {
		buttondown
		$richtextbox1.Clear()
		$shortcuts = Get-ChildItem -Path $shortcutFolder -filter "*.lnk" #New shortcuts folder
		$toons = Import-Csv -Path $toonsFile.Text #Toons CSV location
		$ini = @()
		foreach ($toon in $toons)
		{
			if ($toon.Login -ne '')
			{
				$ini += [pscustomobject]@{
					Login = $toon.Login.Trim()
					Password = $toon.Password.Trim()
					Server = $toon.Server.Trim()
					Character = $toon.Character.Trim()
					EQPath = $toon.EQPath.Trim()
				}
			}
		}
		$lines = @()
		if ($shortcuts) #only run if $shortcuts contains data
		{
			$richtextbox1.Clear()
			#reorder to match toons spreadsheet order
			foreach ($i in $ini)
			{
				foreach ($s in $shortcuts)
				{
					if ($s.BaseName -eq $i.Character)
					{
						$lines += [PSCustomObject] @{
							FullName = $s.FullName
							Name	 = $s.BaseName
						}
					}
				}
			}
			Clear-Host
			#Build AutoHotKey
			Update-Display '----Copy/Paste lines below into AutoHotKey script----' -color 'Orange'
			$list = @()
			$list += '#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.'
			$list += '#Warn  ; Recommended for catching common errors.'
			$list += 'SendMode Input; Recommended for new scripts due to its superior speed and reliability.'
			$list += 'SetWorkingDir %A_ScriptDir%; Ensures a consistent starting directory.'
			$list += ''
			foreach ($l in $lines)
			{
				$list += 'Run ' + $($l.FullName)
				$list += 'WinWaitActive, EverQuest'
				$list += 'WinSetTitle, ' + $($l.Name)
				$list += ''
			}
			Update-Display $list
			Update-Display '----Copy/Paste lines above into AutoHotKey script----' -color 'Orange'
		}
		else
		{
			Update-Display "Shortcuts folder is empty or not found.  Please create EQ shortcuts and try again." -color 'Yellow'
			if ($folderbrowserdialog1.ShowDialog() -eq 'OK')
			{
				$script:shortcutFolder = $folderbrowserdialog1.SelectedPath
				Start-Sleep -Seconds 1
				$shortcuts = Get-ChildItem -Path $shortcutFolder -filter "*.lnk" #New shortcuts folder			
				if ($shortcuts) #only run if $shortcuts contains data
				{
					$richtextbox1.Clear()
					#reorder to match toons spreadsheet order
					foreach ($i in $ini)
					{
						foreach ($s in $shortcuts)
						{
							if ($s.BaseName -eq $i.Character)
							{
								$lines += [PSCustomObject] @{
									FullName = $s.FullName
									Name	 = $s.BaseName
								}
							}
						}
					}
					Clear-Host
					#Build AutoHotKey
					Update-Display '----Copy/Paste lines below into AutoHotKey script----' -color 'Orange'
					$list = @()
					$list += '#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.'
					$list += '#Warn  ; Recommended for catching common errors.'
					$list += 'SendMode Input; Recommended for new scripts due to its superior speed and reliability.'
					$list += 'SetWorkingDir %A_ScriptDir%; Ensures a consistent starting directory.'
					$list += ''
					foreach ($l in $lines)
					{
						$list += 'Run ' + $($l.FullName)
						$list += 'WinWaitActive, EverQuest'
						$list += 'WinSetTitle, ' + $($l.Name)
						$list += ''
					}
					Update-Display $list
					Update-Display '----Copy/Paste lines above into AutoHotKey script----' -color 'Orange'
				}
				else
				{
					Update-Display 'No EQ shortcuts found.  Please create some first.' -color 'red'
					$noshortcuts = $true
					
				}
			}
		}
		
		buttonup
		if ($noshortcuts -eq $true)
		{
			$buttonBuildAutoHotKey.Enabled = $false
		}
	}
	
	$buttonBuildMQ2AutoLogin_Click = {
		buttondown
		$richtextbox1.Clear()
		$toons = Import-Csv -Path $toonsFile.Text #Toons CSV location
		$ini = @()
		foreach ($toon in $toons)
		{
			if ($toon.Login -ne '')
			{
				$ini += [pscustomobject]@{
					Login = '[' + $toon.Login.Trim() + ']'
					Password = 'Password=' + $toon.Password.Trim()
					Server = 'Server=' + $toon.Server.Trim()
					Character = 'Character=' + $toon.Character.Trim()
					EQPath = 'EQPath=' + $toon.EQPath.Trim()
				}
			}
		}
		Clear-Host
		Update-Display '----Copy/Paste lines below into custom MQ2AutoLogon.ini script----' -color 'Orange'
		$list2 = @()
		$list2 += ''
		foreach ($i in $ini)
		{
			$list2 += $i.Login
			$list2 += $i.Password
			$list2 += $i.Server
			$list2 += $i.Character
			$list2 += $i.EQPath
			$list2 += ''
		}
		Update-Display $list2
		Update-Display '----Copy/Paste lines above into custom MQ2AutoLogon.ini script----' -color 'Orange'
		
		buttonup
	}
	
	$buttonBuildSampleTOONSCSV_Click = {
		buttondown
		$richtextbox1.Clear()
		$nums = 1 .. 12
		$ini = @()
		foreach ($n in $nums)
		{
			$n
			if ($n -eq 7)
			{
				$ini += [pscustomobject]@{
					Login	  = ''
					Password  = ''
					Server    = ''
					Character = ''
					EQPath    = ''
				}
			}
			$ini += [pscustomobject]@{
				Login = 'Login' + $n
				Password = 'PassWord!'
				Server = 'peqtgc'
				Character = 'ToonName' + $n
				EQPath = 'C:\Users\user\Desktop\RoF2\Everquest'
			}
			
		}
		$savefiledialog1.Title = "Save Sample TOONS.CSV"
		#$openfiledialog1.InitialDirectory = $share
		#$openfiledialog1.DefaultExt = "CSV"
		$savefiledialog1.Filter = "CSV (*.csv)|*.CSV|All files (*.*)|*.*"
		$savefiledialog1.FileName = 'Toons-Sample.csv'
		if ($savefiledialog1.ShowDialog() -eq 'OK')
		{
			Update-Display "Exporting to CSV..." -color 'Orange'
			$ini | Export-Csv -path $savefiledialog1.FileName -Delimiter "," -NoTypeInformation
			Update-Display "File saved to:" -color 'Orange'
			Update-Display "File:///$($savefiledialog1.Filename)"
			
		}
		else
		{
			Update-Display 'Operation Cancelled' -color 'Red'	
		}
		
		buttonup
		
	}
	
	$richtextbox1_LinkClicked = [System.Windows.Forms.LinkClickedEventHandler]{
			#Event Argument: $_ = [System.Windows.Forms.LinkClickedEventArgs]
			Start-Process -FilePath $_.LinkText #make links clickable
			
	}
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$MainForm.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:MainForm_richtextbox1 = $richtextbox1.Text
		$script:MainForm_toonsFile = $toonsFile.Text
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonBuildSampleTOONSCSV.remove_Click($buttonBuildSampleTOONSCSV_Click)
			$richtextbox1.remove_LinkClicked($richtextbox1_LinkClicked)
			$buttonBuildMQ2AutoLogin.remove_Click($buttonBuildMQ2AutoLogin_Click)
			$buttonBuildAutoHotKey.remove_Click($buttonBuildAutoHotKey_Click)
			$buttonBuildShortcuts.remove_Click($buttonBuildShortcuts_Click)
			$buttonBrowse.remove_Click($buttonBrowse_Click)
			$toonsFile.remove_TextChanged($toonsFile_TextChanged)
			$MainForm.remove_Load($MainForm_Load)
			$MainForm.remove_Load($Form_StateCorrection_Load)
			$MainForm.remove_Closing($Form_StoreValues_Closing)
			$MainForm.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$MainForm.SuspendLayout()
	#
	# MainForm
	#
	$MainForm.Controls.Add($labelPEQConfiguratorIsDes)
	$MainForm.Controls.Add($buttonBuildSampleTOONSCSV)
	$MainForm.Controls.Add($labelPEQConfigurator)
	$MainForm.Controls.Add($richtextbox1)
	$MainForm.Controls.Add($buttonBuildMQ2AutoLogin)
	$MainForm.Controls.Add($buttonBuildAutoHotKey)
	$MainForm.Controls.Add($buttonBuildShortcuts)
	$MainForm.Controls.Add($labelToonsCsvLocation)
	$MainForm.Controls.Add($buttonBrowse)
	$MainForm.Controls.Add($toonsFile)
	$MainForm.AutoScaleDimensions = '6, 13'
	$MainForm.AutoScaleMode = 'Font'
	$MainForm.ClientSize = '595, 592'
	$MainForm.FormBorderStyle = 'FixedDialog'
	#region Binary Data
	$MainForm.Icon = [System.Convert]::FromBase64String('
AAABAAIAGBgAAAEACADIBgAAJgAAABgYAAABACAAiAkAAO4GAAAoAAAAGAAAADAAAAABAAgAAAAA
AKACAAAAAAAAAAAAAAABAAAAAAAAOTD6AFlx/QAXGvgAd5j+ADIp+QAdK/kAb479AAAAAABqhvwA
GyT4AGaE/QBlgv0AZH78ACQ++QBhe/wAGB34ABgh7gACAKIAW3X9AB4v+QATE+0AEhHmACQ8+QAL
BdEAGSD4ABke+ABLRvoAKkn7AClG+wBmg/0AY4L9ACc/+QALCd8AX3f8AFxz/AAcJvkACgXFAChD
+QAnQPkAIj77AAEAjQBti/0AGiL4AB8z+QAcKPkAIDb5ACM7+QAdLfkAIjn5ACE3+QAiOPkAHSz5
AG+N/QB0lf0AdZf+AHOS/QAfMvkAIDX5AHCO/QBwj/0AYXn8AHOV/gBxkf0AGyf4AAgDzwBsiv0A
HCj4AB0p+QBgePwAoLb+AGJ8/AB1lv0AKEH5ABoj+AAeMPkAZID9AGuL/QCJp/4ABACqAB8y/ABq
h/0ATGr8AF5v/AAfMfkAITn5ALHL/wBWefwAHTb4ADYv7QAGAtAAMS3yAB85+QBzlP0ANCr5ALfP
/wCMrf8AaIL8AAcDzQATEfoAFRjqAKe8/wB1j/4ASkj6AGeB/AAUE/UAVEz7AFdQ+wAKBM0AXHb8
AEdA+QATFOkAJ0T7AHGO/QBigf0AQDfsAAcCvQBvj/4AFhf4ABYV+wCqvf4Ah5D9ACI6+QA2L/oA
Ijv5AB80+QAjPPkAfIj+AAoI4wAVD74AHjH5AIGZ/wAiOfwAPjb6AFFI7QCRof8AdpL+ABog+wAv
TvsAuM//AC5K+wAbLPkAWVv8ACZC+wB2l/4AOE77ACkg7gA6NfgAGSj5AIen/wArQvkAGBz6ABke
+wBzkf0Ae5v+AHCT/gAlPvoAGSf5AFhR8wC1yv8AZXr8AFRa9AA6W/wAKUL7AGyJ/QBgefwAQ0Hs
AG2K/gAUEvkAZGf2AKO7/wCjvf8AWnn8AF17/QBdfv4Aco39ABki+gBniP0ArMX/ACZC/AAODO4A
YWX8AGF//QAzT/sAVFb6AJy5/wCfvP8AXXX8AJut/wAJBsgAP2D8ADYv9gBUTPUAmrP/ABgc/AAS
EukAmLD+ABoh/ABQcfwAJB/rAHGP/QBhgP0AMEj7AJOk/wBCPOgABQC1AAgDuwBIRvkAb5H9AAEA
kwBjh/0AHCn5AA8L3QAVFvkAGyT7ABUV+wAwKPYAEhH0ABgX+gAVFfUAqL7/ABUd7QAfGuUAZ4b9
ADUt+AA1LfoALSXeAB0u+QAYGvoAIzr5AF1t/gAaJO8AJDD4AB42+QBMR/sAoLf/AAIAmwBjff0A
CATBAH6L/gADANUADQvmABINuQB0l/0Aa4n9AJ+s/gBMSvkATUn7AChA+QBKX/sAKUD5ADQt9gBv
jP0AHSr8AClH+wAGAa8A////AAcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHBwcH69AH
BwcHBwcHBwcHBwcHBwcHBwcHBwcR8H8oBwcHBwcHBwcHBwcHBwcHBwcHB04VdmIgKAcHBwcHBwcH
BwcHBwcHBwcH8W7BAtSnsxEHBwcHBwcHBwcHBwcHBwdzY9UYDwJ11tj+BwcHBwcHBwcHBwcHByTc
/AkqGBkPAtlozAcHBwcHBwcHBwcHaxBPMwVCCSoYDw/j2s0HBwcHBwcHBwcX5oMrgeIzQz8JKhgP
lhSABwcHBwcHB0DmJ3syLStKLwUsP0kYGZcU7QcHBwcHWUCbHw0uMDE5OBMvBSwJKhiIFSQHBwfv
ICeySPcNFuQyMStTEzNDQgkqxNO8BwfdVw39G6IlJg19eTItK0riBdI/Sa8XB8agrcWJ/f0cJUgf
DS4wMTk4Ey8FLCPCYZGHtSmYVr39b44mHw0NLjAtfBOMnJPn4VqUsDs0+647q1GhtotUW+j5lcmQ
+FLly85fzzc+OjQpKUHzUAgIYGcMRjwhIgEBpZKqmkc1N3A6NCmj3mULHQxGPEQhuiIScm1kmTYD
RzU+xwZBTEXIHR1LDA6kRGyfheC0sT02A/JcO0wGyvTDcd4KC0ukEqaoWAdq7p5NPXRM0Y/qGul3
RSkeHqzsgn6dBwcHaY27irm4Ve4ABweEeF7bwKmGt78HBwcHBwAE3+n2BAAHBwcHel31ZvrXvgcH
BwcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHB////wD/5/8A/8P/AP+B/wD/AP8A/gB/APwAPwD4AB8A
8AAPAOAABwDAAAMAgAABAIAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAABAMAYAwDg
PAcA////ACgAAAAYAAAAMAAAAAEAIAAAAAAAYAkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAIAm+0BAJPtAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQCg5Q0L
5v8KCOP/AQCM5QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAKrlERDn/xYV+/8TEfr/Cwjf/wEAjv8CAKAa
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAACAO9GwUAtfgTFOn/GBz8/xcZ+f8VFvn/FBL5/w4M7v8DAKT/AwCoGgAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKBcUaBwK9/xUY6v8bJPv/GR/4
/xgd+P8XG/j/Fhf4/xUV+/8SEfT/BgGv/wYCsRoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAsGzRoKBMT/FR3t/x0q/P8bJfj/GiL4/xkh+P8ZHvj/GBz4/xca+P8Y
F/r/FBP1/wUAtf8HArMaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAfTBwoE
zf8YIe7/HzL8/x0s+f8dKvn/HCj4/xsk+P8aIvj/GSD4/xgd+P8YHPj/GBr6/xUV9f8IA7v/CAK6
GwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACgTS5Bok7/8iOfz/HzP5/x4x+f8eLvn/
HSz5/x0p+f8cJ/j/GyT4/xoi+P8ZH/j/GB34/xgc+v8TE+7/CAK7+AAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAIA8/mGSPv/yM++/8iO/n/Ijj5/yA2+f8fM/n/HjD5/x0t+f8dK/n/HCj5/xsn
+P8aI/j/GSH4/xke+P8ZHvv/EhLs/wgEweUAAAAAAAAAAAAAAAAAAAAAAAAAAAYC0LwRFef/JT76
/yc++f8kPfn/Izv5/yI5+f8hN/n/IDX5/x8y+f8eL/n/HS35/x0q+f8cKPn/GyX4/xoi+P8ZIPj/
GiD7/xIR5f8KBsW8AAAAAAAAAAAAAAAAAwDVggoK3/8hPfz/JkL8/yhB+f8oQPn/JT/5/yQ8+f8j
Ovn/Ijj5/yE3+f8fM/n/HzH5/x4v+f8dLPn/HSn5/xwo+P8bJPj/GiL4/xoh/P8PC93/CQbIggAA
AAA3L+wGHxrl/x02+P8jPvr/Kkf7/ypJ+/8pQvv/KEL5/ydA+f8lP/n/Izz5/yI6+f8iOPn/IDb5
/x8z+f8eMPn/HS75/x0r+f8cKfn/Gyf4/xoj+P8ZIvr/CwbQ/wkGygYkH+uHVFr0/11+/v9Qcfz/
L077/ylH+/8pR/v/KUb7/yhD+f8oQfn/Jz/5/yQ9+f8jO/n/Ijn5/yE3+f8gNfn/HzL5/x4v+f8d
Lfn/HSv5/xwo+f8cJvn/EhLp/wcDzYcpIO7gdpL+/2F//f9ti/3/c5H9/1Z5/P8/YPz/KUj7/ydE
+/8mQvv/JkD5/yc/+f8kPvn/JD35/yM7+f8iOfn/IDb5/x80+f8eL/n/Gyz5/xkn+f8ZKPn/JDD4
/y0l3uAxLfL/h6f//2eI/f9wj/3/b439/2+M/f9yjf3/b4/9/1p5/P9Mavz/Olv8/zNP+/8uSvv/
ITn5/x85+f8eNvn/KUD5/ytC+f8wSPv/OE77/0pf+/9eb/z/XW3+/0I86P9IRvn/jK3//2+R/f9z
kv3/cZH9/3CO/f9vjf3/bYv9/22L/f9siv3/a4n9/2qH/f9phv3/aob8/2iC/P9ngfz/ZX78/2J8
/P9hefz/X3f8/1xy/P9Zcfz/WHD9/0NB7P86Nfj/o73//3CT/v91lv3/dJX9/3OS/f9xjv3/cI79
/2+N/f9ti/3/bIn9/2eG/f91j/7/ZYL9/2WD/f9kfvz/Ynz8/2F5/P9gePz/Xnf8/111/P9cc/z/
W3T9/0A37P8vJvjhp7z//3ub/v91l/7/d5j9/3WW/f90lf3/cZH9/3GP/f9vjv3/bIr9/2uL/f+g
tv7/YYD9/2eD/f9mg/3/ZID9/2R+/P9he/z/YHn8/2B4/P9cdvz/ZXr8/zow6+E1Lfp2YWX8/6zF
//9zlf7/dZf+/3aY/v90l/3/c5T9/3CP/f9rjP3/b479/5Ok//+frP7/mLD+/2KB/f9nhf3/ZoT9
/2WC/f9kgP3/YHr8/1t1/P9tiv7/ZGf2/zYv7XYAAAAAMSj65nyK/v+1yv//iaf+/3OV/v9vj/7/
a43+/2OH/f92l/7/oLf//0tG+v9MR/v/qr3+/6C2/v9ti/3/Y4L9/2KC/f9de/3/Y339/4GZ//97
hf3/Mirw5gAAAAAAAAAAAAAAADEo+uhZW/z/m63//7jP//+fvP//nLn//7HL//9+i/7/OTH5/zcw
+k85MfZPPjb6/4eQ/f+3z///qL7//5qz//+ju///kaH//1RW+v8xKPPoAAAAAAAAAAAAAAAAAAAA
AAAAAAA4MPpaMir4zjUt+P9LR/v/TUn7/zEo+f85MPqpQDj7CgAAAAAAAAAAODL6CjYv+qk0Kvn/
TEr5/0pI+v80Lfb/MCj2zjYv9loAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAD///8A/+f/AP/D/wD/gP8A/gB/APwAPwD4AB8A8AAPAPAADwDgAAcAwAAD
AIAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAQDAAAMA4BgHAP///wA=')
	#endregion
	$MainForm.Margin = '4, 4, 4, 4'
	$MainForm.MaximizeBox = $False
	$MainForm.Name = 'MainForm'
	$MainForm.StartPosition = 'CenterScreen'
	$MainForm.Text = 'PEQ Configurator'
	$MainForm.add_Load($MainForm_Load)
	#
	# labelPEQConfiguratorIsDes
	#
	$labelPEQConfiguratorIsDes.Location = '378, 9'
	$labelPEQConfiguratorIsDes.Name = 'labelPEQConfiguratorIsDes'
	$labelPEQConfiguratorIsDes.Size = '205, 264'
	$labelPEQConfiguratorIsDes.TabIndex = 14
	$labelPEQConfiguratorIsDes.Text = 'PEQ Configurator is designed to ease pre-configuration when working with multiple toons and accounts.  

A CSV file is needed along with an install of Everquest, MQ2, and AutoHotKey.  All accounts should be pre-created on http://www.eqemulator.org/.

The CSV creation is a manual step but a sample is supplied to get you started.

PEQ Configurator is provided as-is.  Feel free to modify the code and redistribute as desired.  



Zuboo'
	$labelPEQConfiguratorIsDes.UseCompatibleTextRendering = $True
	#
	# buttonBuildSampleTOONSCSV
	#
	$buttonBuildSampleTOONSCSV.Location = '12, 244'
	$buttonBuildSampleTOONSCSV.Name = 'buttonBuildSampleTOONSCSV'
	$buttonBuildSampleTOONSCSV.Size = '88, 56'
	$buttonBuildSampleTOONSCSV.TabIndex = 13
	$buttonBuildSampleTOONSCSV.Text = 'Build Sample Toons.Csv ...'
	$buttonBuildSampleTOONSCSV.UseCompatibleTextRendering = $True
	$buttonBuildSampleTOONSCSV.UseVisualStyleBackColor = $True
	$buttonBuildSampleTOONSCSV.add_Click($buttonBuildSampleTOONSCSV_Click)
	#
	# labelPEQConfigurator
	#
	$labelPEQConfigurator.AutoSize = $True
	$labelPEQConfigurator.Font = 'Arial Black, 18pt, style=Italic'
	$labelPEQConfigurator.Location = '13, 9'
	$labelPEQConfigurator.Name = 'labelPEQConfigurator'
	$labelPEQConfigurator.Size = '242, 40'
	$labelPEQConfigurator.TabIndex = 12
	$labelPEQConfigurator.Text = 'PEQ Configurator'
	$labelPEQConfigurator.UseCompatibleTextRendering = $True
	#
	# richtextbox1
	#
	$richtextbox1.BackColor = '1, 36, 86'
	$richtextbox1.Font = 'Consolas, 11pt'
	$richtextbox1.Location = '13, 306'
	$richtextbox1.Name = 'richtextbox1'
	$richtextbox1.ReadOnly = $True
	$richtextbox1.Size = '569, 274'
	$richtextbox1.TabIndex = 11
	$richtextbox1.Text = ''
	$richtextbox1.add_LinkClicked($richtextbox1_LinkClicked)
	#
	# buttonBuildMQ2AutoLogin
	#
	$buttonBuildMQ2AutoLogin.Location = '201, 117'
	$buttonBuildMQ2AutoLogin.Name = 'buttonBuildMQ2AutoLogin'
	$buttonBuildMQ2AutoLogin.Size = '88, 56'
	$buttonBuildMQ2AutoLogin.TabIndex = 9
	$buttonBuildMQ2AutoLogin.Text = 'Build MQ2AutoLogin INI'
	$buttonBuildMQ2AutoLogin.UseCompatibleTextRendering = $True
	$buttonBuildMQ2AutoLogin.UseVisualStyleBackColor = $True
	$buttonBuildMQ2AutoLogin.add_Click($buttonBuildMQ2AutoLogin_Click)
	#
	# buttonBuildAutoHotKey
	#
	$buttonBuildAutoHotKey.Location = '107, 117'
	$buttonBuildAutoHotKey.Name = 'buttonBuildAutoHotKey'
	$buttonBuildAutoHotKey.Size = '88, 56'
	$buttonBuildAutoHotKey.TabIndex = 8
	$buttonBuildAutoHotKey.Text = 'Build AutoHotKey Script'
	$buttonBuildAutoHotKey.UseCompatibleTextRendering = $True
	$buttonBuildAutoHotKey.UseVisualStyleBackColor = $True
	$buttonBuildAutoHotKey.add_Click($buttonBuildAutoHotKey_Click)
	#
	# buttonBuildShortcuts
	#
	$buttonBuildShortcuts.Location = '13, 116'
	$buttonBuildShortcuts.Name = 'buttonBuildShortcuts'
	$buttonBuildShortcuts.Size = '88, 56'
	$buttonBuildShortcuts.TabIndex = 7
	$buttonBuildShortcuts.Text = 'Build Shortcuts...'
	$tooltip1.SetToolTip($buttonBuildShortcuts, 'Overwrites any previous shortcuts!')
	$buttonBuildShortcuts.UseCompatibleTextRendering = $True
	$buttonBuildShortcuts.UseVisualStyleBackColor = $True
	$buttonBuildShortcuts.add_Click($buttonBuildShortcuts_Click)
	#
	# labelToonsCsvLocation
	#
	$labelToonsCsvLocation.AutoSize = $True
	$labelToonsCsvLocation.Location = '13, 70'
	$labelToonsCsvLocation.Name = 'labelToonsCsvLocation'
	$labelToonsCsvLocation.Size = '117, 17'
	$labelToonsCsvLocation.TabIndex = 6
	$labelToonsCsvLocation.Text = 'TOONS.CSV Location'
	$labelToonsCsvLocation.UseCompatibleTextRendering = $True
	#
	# buttonBrowse
	#
	$buttonBrowse.Location = '295, 90'
	$buttonBrowse.Name = 'buttonBrowse'
	$buttonBrowse.Size = '30, 23'
	$buttonBrowse.TabIndex = 1
	$buttonBrowse.Text = '...'
	$buttonBrowse.UseCompatibleTextRendering = $True
	$buttonBrowse.UseVisualStyleBackColor = $True
	$buttonBrowse.add_Click($buttonBrowse_Click)
	#
	# toonsFile
	#
	$toonsFile.AutoCompleteMode = 'SuggestAppend'
	$toonsFile.AutoCompleteSource = 'FileSystem'
	$toonsFile.Location = '13, 90'
	$toonsFile.Name = 'toonsFile'
	$toonsFile.Size = '276, 20'
	$toonsFile.TabIndex = 0
	$toonsFile.add_TextChanged($toonsFile_TextChanged)
	#
	# folderbrowserdialog1
	#
	#
	# openfiledialog1
	#
	$openfiledialog1.DefaultExt = 'txt'
	$openfiledialog1.Filter = 'Text File (.txt)|*.txt|All Files|*.*'
	$openfiledialog1.ShowHelp = $True
	#
	# openfiledialog2
	#
	$openfiledialog2.DefaultExt = 'txt'
	$openfiledialog2.Filter = 'Text File (.txt)|*.txt|All Files|*.*'
	$openfiledialog2.ShowHelp = $True
	#
	# openfiledialog3
	#
	$openfiledialog3.DefaultExt = 'txt'
	$openfiledialog3.Filter = 'Text File (.txt)|*.txt|All Files|*.*'
	$openfiledialog3.ShowHelp = $True
	#
	# openfiledialog4
	#
	$openfiledialog4.DefaultExt = 'txt'
	$openfiledialog4.Filter = 'Text File (.txt)|*.txt|All Files|*.*'
	$openfiledialog4.ShowHelp = $True
	#
	# tooltip1
	#
	#
	# folderbrowserdialog2
	#
	#
	# folderbrowserdialog3
	#
	#
	# savefiledialog1
	#
	$MainForm.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $MainForm.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$MainForm.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$MainForm.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$MainForm.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $MainForm.ShowDialog()

}
#endregion Source: MainForm.psf

#region Source: Globals.ps1
	#--------------------------------------------
	# Declare Global Variables and Functions here
	#--------------------------------------------
	
	
	#Sample function that provides the location of the script
	function Get-ScriptDirectory
	{
	<#
		.SYNOPSIS
			Get-ScriptDirectory returns the proper location of the script.
	
		.OUTPUTS
			System.String
		
		.NOTES
			Returns the correct path within a packaged executable.
	#>
		[OutputType([string])]
		param ()
		if ($null -ne $hostinvocation)
		{
			Split-Path $hostinvocation.MyCommand.path
		}
		else
		{
			Split-Path $script:MyInvocation.MyCommand.Path
		}
	}
	
	#Sample variable that provides the location of the script
	[string]$ScriptDirectory = Get-ScriptDirectory
	
	#region buttonup
	function buttonup
	{
		$this.Cursor = 'Default'
		$this.Enabled = $true
	}
	#endregion buttonup
	
	#region buttondown
	function buttondown
	{
		$this.Cursor = 'WaitCursor'
		$this.Enabled = $false
	}
	#endregion buttondown
	
	#region Update-Display
	function Global:Update-Display
	{
		param ($ResultToDisplay,
			$color = '238, 237, 240')
		
		$ResultToDisplay = ($ResultToDisplay | Out-String).replace($null, " ")
		
		$richtextbox1.SelectionColor = $color
		$richtextbox1.appendText($ResultToDisplay)
		#$richtextbox_output.appendText("`n")
	}
	#endregion Update-Display
	
#endregion Source: Globals.ps1

#region Source: ChildForm.psf
function Show-ChildForm_psf
{
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formChildForm = New-Object 'System.Windows.Forms.Form'
	$buttonOK = New-Object 'System.Windows.Forms.Button'
	$buttonCancel = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	
	$formChildForm_Load={
		#TODO: Initialize Form Controls here
		
	}
	
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formChildForm.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$formChildForm.remove_Load($formChildForm_Load)
			$formChildForm.remove_Load($Form_StateCorrection_Load)
			$formChildForm.remove_Closing($Form_StoreValues_Closing)
			$formChildForm.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formChildForm.SuspendLayout()
	#
	# formChildForm
	#
	$formChildForm.Controls.Add($buttonOK)
	$formChildForm.Controls.Add($buttonCancel)
	$formChildForm.AutoScaleDimensions = '6, 13'
	$formChildForm.AutoScaleMode = 'Font'
	$formChildForm.ClientSize = '284, 262'
	$formChildForm.Margin = '4, 4, 4, 4'
	$formChildForm.Name = 'formChildForm'
	$formChildForm.StartPosition = 'CenterParent'
	$formChildForm.Text = 'Child Form'
	$formChildForm.add_Load($formChildForm_Load)
	#
	# buttonOK
	#
	$buttonOK.Anchor = 'Bottom, Right'
	$buttonOK.DialogResult = 'OK'
	$buttonOK.Location = '116, 227'
	$buttonOK.Name = 'buttonOK'
	$buttonOK.Size = '75, 23'
	$buttonOK.TabIndex = 1
	$buttonOK.Text = '&OK'
	$buttonOK.UseCompatibleTextRendering = $True
	$buttonOK.UseVisualStyleBackColor = $True
	#
	# buttonCancel
	#
	$buttonCancel.Anchor = 'Bottom, Right'
	$buttonCancel.CausesValidation = $False
	$buttonCancel.DialogResult = 'Cancel'
	$buttonCancel.Location = '197, 227'
	$buttonCancel.Name = 'buttonCancel'
	$buttonCancel.Size = '75, 23'
	$buttonCancel.TabIndex = 0
	$buttonCancel.Text = '&Cancel'
	$buttonCancel.UseCompatibleTextRendering = $True
	$buttonCancel.UseVisualStyleBackColor = $True
	$formChildForm.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formChildForm.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formChildForm.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formChildForm.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$formChildForm.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $formChildForm.ShowDialog()

}
#endregion Source: ChildForm.psf

#Start the application
Main ($CommandLine)
