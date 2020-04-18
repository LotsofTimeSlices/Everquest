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

$TextCSV = 'C:\EXAMPLE\RoF2\Toons.csv'
$TextINI = 'C:\EXAMPLE\RoF2\E3_RoF2\Macros\e3 Macro Inis\Saved Groups.ini'
$RegCheckToonsCSV = Get-ItemProperty -Path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch | Select-Object -ExpandProperty 'Toons.csv' -ErrorAction SilentlyContinue
$RegCheckSavedGroupsINI = Get-ItemProperty -Path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch | Select-Object -ExpandProperty 'SavedGroups.ini' -ErrorAction SilentlyContinue

#region Load-CSV
if ($RegCheckToonsCSV)
{
	$CSV = Import-Csv $RegCheckToonsCSV | Sort-Object Class
	$Classes = $CSV | Select-Object Character, Class | Group-Object -Property Class -AsHashTable #Group by classes
}
#endregion Load-CSV

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
	$listview1.Sorting = 'Ascending'
}

function Set-Descending
{
	$listview1.View = 'List'
	$listview1.Sorting = 'Descending'
}

function Set-Grouped
{
	$listview1.View = 'SmallIcon'
}

function Set-Class
{
	$listview1.View = 'SmallIcon'
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

function Set-TrayIcon
{
	$showTrayIconToolStripMenuItem.Checked = $true
	$EQSwitch.Visible = $true
}

function Set-AlwaysOnTop
{
	$alwaysOnTopToolStripMenuItem.Checked = $true
	$formEQSwitch.TopMost = $true
}

function Set-SavedOrder
{
	$SavedOrder = Get-ItemProperty -Path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch | Select-Object -ExpandProperty ListViewOrder -ErrorAction SilentlyContinue
	$SortItems = $sortToolStripMenuItem.DropDown.Items | Where-Object { $_ -notmatch $toolstripseparator1 }
	foreach ($item in $SortItems) #Check the item which is set in the registry
	{
		if ($SavedOrder -ceq $item) #Case sensitive exact match
		{
			$item.Checked = $true
		}
		else
		{
			$item.Checked = $false
		}
	}	
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
	$Script:RunningEQTitles = $RunningEQ.MainWindowTitle
	$textbox1.AutoCompleteCustomSource.AddRange($RunningEQTitles)
	$labelRunningEQInstances.Text = "EQ Count:  $($RunningEQTitles.Count)"
	Set-SavedOrder
	
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
	elseif ($SavedOrder -eq 'Class')
	{
		Set-Class
		$Classes = @(foreach ($c in $csv)
			{
				[PSCustomObject] @{
					Character = $c.Character
					Class	  = $c.Class
				}
			})
		$Classes = $Classes | Sort-Object Class, Character
		foreach ($c in $Classes)
		{
			if ($c.Character -ne '' -and $RunningEQTitles -contains $c.Character)
			{
				Add-ListViewItem -ListView $listview1 -Items $($c.Character) -Group $($c.Class)
			}
		}
	}
	else #Grouped
	{
		Set-Grouped
		$selected = $SavedOrder #Whatever is clicked on
		$selection = $INIcontent.keys -match $selected
		$selectionCount = $selection.Count
		$num = 0
		$members = @(foreach ($s in $selection)
			{
				$icount = 0 .. 5
				foreach ($i in $icount)
				{
					$GM = 'GroupMember' + $i
					$Gmember = 'GroupMember#' + $i
					$GroupName = $Selected + $num
					[PSCustomObject] @{
						GroupName   = $GroupName
						#GroupMember = if ($INIcontent.$s.$Gmember -ne 'DEPRECATED') { $INIcontent.$s.$Gmember }
						GroupMember = $INIcontent.$s.$Gmember
					}
				}
				$num++
			})
		
		foreach ($m in $members)
		{
			if ($m.GroupMember -ne '' -and $RunningEQTitles -contains $m.GroupMember)
			{
				Add-ListViewItem -ListView $listview1 -Items $($m.GroupMember) -Group $($m.GroupName)
			}			
		}		
	}
}
#endregion Start-Refresh

#region Get-IniContent
function Get-IniContent ($filePath)
{
	$ini = [ordered]@{ } #[ordered] required to load as listed in file
	switch -regex -file $FilePath
	{
		"^\[(.+)\]" # Section
		{
			$section = $matches[1]
			$ini[$section] = @{ }
			$CommentCount = 0
		}
		"^(;.*)$" # Comment
		{
			$value = $matches[1]
			$CommentCount = $CommentCount + 1
			$name = "Comment" + $CommentCount
			$ini[$section][$name] = $value
		}
		"(.+?)\s*=(.*)" # Key
		{
			$name, $value = $matches[1 .. 2]
			$ini[$section][$name] = $value
		}
	}
	return $ini
}
#endregion Get-IniContent

#region Get-GroupedFromIni
function Get-GroupedFromIni
{
	$INIcontent = Get-IniContent -filePath $RegCheckSavedGroupsINI
	$keys = @(foreach ($i in $INIcontent.Keys)
		{
			$key = $i -split '_'
			[PSCustomObject][ordered]@{
				Group = $key[1]
			}
		})
	$uniqueGroups = $keys.group | Select-Object -Unique
	if ($uniqueGroups)
	{
		$sortToolStripMenuItem.DropDown.Items.Add("-") #Seperator line
	}
	foreach ($u in $uniqueGroups) #Add to dropdown menustrip
	{
		$sortToolStripMenuItem.DropDownItems.Add($u)
	}
}
#endregion Get-GroupedFromIni

#region add_Click
function Add-Click #adds dynamic add_click events for menustrip
{
	$SortItems = $sortToolStripMenuItem.DropDown.Items | Where-Object { $_ -notmatch $toolstripseparator1 }
	foreach ($item in $SortItems)
	{
		$item.add_Click(
			{			
				Set-ItemProperty -Path Registry::HKEY_CURRENT_USER\SOFTWARE\EQSwitch -Name ListViewOrder -Value $this
				Set-SavedOrder
				Start-Refresh
			}
		)
	}
}
#endregion add_Click

#region Get-GroupedIniRefresh
$INIcontent = Get-IniContent -filePath $RegCheckSavedGroupsINI
$keys = @(foreach ($i in $INIcontent.Keys)
	{
		$key = $i -split '_'
		[PSCustomObject][ordered]@{
			Group = $key[1]
		}
	})
#endregion Get-GroupedIniRefresh
