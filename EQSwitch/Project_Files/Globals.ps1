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

#region Show-Process
#https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/bringing-window-in-the-foreground
function Show-Process($Process, [Switch]$Maximize)
{
	$sig = '
    [DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern int SetForegroundWindow(IntPtr hwnd);
  '
	
	if ($Maximize) { $Mode = 3 }
	else { $Mode = 4 }
	$type = Add-Type -MemberDefinition $sig -Name WindowAPI -PassThru
	$hwnd = $process.MainWindowHandle
	$null = $type::ShowWindowAsync($hwnd, $Mode)
	$null = $type::SetForegroundWindow($hwnd)
}
#endregion Show-Process

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

#region Set-FormSize
function Set-FormSize
{
	if ($formEQSwitch.WindowState -ne 'Minimized')
	{
		if (Test-Path -Path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch)
		{
			Set-ItemProperty -path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch -Name FormWidth -Value $formEQSwitch.Width #set FormWidth
			Set-ItemProperty -path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch -Name FormHeight -Value $formEQSwitch.Height #set FormHeight
		}
	}
}
#endregion Set-FormSize

#region Set-FormPosition
function Set-FormPosition
{
	if ($formEQSwitch.WindowState -ne 'Minimized')
	{
		if (Test-Path -Path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch)
		{
			#Must use string with a negative number
			Set-ItemProperty -path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch -Name FormPositionX -Value $formEQSwitch.Location.X -Type String #set FormPosition X
			Set-ItemProperty -path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch -Name FormPositionY -Value $formEQSwitch.Location.y -Type String #set FormPosition Y
		}
	}
	
}
#endregion Set-FormPosition

#region Set-ToolMenuOptions
function Set-Ascending
{
	$listview1.View = 'List'
	$AscendingToolStripMenuItem.Checked = $true
	$DescendingToolStripMenuItem.Checked = $false
	$groupedToolStripMenuItem.Checked = $false
	$classToolStripMenuItem.Checked = $false
	$listview1.Sorting = 'Ascending'
}

function Set-Descending
{
	$listview1.View = 'List'
	$AscendingToolStripMenuItem.Checked = $false
	$DescendingToolStripMenuItem.Checked = $true
	$groupedToolStripMenuItem.Checked = $false
	$classToolStripMenuItem.Checked = $false
	$listview1.Sorting = 'Descending'
}

function Set-Grouped
{
	$listview1.View = 'SmallIcon'
	$AscendingToolStripMenuItem.Checked = $false
	$DescendingToolStripMenuItem.Checked = $false
	$groupedToolStripMenuItem.Checked = $true
	$classToolStripMenuItem.Checked = $false
}

function Set-Class
{
	$listview1.View = 'SmallIcon'
	$AscendingToolStripMenuItem.Checked = $false
	$DescendingToolStripMenuItem.Checked = $false
	$groupedToolStripMenuItem.Checked = $false
	$classToolStripMenuItem.Checked = $true
}

function Set-SmallFont
{
	$smallToolStripMenuItem.Checked = $true
	$mediumToolStripMenuItem.Checked = $false
	$largeToolStripMenuItem.Checked = $false
	$extraLargeToolStripMenuItem.Checked = $false
	$textbox1.Font = 'Microsoft Sans Serif, 7pt'
	$listview1.Font = 'Microsoft Sans Serif, 7pt'
}

function Set-MediumFont
{
	$smallToolStripMenuItem.Checked = $false
	$mediumToolStripMenuItem.Checked = $true
	$largeToolStripMenuItem.Checked = $false
	$extraLargeToolStripMenuItem.Checked = $false
	$textbox1.Font = 'Microsoft Sans Serif, 9pt'
	$listview1.Font = 'Microsoft Sans Serif, 9pt'
}

function Set-LargeFont
{
	$smallToolStripMenuItem.Checked = $false
	$mediumToolStripMenuItem.Checked = $false
	$largeToolStripMenuItem.Checked = $true
	$extraLargeToolStripMenuItem.Checked = $false
	$textbox1.Font = 'Microsoft Sans Serif, 11pt'
	$listview1.Font = 'Microsoft Sans Serif, 11pt'
}

function Set-ExtraLargeFont
{
	$smallToolStripMenuItem.Checked = $false
	$mediumToolStripMenuItem.Checked = $false
	$largeToolStripMenuItem.Checked = $false
	$extraLargeToolStripMenuItem.Checked = $true
	$textbox1.Font = 'Microsoft Sans Serif, 13pt'
	$listview1.Font = 'Microsoft Sans Serif, 13pt'
}

function Set-AutoComplete
{
	$autoCompleteSuggestAppendToolStripMenuItem.Checked = $true
	$textbox1.AutoCompleteMode = 'SuggestAppend'
}

#endregion Set-ToolMenuOptions

#region Show-MsgBox
function script:Show-MsgBox
{
	
	[CmdletBinding()]
	param (
		[Parameter(Position = 0, Mandatory = $true)]
		[string]$Prompt,
		[Parameter(Position = 1, Mandatory = $false)]
		[string]$Title = "",
		[Parameter(Position = 2, Mandatory = $false)]
		[ValidateSet("Information", "Question", "Critical", "Exclamation")]
		[string]$Icon = "Information",
		[Parameter(Position = 3, Mandatory = $false)]
		[ValidateSet("OKOnly", "OKCancel", "AbortRetryIgnore", "YesNoCancel", "YesNo", "RetryCancel")]
		[string]$BoxType = "OkOnly",
		[Parameter(Position = 4, Mandatory = $false)]
		[ValidateSet(1, 2, 3)]
		[int]$DefaultButton = 1
	)
	[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic") | Out-Null
	switch ($Icon)
	{
		"Question" { $vb_icon = [microsoft.visualbasic.msgboxstyle]::Question }
		"Critical" { $vb_icon = [microsoft.visualbasic.msgboxstyle]::Critical }
		"Exclamation" { $vb_icon = [microsoft.visualbasic.msgboxstyle]::Exclamation }
		"Information" { $vb_icon = [microsoft.visualbasic.msgboxstyle]::Information }
	}
	switch ($BoxType)
	{
		"OKOnly" { $vb_box = [microsoft.visualbasic.msgboxstyle]::OKOnly }
		"OKCancel" { $vb_box = [microsoft.visualbasic.msgboxstyle]::OkCancel }
		"AbortRetryIgnore" { $vb_box = [microsoft.visualbasic.msgboxstyle]::AbortRetryIgnore }
		"YesNoCancel" { $vb_box = [microsoft.visualbasic.msgboxstyle]::YesNoCancel }
		"YesNo" { $vb_box = [microsoft.visualbasic.msgboxstyle]::YesNo }
		"RetryCancel" { $vb_box = [microsoft.visualbasic.msgboxstyle]::RetryCancel }
	}
	switch ($Defaultbutton)
	{
		1 { $vb_defaultbutton = [microsoft.visualbasic.msgboxstyle]::DefaultButton1 }
		2 { $vb_defaultbutton = [microsoft.visualbasic.msgboxstyle]::DefaultButton2 }
		3 { $vb_defaultbutton = [microsoft.visualbasic.msgboxstyle]::DefaultButton3 }
	}
	$popuptype = $vb_icon -bor $vb_box -bor $vb_defaultbutton
	$ans = [Microsoft.VisualBasic.Interaction]::MsgBox($prompt, $popuptype, $title)
	return $ans
}
#endregion Show-MsgBox

#region Start-Refresh
function Start-Refresh
{
	$listview1.Clear()
	$textbox1.Clear()
	$SavedOrder = Get-ItemProperty -Path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch | Select-Object -ExpandProperty ListViewOrder -ErrorAction SilentlyContinue
	$Script:RunningEQ = get-process -Name eqgame
	$unique = $RunningEQ | Select-Object -Property MainWindowTitle -Unique
	<#
	if ($RunningEQ.count -eq $unique) #check for duplicate process names
	{
		$ContainsDuplicates = $false
		$Script:RunningEQTitles = $RunningEQ.MainWindowTitle
	}
	else
	{
		$ContainsDuplicates = $true
		$list = @()
		foreach ($r in $RunningEQ)
		{			
			$list += [PSCUSTOMOBJECT] @{
				Name = $r.MainWindowTitle
				ID   = $r.Id
			}			
		}		
	}#>
	$Script:RunningEQTitles = $RunningEQ.MainWindowTitle
	$textbox1.AutoCompleteCustomSource.AddRange($RunningEQTitles)
	$labelRunningEQInstances.Text = "EQ Count:  $($RunningEQTitles.Count)"
	#$maxlength = ($RunningEQTitles | Measure-Object -Maximum -Property Length).Maximum
	if (($SavedOrder -eq $null) -or ($SavedOrder -eq 'Ascending'))
	{
		Set-Ascending
		Add-ListViewItem -ListView $listview1 -Items $RunningEQTitles
	}
	elseif ($SavedOrder -eq 'Descending')
	{
		Set-Descending
		Add-ListViewItem -ListView $listview1 -Items $RunningEQTitles
	}
	elseif ($SavedOrder -eq 'Grouped')
	{
		Set-Grouped #Set listview to $listview1.View = 'SmallIcon'		
		$12count = 1 .. 12
		$Groups = @(foreach ($count in $12count) #Get saved groups
			{
				$GroupCount = "Group" + $Count
				$groupmembers = Get-ItemProperty -Path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch | Select-Object -ExpandProperty $GroupCount -ErrorAction SilentlyContinue
				foreach ($g in $groupmembers)
				{
					[PSCustomObject] @{
						Group = "Group$count"
						Toon  = $g
					}
				}
			})
		
		foreach ($group in $groups) #Add items to list view
		{
			foreach ($g in $group)
			{
				if ($g.Toon -ne '' -and $RunningEQTitles -contains $g.Toon)
				{
					Add-ListViewItem -ListView $listview1 -Items $($g.Toon) -Group $($g.Group)
				}				
			}
		}
	}
	elseif ($SavedOrder -eq 'Class')
	{
		Set-Class #Set listview to $listview1.View = 'SmallIcon'
		$RegItems = Get-Item -Path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch -ErrorAction SilentlyContinue
		$RegClasses = $RegItems.Property | Where-Object { $_ -match 'Class' } -ErrorAction SilentlyContinue		
		$Classes = @(foreach ($RegClass in $RegClasses) #Get saved classes
			{
				$ClassMembers = Get-ItemProperty -Path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch | Select-Object -ExpandProperty $RegClass -ErrorAction SilentlyContinue
				foreach ($c in $ClassMembers)
				{
					[PSCustomObject] @{
						Class = $RegClass.Replace('Class-', '')
						Toon  = $c
					}
				}
			})
		$Classes = $Classes | Sort-Object Class
		foreach ($Class in $Classes) #Add items to list view
		{
			foreach ($c in $Class)
			{
				if ($c.Toon -ne '' -and $RunningEQTitles -contains $c.Toon)
				{					
					Add-ListViewItem -ListView $listview1 -Items $($c.Toon) -Group $($c.Class)
				}
			}
		}
	}
}
#endregion Start-Refresh


#region Button-Check
function Button-Check
{
	if ($textboxFile.Text -ne '')
	{
		$buttonImportCSVAndUpdate.Enabled = $true
		$buttonImportCSVAndExportGr.Enabled = $true
	}
	else
	{
		$buttonImportCSVAndUpdate.Enabled = $false
		$buttonImportCSVAndExportGr.Enabled = $false
	}
}
#endregion Button-Check

function Make-Sound
{	
	[console]::beep(1750, 100)
	[console]::beep(1050, 100)
	[console]::beep(500, 100)	
}