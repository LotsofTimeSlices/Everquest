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

#region Get-IniContent
function Get-IniContent ($filePath)
{
	$ini = @{ }
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

#region Out-IniFile
Function Out-IniFile
{
    <#  
    .Synopsis  
        Write hash content to INI file  
          
    .Description  
        Write hash content to INI file  
          
    .Notes  
        Author        : Oliver Lipkau <oliver@lipkau.net>  
        Blog        : http://oliver.lipkau.net/blog/  
        Source        : https://github.com/lipkau/PsIni 
                      http://gallery.technet.microsoft.com/scriptcenter/ea40c1ef-c856-434b-b8fb-ebd7a76e8d91 
        Version        : 1.0 - 2010/03/12 - Initial release  
                      1.1 - 2012/04/19 - Bugfix/Added example to help (Thx Ingmar Verheij)  
                      1.2 - 2014/12/11 - Improved handling for missing output file (Thx SLDR) 
          
        #Requires -Version 2.0  
          
    .Inputs  
        System.String  
        System.Collections.Hashtable  
          
    .Outputs  
        System.IO.FileSystemInfo  
          
    .Parameter Append  
        Adds the output to the end of an existing file, instead of replacing the file contents.  
          
    .Parameter InputObject  
        Specifies the Hashtable to be written to the file. Enter a variable that contains the objects or type a command or expression that gets the objects.  
  
    .Parameter FilePath  
        Specifies the path to the output file.  
       
     .Parameter Encoding  
        Specifies the type of character encoding used in the file. Valid values are "Unicode", "UTF7",  
         "UTF8", "UTF32", "ASCII", "BigEndianUnicode", "Default", and "OEM". "Unicode" is the default.  
          
        "Default" uses the encoding of the system's current ANSI code page.   
          
        "OEM" uses the current original equipment manufacturer code page identifier for the operating   
        system.  
       
     .Parameter Force  
        Allows the cmdlet to overwrite an existing read-only file. Even using the Force parameter, the cmdlet cannot override security restrictions.  
          
     .Parameter PassThru  
        Passes an object representing the location to the pipeline. By default, this cmdlet does not generate any output.  
                  
    .Example  
        Out-IniFile $IniVar "C:\myinifile.ini"  
        -----------  
        Description  
        Saves the content of the $IniVar Hashtable to the INI File c:\myinifile.ini  
          
    .Example  
        $IniVar | Out-IniFile "C:\myinifile.ini" -Force  
        -----------  
        Description  
        Saves the content of the $IniVar Hashtable to the INI File c:\myinifile.ini and overwrites the file if it is already present  
          
    .Example  
        $file = Out-IniFile $IniVar "C:\myinifile.ini" -PassThru  
        -----------  
        Description  
        Saves the content of the $IniVar Hashtable to the INI File c:\myinifile.ini and saves the file into $file  
  
    .Example  
        $Category1 = @{"Key1"="Value1";"Key2"="Value2"}  
    $Category2 = @{"Key1"="Value1";"Key2"="Value2"}  
    $NewINIContent = @{"Category1"=$Category1;"Category2"=$Category2}  
    Out-IniFile -InputObject $NewINIContent -FilePath "C:\MyNewFile.INI"  
        -----------  
        Description  
        Creating a custom Hashtable and saving it to C:\MyNewFile.INI  
    .Link  
        Get-IniContent  
    #>	
	
	[CmdletBinding()]
	Param (
		[switch]$Append,
		[ValidateSet("Unicode", "UTF7", "UTF8", "UTF32", "ASCII", "BigEndianUnicode", "Default", "OEM")]
		[Parameter()]
		[string]$Encoding = "Unicode",
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^([a-zA-Z]\:)?.+\.ini$')]
		[Parameter(Mandatory = $True)]
		[string]$FilePath,
		[switch]$Force,
		[ValidateNotNullOrEmpty()]
		[Parameter(ValueFromPipeline = $True, Mandatory = $True)]
		[Hashtable]$InputObject,
		[switch]$Passthru
	)
	
	Begin
	{ Write-Verbose "$($MyInvocation.MyCommand.Name):: Function started" }
	
	Process
	{
		Write-Verbose "$($MyInvocation.MyCommand.Name):: Writing to file: $Filepath"
		
		if ($append) { $outfile = Get-Item $FilePath }
		else { $outFile = New-Item -ItemType file -Path $Filepath -Force:$Force }
		if (!($outFile)) { Throw "Could not create File" }
		foreach ($i in $InputObject.keys)
		{
			if (!($($InputObject[$i].GetType().Name) -eq "Hashtable"))
			{
				#No Sections  
				Write-Verbose "$($MyInvocation.MyCommand.Name):: Writing key: $i"
				Add-Content -Path $outFile -Value "$i=$($InputObject[$i])" -Encoding $Encoding
			}
			else
			{
				#Sections  
				Write-Verbose "$($MyInvocation.MyCommand.Name):: Writing Section: [$i]"
				Add-Content -Path $outFile -Value "[$i]" -Encoding $Encoding
				Foreach ($j in $($InputObject[$i].keys | Sort-Object))
				{
					if ($j -match "^Comment[\d]+")
					{
						Write-Verbose "$($MyInvocation.MyCommand.Name):: Writing comment: $j"
						Add-Content -Path $outFile -Value "$($InputObject[$i][$j])" -Encoding $Encoding
					}
					else
					{
						Write-Verbose "$($MyInvocation.MyCommand.Name):: Writing key: $j"
						Add-Content -Path $outFile -Value "$j=$($InputObject[$i][$j])" -Encoding $Encoding
					}
					
				}
				Add-Content -Path $outFile -Value "" -Encoding $Encoding
			}
		}
		Write-Verbose "$($MyInvocation.MyCommand.Name):: Finished Writing to file: $path"
		if ($PassThru) { Return $outFile }
	}
	
	End
	{ Write-Verbose "$($MyInvocation.MyCommand.Name):: Function ended" }
}
#endregion Out-IniFile

#region button-check
function button-check
{
	if (($toonsFile.Text -ne '') -and ($ShortcutsFolder.Text -ne ''))
	{
		$buttonBuildShortcuts.Enabled = $true
		$buttonBuildAutoHotKey.Enabled = $true
		$buttonBuildMQ2AutoLogin.Enabled = $true
		$buttonStartMissingToons.Enabled = $true
	}
	elseif (($toonsFile.Text -ne '') -and ($ShortcutsFolder.Text -eq ''))
	{
		$buttonBuildShortcuts.Enabled = $false
		$buttonBuildAutoHotKey.Enabled = $false
		$buttonBuildMQ2AutoLogin.Enabled = $true
		$buttonStartMissingToons.Enabled = $false
	}
	elseif (($toonsFile.Text -eq '') -and ($ShortcutsFolder.Text -ne ''))
	{
		$buttonBuildShortcuts.Enabled = $false
		$buttonBuildAutoHotKey.Enabled = $false
		$buttonBuildMQ2AutoLogin.Enabled = $false
		$buttonStartMissingToons.Enabled = $true
		$buttonCheckForHungKickedPr.Enabled = $true
	}
	else
	{
		$buttonBuildShortcuts.Enabled = $false
		$buttonBuildAutoHotKey.Enabled = $false
		$buttonBuildMQ2AutoLogin.Enabled = $false
		$buttonStartMissingToons.Enabled = $false
		$buttonCheckForHungKickedPr.Enabled = $false
		
	}
	if ($EQBCSFile.Text -ne '')
	{
		$buttonFlagCheck.Enabled = $true
	}
	else
	{
		$buttonFlagCheck.Enabled = $false
	}
	
}
#endregion button-check

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

function Show-EQBCSHelp
{
	Update-Display 'EQBCS Logging is required to use this feature.' -color 'Orange'
	Update-Display 'Logs are wiped each time EQBCS is launched.' -color 'Orange'
	Update-Display 'To enable logging, add [-l filename] to your EQBCS2.EXE shortcut - Example: ' -color 'Orange'
	Update-Display 'EQBCS2.exe -l EQBCS2Log.txt' -color 'LimeGreen'
}

function Show-ShortcutsHelp
{
	Update-Display 'Shortcuts Folder Location required to use this feature' -color 'Orange'
}

function Show-ToonsHelp
{
	Update-Display 'Toons.CSV Location required to use this feature' -color 'Orange'
}

