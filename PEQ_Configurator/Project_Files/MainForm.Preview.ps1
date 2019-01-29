#----------------------------------------------
# Generated Form Function
#----------------------------------------------
function Show-MainForm_psf {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Design, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$MainForm = New-Object 'System.Windows.Forms.Form'
	$groupbox2 = New-Object 'System.Windows.Forms.GroupBox'
	$listview1 = New-Object 'System.Windows.Forms.ListView'
	$textbox1 = New-Object 'System.Windows.Forms.TextBox'
	$buttonQuickSwitchRefresh = New-Object 'System.Windows.Forms.Button'
	$buttonSaveAsDefaultLocatio = New-Object 'System.Windows.Forms.Button'
	$buttonBrowseFolder = New-Object 'System.Windows.Forms.Button'
	$ShortcutsFolder = New-Object 'System.Windows.Forms.TextBox'
	$labelShortcutsLocation = New-Object 'System.Windows.Forms.Label'
	$buttonBuildSampleTOONSCSV = New-Object 'System.Windows.Forms.Button'
	$labelPEQConfigurator = New-Object 'System.Windows.Forms.Label'
	$richtextbox1 = New-Object 'System.Windows.Forms.RichTextBox'
	$buttonBuildMQ2AutoLogin = New-Object 'System.Windows.Forms.Button'
	$buttonBuildAutoHotKey = New-Object 'System.Windows.Forms.Button'
	$buttonBuildShortcuts = New-Object 'System.Windows.Forms.Button'
	$labelToonsCsvLocation = New-Object 'System.Windows.Forms.Label'
	$buttonBrowse = New-Object 'System.Windows.Forms.Button'
	$toonsFile = New-Object 'System.Windows.Forms.TextBox'
	$menustrip1 = New-Object 'System.Windows.Forms.MenuStrip'
	$groupbox1 = New-Object 'System.Windows.Forms.GroupBox'
	$tabcontrol1 = New-Object 'System.Windows.Forms.TabControl'
	$tabpage1 = New-Object 'System.Windows.Forms.TabPage'
	$textbox2 = New-Object 'System.Windows.Forms.TextBox'
	$buttonEQProcessMonitor = New-Object 'System.Windows.Forms.Button'
	$buttonCheckForHungKickedPr = New-Object 'System.Windows.Forms.Button'
	$buttonEQCPUAffinity = New-Object 'System.Windows.Forms.Button'
	$buttonKillAllEQWindows = New-Object 'System.Windows.Forms.Button'
	$buttonstartMissingToons = New-Object 'System.Windows.Forms.Button'
	$tabpage2 = New-Object 'System.Windows.Forms.TabPage'
	$combobox1 = New-Object 'System.Windows.Forms.ComboBox'
	$buttonTaskbarGroupingFix = New-Object 'System.Windows.Forms.Button'
	$buttonEQClientiniReadOnly = New-Object 'System.Windows.Forms.Button'
	$CPU = New-Object 'System.Windows.Forms.GroupBox'
	$labelLogicalProcessors = New-Object 'System.Windows.Forms.Label'
	$labelCores = New-Object 'System.Windows.Forms.Label'
	$labelCPUName = New-Object 'System.Windows.Forms.Label'
	$folderbrowserdialog1 = New-Object 'System.Windows.Forms.FolderBrowserDialog'
	$openfiledialog1 = New-Object 'System.Windows.Forms.OpenFileDialog'
	$openfiledialog2 = New-Object 'System.Windows.Forms.OpenFileDialog'
	$openfiledialog3 = New-Object 'System.Windows.Forms.OpenFileDialog'
	$openfiledialog4 = New-Object 'System.Windows.Forms.OpenFileDialog'
	$tooltip1 = New-Object 'System.Windows.Forms.ToolTip'
	$folderbrowserdialog2 = New-Object 'System.Windows.Forms.FolderBrowserDialog'
	$folderbrowserdialog3 = New-Object 'System.Windows.Forms.FolderBrowserDialog'
	$savefiledialog1 = New-Object 'System.Windows.Forms.SaveFileDialog'
	$folderbrowserdialog4 = New-Object 'System.Windows.Forms.FolderBrowserDialog'
	$helpToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$aboutToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$MainForm.SuspendLayout()
	$groupbox2.SuspendLayout()
	$menustrip1.SuspendLayout()
	$groupbox1.SuspendLayout()
	$tabcontrol1.SuspendLayout()
	$tabpage1.SuspendLayout()
	$tabpage2.SuspendLayout()
	$CPU.SuspendLayout()
	#
	# MainForm
	#
	$MainForm.Controls.Add($groupbox2)
	$MainForm.Controls.Add($buttonSaveAsDefaultLocatio)
	$MainForm.Controls.Add($buttonBrowseFolder)
	$MainForm.Controls.Add($ShortcutsFolder)
	$MainForm.Controls.Add($labelShortcutsLocation)
	$MainForm.Controls.Add($buttonBuildSampleTOONSCSV)
	$MainForm.Controls.Add($labelPEQConfigurator)
	$MainForm.Controls.Add($richtextbox1)
	$MainForm.Controls.Add($buttonBuildMQ2AutoLogin)
	$MainForm.Controls.Add($buttonBuildAutoHotKey)
	$MainForm.Controls.Add($buttonBuildShortcuts)
	$MainForm.Controls.Add($labelToonsCsvLocation)
	$MainForm.Controls.Add($buttonBrowse)
	$MainForm.Controls.Add($toonsFile)
	$MainForm.Controls.Add($menustrip1)
	$MainForm.Controls.Add($groupbox1)
	$MainForm.AutoScaleDimensions = '6, 13'
	$MainForm.AutoScaleMode = 'Font'
	$MainForm.ClientSize = '899, 701'
	$MainForm.FormBorderStyle = 'FixedSingle'
	$MainForm.MainMenuStrip = $menustrip1
	$MainForm.Margin = '4, 4, 4, 4'
	$MainForm.MaximizeBox = $False
	$MainForm.Name = 'MainForm'
	$MainForm.ShowIcon = $False
	$MainForm.StartPosition = 'CenterScreen'
	$MainForm.Text = 'PEQ Configurator'
	$MainForm.add_Load($MainForm_Load)
	#
	# groupbox2
	#
	$groupbox2.Controls.Add($listview1)
	$groupbox2.Controls.Add($textbox1)
	$groupbox2.Controls.Add($buttonQuickSwitchRefresh)
	$groupbox2.Location = '670, 27'
	$groupbox2.Name = 'groupbox2'
	$groupbox2.Size = '212, 662'
	$groupbox2.TabIndex = 24
	$groupbox2.TabStop = $False
	$groupbox2.UseCompatibleTextRendering = $True
	#
	# listview1
	#
	$listview1.Activation = 'OneClick'
	$listview1.BackColor = 'Info'
	$listview1.Font = 'Microsoft Sans Serif, 9pt'
	$listview1.HotTracking = $True
	$listview1.HoverSelection = $True
	$listview1.Location = '17, 62'
	$listview1.MultiSelect = $False
	$listview1.Name = 'listview1'
	$listview1.Size = '182, 589'
	$listview1.Sorting = 'Ascending'
	$listview1.TabIndex = 25
	$listview1.UseCompatibleStateImageBehavior = $False
	$listview1.View = 'List'
	$listview1.add_Click($listview1_Click)
	#
	# textbox1
	#
	$textbox1.AutoCompleteMode = 'Append'
	$textbox1.AutoCompleteSource = 'CustomSource'
	$textbox1.BackColor = 'Info'
	$textbox1.Location = '17, 36'
	$textbox1.Name = 'textbox1'
	$textbox1.Size = '182, 20'
	$textbox1.TabIndex = 3
	$textbox1.add_Click($textbox1_Click)
	$textbox1.add_KeyDown($textbox1_KeyDown)
	#
	# buttonQuickSwitchRefresh
	#
	$buttonQuickSwitchRefresh.Location = '15, 10'
	$buttonQuickSwitchRefresh.Name = 'buttonQuickSwitchRefresh'
	$buttonQuickSwitchRefresh.Size = '184, 23'
	$buttonQuickSwitchRefresh.TabIndex = 2
	$buttonQuickSwitchRefresh.Text = 'Quick Switch Refresh'
	$buttonQuickSwitchRefresh.UseCompatibleTextRendering = $True
	$buttonQuickSwitchRefresh.UseVisualStyleBackColor = $True
	$buttonQuickSwitchRefresh.add_Click($buttonQuickSwitchRefresh_Click)
	#
	# buttonSaveAsDefaultLocatio
	#
	$buttonSaveAsDefaultLocatio.Location = '22, 210'
	$buttonSaveAsDefaultLocatio.Name = 'buttonSaveAsDefaultLocatio'
	$buttonSaveAsDefaultLocatio.Size = '275, 38'
	$buttonSaveAsDefaultLocatio.TabIndex = 19
	$buttonSaveAsDefaultLocatio.Text = 'Save as Default Locations'
	$buttonSaveAsDefaultLocatio.UseCompatibleTextRendering = $True
	$buttonSaveAsDefaultLocatio.UseVisualStyleBackColor = $True
	$buttonSaveAsDefaultLocatio.add_Click($buttonSaveAsDefaultLocatio_Click)
	#
	# buttonBrowseFolder
	#
	$buttonBrowseFolder.Location = '303, 181'
	$buttonBrowseFolder.Name = 'buttonBrowseFolder'
	$buttonBrowseFolder.Size = '30, 23'
	$buttonBrowseFolder.TabIndex = 4
	$buttonBrowseFolder.Text = '...'
	$buttonBrowseFolder.UseCompatibleTextRendering = $True
	$buttonBrowseFolder.UseVisualStyleBackColor = $True
	$buttonBrowseFolder.add_Click($buttonBrowseFolder_Click)
	#
	# ShortcutsFolder
	#
	$ShortcutsFolder.AutoCompleteMode = 'SuggestAppend'
	$ShortcutsFolder.AutoCompleteSource = 'FileSystemDirectories'
	$ShortcutsFolder.BackColor = 'Info'
	$ShortcutsFolder.Location = '21, 184'
	$ShortcutsFolder.Name = 'ShortcutsFolder'
	$ShortcutsFolder.Size = '276, 20'
	$ShortcutsFolder.TabIndex = 3
	$ShortcutsFolder.add_TextChanged($ShortcutsFolder_TextChanged)
	#
	# labelShortcutsLocation
	#
	$labelShortcutsLocation.AutoSize = $True
	$labelShortcutsLocation.Location = '22, 167'
	$labelShortcutsLocation.Name = 'labelShortcutsLocation'
	$labelShortcutsLocation.Size = '98, 17'
	$labelShortcutsLocation.TabIndex = 18
	$labelShortcutsLocation.Text = 'Shortcuts Location'
	$labelShortcutsLocation.UseCompatibleTextRendering = $True
	#
	# buttonBuildSampleTOONSCSV
	#
	$buttonBuildSampleTOONSCSV.Location = '22, 327'
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
	$labelPEQConfigurator.Font = 'Arial Black, 18pt'
	$labelPEQConfigurator.Location = '22, 51'
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
	$richtextbox1.Location = '11, 412'
	$richtextbox1.Name = 'richtextbox1'
	$richtextbox1.ReadOnly = $True
	$richtextbox1.Size = '653, 284'
	$richtextbox1.TabIndex = 11
	$richtextbox1.Text = ''
	$richtextbox1.add_LinkClicked($richtextbox1_LinkClicked)
	#
	# buttonBuildMQ2AutoLogin
	#
	$buttonBuildMQ2AutoLogin.Location = '210, 266'
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
	$buttonBuildAutoHotKey.Location = '116, 266'
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
	$buttonBuildShortcuts.Location = '22, 265'
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
	$labelToonsCsvLocation.Location = '21, 121'
	$labelToonsCsvLocation.Name = 'labelToonsCsvLocation'
	$labelToonsCsvLocation.Size = '117, 17'
	$labelToonsCsvLocation.TabIndex = 6
	$labelToonsCsvLocation.Text = 'TOONS.CSV Location'
	$labelToonsCsvLocation.UseCompatibleTextRendering = $True
	#
	# buttonBrowse
	#
	$buttonBrowse.Location = '303, 138'
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
	$toonsFile.BackColor = 'Info'
	$toonsFile.Location = '21, 138'
	$toonsFile.Name = 'toonsFile'
	$toonsFile.Size = '276, 20'
	$toonsFile.TabIndex = 0
	$toonsFile.add_TextChanged($toonsFile_TextChanged)
	#
	# menustrip1
	#
	[void]$menustrip1.Items.Add($helpToolStripMenuItem)
	$menustrip1.Location = '0, 0'
	$menustrip1.Name = 'menustrip1'
	$menustrip1.Size = '899, 24'
	$menustrip1.TabIndex = 21
	$menustrip1.Text = 'menustrip1'
	#
	# groupbox1
	#
	$groupbox1.Controls.Add($tabcontrol1)
	$groupbox1.Controls.Add($CPU)
	$groupbox1.BackColor = 'Control'
	$groupbox1.Location = '11, 27'
	$groupbox1.Name = 'groupbox1'
	$groupbox1.Size = '653, 380'
	$groupbox1.TabIndex = 23
	$groupbox1.TabStop = $False
	$groupbox1.UseCompatibleTextRendering = $True
	#
	# tabcontrol1
	#
	$tabcontrol1.Controls.Add($tabpage1)
	$tabcontrol1.Controls.Add($tabpage2)
	$tabcontrol1.Location = '343, 10'
	$tabcontrol1.Name = 'tabcontrol1'
	$tabcontrol1.SelectedIndex = 0
	$tabcontrol1.Size = '299, 285'
	$tabcontrol1.TabIndex = 22
	#
	# tabpage1
	#
	$tabpage1.Controls.Add($textbox2)
	$tabpage1.Controls.Add($buttonEQProcessMonitor)
	$tabpage1.Controls.Add($buttonCheckForHungKickedPr)
	$tabpage1.Controls.Add($buttonEQCPUAffinity)
	$tabpage1.Controls.Add($buttonKillAllEQWindows)
	$tabpage1.Controls.Add($buttonstartMissingToons)
	$tabpage1.BackColor = 'Transparent'
	$tabpage1.Location = '4, 22'
	$tabpage1.Name = 'tabpage1'
	$tabpage1.Padding = '3, 3, 3, 3'
	$tabpage1.Size = '291, 259'
	$tabpage1.TabIndex = 0
	$tabpage1.Text = 'Utilities'
	#
	# textbox2
	#
	$textbox2.Location = '104, 86'
	$textbox2.Name = 'textbox2'
	$textbox2.Size = '48, 20'
	$textbox2.TabIndex = 14
	#
	# buttonEQProcessMonitor
	#
	#region Binary Data
	$buttonEQProcessMonitor.Image = [System.Convert]::FromBase64String('
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')
	#endregion
	$buttonEQProcessMonitor.ImageAlign = 'TopCenter'
	$buttonEQProcessMonitor.Location = '103, 6'
	$buttonEQProcessMonitor.Name = 'buttonEQProcessMonitor'
	$buttonEQProcessMonitor.Size = '88, 81'
	$buttonEQProcessMonitor.TabIndex = 13
	$buttonEQProcessMonitor.Text = 'EQ Process Monitor'
	$buttonEQProcessMonitor.TextAlign = 'BottomCenter'
	$tooltip1.SetToolTip($buttonEQProcessMonitor, 'Monitor EQ processes and display a popup if any hang.

Enter custom time in  seconds or Enter for default (30 seconds)')
	$buttonEQProcessMonitor.UseCompatibleTextRendering = $True
	$buttonEQProcessMonitor.UseVisualStyleBackColor = $True
	$buttonEQProcessMonitor.add_Click($buttonEQProcessMonitor_Click)
	#
	# buttonCheckForHungKickedPr
	#
	#region Binary Data
	$buttonCheckForHungKickedPr.Image = [System.Convert]::FromBase64String('
iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABGdBTUEAALGPC/xhBQAAAmJJREFU
SEvVlE1IFGEcxveznZ1dZ2Znv2yTNDO1oENFa8eoIArCDtGhLyNSa0GkMCu/UNfKg0pfaklWh/CQ
1VWKTp0qKoIg6BCxeGhJDXd2Zmdnd/XpXXnbjgXvXvrBw3t4fvz/zDDzmv4F5dDRQaWtBYlLrZg7
H8Hn/QcGacWOfvjYeObBFWSnh5F9PITckxHok1G827svShU2jPYWZKauIvMwWsjS1DXEIidAFTaM
tggyk73ITPQUkrvfh9iZ40VacC4CY7wTxu2OQrJ3uhFrPFKcBenWZhgj7TCGLsAYvgjjegdyYz2Y
PXuySAuaTpPBbWTwZaQ7T0E/GEZmVy1eeUSFKmzojU2v073NSIUroG2QoW0MILu5FM+djjdUYUOr
2/Feq/RBW0eyPgitKohsTSleOrmPVGFDcbpfqBUBqOV/kqsM4qbZ2kUVNhK80K2G/FBX+wpZWuPH
qMXWRxU2yIIuNUAG+70r0fKnV8ao1dZKFTYSvLgtKXuWVVlGPhoZ/kOUcNdqr6UKG4u8aFdEj56U
PMhHJZkTRIMskKjCTqJE+pYUJOSTEj34yrsXJ6x2M63Z+ekSb6huCfkYJR584PhPtCoOcZfojfPi
8qyzBF84F57ZHdtp9Z8w75buLZB3n5K9iAsC3nL8NK3YSTiFhmSAfP/0J0uFfFD8Mm5ZbA1UYUOR
pH6tunTlDvqdHLmLZjiunypsLLrEgVR4LbStZdC2kJBzqa4cj6z2AaqwkeCEsLqpDPruaug7q2Ds
qcYCeYIxsz1MFXa+O4T6uZA/PV8TQizgTT+1rKqn1V8wmX4B4QlJX+nAb7oAAAAASUVORK5CYII=')
	#endregion
	$buttonCheckForHungKickedPr.ImageAlign = 'TopCenter'
	$buttonCheckForHungKickedPr.Location = '7, 100'
	$buttonCheckForHungKickedPr.Name = 'buttonCheckForHungKickedPr'
	$buttonCheckForHungKickedPr.Size = '88, 81'
	$buttonCheckForHungKickedPr.TabIndex = 12
	$buttonCheckForHungKickedPr.Text = 'Check for Hung/Kicked Processes...'
	$buttonCheckForHungKickedPr.TextAlign = 'BottomCenter'
	$tooltip1.SetToolTip($buttonCheckForHungKickedPr, 'Checks for non-responsive process:  EQGAME')
	$buttonCheckForHungKickedPr.UseCompatibleTextRendering = $True
	$buttonCheckForHungKickedPr.UseVisualStyleBackColor = $True
	$buttonCheckForHungKickedPr.add_Click($buttonCheckForHungKickedPr_Click)
	#
	# buttonEQCPUAffinity
	#
	#region Binary Data
	$buttonEQCPUAffinity.Image = [System.Convert]::FromBase64String('
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
fkoYhiD8B3M9CbLmrJUXAAAAAElFTkSuQmCC')
	#endregion
	$buttonEQCPUAffinity.ImageAlign = 'TopCenter'
	$buttonEQCPUAffinity.Location = '197, 6'
	$buttonEQCPUAffinity.Name = 'buttonEQCPUAffinity'
	$buttonEQCPUAffinity.Size = '88, 81'
	$buttonEQCPUAffinity.TabIndex = 8
	$buttonEQCPUAffinity.Text = 'EQ CPU Affinity
'
	$buttonEQCPUAffinity.TextAlign = 'BottomCenter'
	$tooltip1.SetToolTip($buttonEQCPUAffinity, 'Force EQ to all cores')
	$buttonEQCPUAffinity.UseCompatibleTextRendering = $True
	$buttonEQCPUAffinity.UseVisualStyleBackColor = $True
	$buttonEQCPUAffinity.add_Click($buttonEQCPUAffinity_Click)
	#
	# buttonKillAllEQWindows
	#
	#region Binary Data
	$buttonKillAllEQWindows.Image = [System.Convert]::FromBase64String('
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
hyL6FzjJLhSbIZ5LAAAAAElFTkSuQmCC')
	#endregion
	$buttonKillAllEQWindows.ImageAlign = 'TopCenter'
	$buttonKillAllEQWindows.Location = '197, 100'
	$buttonKillAllEQWindows.Name = 'buttonKillAllEQWindows'
	$buttonKillAllEQWindows.Size = '88, 81'
	$buttonKillAllEQWindows.TabIndex = 10
	$buttonKillAllEQWindows.Text = 'Kill All EQ Windows'
	$buttonKillAllEQWindows.TextAlign = 'BottomCenter'
	$buttonKillAllEQWindows.UseCompatibleTextRendering = $True
	$buttonKillAllEQWindows.UseVisualStyleBackColor = $True
	$buttonKillAllEQWindows.add_Click($buttonKillAllEQWindows_Click)
	#
	# buttonstartMissingToons
	#
	#region Binary Data
	$buttonstartMissingToons.Image = [System.Convert]::FromBase64String('
iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALlrZELNbAAAACBjSFJN
AACHCgAAjCAAAP5TAACDgAAAfvwAAOlWAAA+EQAAIt5KhyhXAAAE1WlDQ1BJQ0MgUHJvZmlsZQAA
SMfllntMFEccx3+79wYO7uA8pDw8KUWkB70CSk8I4VGkIAICglhy5V7CCXdslgNBWoFCCr7wAVVp
aFGCgpLWBsUixfqiQiChiClSrCKexgcPFQsJD73Oco0kNTXp33yTyXzmtzO/2Znd784CsM/KCSID
BwCtTk/GhgWLNiVtFrH6gQlsEIAN2MiVWURQTEwk/Kem+gGj6hseVK7GyLXquy131joPK3aOnfdQ
wdvFJdGEAJgIsSDVxD4UK0z8CcXb9IQecTLFyjQ5yokRiMVkfGwI4mrEc6nzjB+hWDHPtEqKc5Sp
aCx9P2KJTqXRIb6Erlmq1FlKAFYviu9SEiTqw6bye2i1mSg/ew9iN2ovTLeZWQIgPYnyOy7EUlD5
MRVA+HQhtiIWtW0BWoULsRfL5vcH++inrC3eXvMhjN+K5nAxGserAMzKAV6uMRpn+EbjXB8AQwzQ
6KTMJnP+2aNcVGhgBrawEoJABkVwCgYxPhaNVWLDuC9+CH9FI2ijdJJBZxxjhjNfsS6y93DUZhHm
/hZruCGWiVY5vFr+mM0mwV1h0dLVdtP27Y77lsUspzu3ueS7BrtZrbz//mWPEx9UfFjmXbqq3Peo
tM3PECAMTAiu/Xg2LCW8LzI6amCDNt4ioTlJk+wqG5W3qvanZmyN1voSLlmCHFbuXP7zHQ+KbpZ0
lrbsath7ZH9ZRf4hokpTvaVGU0seL274rrH9h8kmn+biFkPbxou3r2Z3CLuu9OT1+fdz/xi9PTg8
8ODRE/PxoIm9U89m043GN9ZuAfYggXWgha+hHaax1dh27Bpuh+vxAVoorZUupV9mxDGeMg+x1rIx
dgfnsBlpnmgRxg2yDLWK5Wn45dbtAvMlCmHX0iC7TnuZI+Z0RkQ4+7vYumIrZtxBLPD0lsi8Knyu
+wqlCr+mAHrgpuCzoY5hFRFLImuj/TYMxe9NDN3MSO757FtFljoqzTOdp50kBrN+yTmWV/h5UoG4
aKrkXKl2l8OeX/elHWRV1h0OrLpTvaPG5dj1utL6iFMO38Pp6TOcc6vOF7SNXipod+sY6q7/rfRG
8c2aW4a7cfcnH/eOj/wVOT37xtpx4CAfvgu+EAM6OAg/wxNMhCVjR7ERPACvwl/S0mkGuor+nFHG
dGcOsA6wEzluZgyzcfN7FsPcUSvgOfJjresFdkvqbdfbsd7pdahzyhdFO7u7WLuy3DjutmKJZ5yk
0KvZ57mvtzTP70oAFz33E6EQpkLPPSKqa0N83MOEL5Pe+7RXViz3V85tuaIpz5BlepNc/eNtndtP
frG7UFcc9ZX7TvruW+VNB8oqUw5Lv7Gtnqkx1P5+vLdhoHHstHVTeHNly1QbeYlz9WzH1m6PHmOf
of/PwZEhgSHp4YXR0GcTk50z3Uajyasmh5i+KZQeFS3wi7TXjGqTnynRmAB1pQAbDQDrrgFURQC4
+gPYIC/HcAHipYDdUwI2vBywJ3z0RuUCvthctdictNjcA2A60+bF06yXK0Uh8gyNgpTr1a+PYR5o
YD3IQQkiCEF1BmorgESkBzWo3jb0/0mvzp33ckgmkUdqUtP0oiD0d6AWhWRqiWy9mhSLwnVKT7HI
SyLxpvqZzl1KTB5A9WaKLkzI/pUV4G9ud9tQ9PDCzAAABr1JREFUWEftl2lUVVUUx4/PKecKTSBk
EKdEcwAH0jAmkUHApS/qIYqEBg4ouoCYBHzkAxYgggkRiTikPpWCBOSBPB7wHuBIJeWQpknOVGof
W+vfPnAIwScWX/rSf60f796z9757n33uuffC/tf/0quAhhQWoHvCAuqhl1W6P9lKXZbw7iqpchCT
Ng8QZ72Qr2bq1LgmVP/8B4p/fIzjVx51oZDgtmHBVIhUOVREtctf6z8kSIeBa3RgKzQbxWgvtLwq
xT2zGfsv/oascw+RebaT3edbsedcK9hKTbPwbtcK9UcmmxtRdvkRTl1/jEU7LlIRNbvZijpT4fEv
JFUtGOCvRmrdXew8/QDpjZ3knH+IxPIWMFllvvCmrlVMtY47i9qbT1B14wnKqYDaW38gSXWr3U92
arbw/AeSlhj29VUhubIFuZQsreE+Uus7+YzGVhdcoguf7GyxVPnqqCA1ogqvo5KSn7j6CEXUCdW1
x8iuvQPmU5ZPPqOE9wvkU5IReuQKcqn1Kdq7SNXdQ2bjfaTX30MSdeRzKsA2roHWv2y+iGgXFcF8
vk4xXa/GF+cfoOjS71A2/4YSumeiv7xGRZRkCM8e5Fm4yGpLNa3xAyTV3EFy3R18dvY+XFPOIIuS
p1Mxey88xFDf0mdvwA55F/sPlpVgl6YFyou/Yl9TK4p++B2zouvAlhavEV7PkaeySFF2AymUXK6+
jWyauX28Fsz7WJpFcDnyqZhc3V0wz6OXRIR+eRY6D1hWiPzGu8inTubThPadvgfmdfSC8NCjhUoL
s8CvkdN4D7GqFiRrbmPTwWYw90Pt+93jgOKtKDVij10GW3zo07axnuR+eI3FmhM4QEuWRUu5n36d
ttWCuexfJDy6ya1go1/maSSpf0Fk6U3sqruN4csO84BxwoOK3OPwyrtHwJxzp4uRnuVSsC/hqyvY
WXsbmbScHxdfBXMtOCis3eSUVxR3/DJiKDkn4tD3oITPOrvkvSqOXizHHGe7iHJkUQFy2pK71LQt
nfOuCms32WdfUpRcRyhtpXgqwPtjNegCHwhr70TFvuy1F5maXxBe9BOyqavMIQfC2k1vZ7YmnbyB
4MNXEV9yEzZrj4PGFghr72SbPuglp2yknbqFDcofsaOqBcNcc8GcPh0hPJ6SbVqr164mGEfoYJd2
AcZL94DNT7UW1t5pXsbEkYtz8U56E14L08Jz93eQzEvnW7iv8HhKsxXNnqmNMAnXYa7iHMbLCsBs
Fc+5Y/VI30XnJgXPXnsMM+Vn8Hq4Fl47zoDNUTznHpiZULhYXoXxkTpMiW3A/JBCMOvEj4S1Z1Fy
iU1iu791Umd7reW17ttrYEaznxBVD+eoMvKR7xbWbpoW7WPluwc28Q0wCa2BW2IN2LStjcLas6Zv
dR8vzcX89UdBx+0JpseEWSzJhq38NAzWqem3EZNln4PNiF/WZn9GttJB/WbEwIMeu6MpYC4VYuax
E2xq5Gbh8XxZhac4bf4S0qwmTJHlgVlFZAyYuRVu27Uw3lANQ3o/eCbXo8+bUbT+Uj3rLyR5Y0uK
Y8hRTA6rg/H6arjJa9FvSjjYG6FLhIt+TQr71jVBA/ONGizY1gBz9ww4RJyEJXVyRGAlZkTpYO1H
s58Q9oIlHbvRtL/VFnjIa2AcXIWxIdVwjToJPsYsN/kLr66imBGzYmCX0IAhK1UwoIQWFMfjh/mr
YLJWDY+4U5BM2kT7v4fZ/61xwZtN7BPhmFAPw9WVsNygxsJIuhCNsXHrVMwyqGs3xq4LtpHlYHKo
BgNlZV0YGVABlwQtRs6J4bF+IuLFkph/mGHhmAiHrVqM/qAChoEVsIuth2xbOYa/Sd0wCHpduDKJ
WdBBx5DjMKKZ9/cp7YI5dWHMO9sgMQ1SCPd/LsmYgDSTebFwjavB5BA17GN1eMuPnmKmgU+to7Sv
xCwQzrE1GPp+KfotO9EFw1UqONB25j7MzM9CBOlVHwFfo/7EQGKQxMhXMWRCMDw2KWFpnwCJkU8e
G2jF346GbYx28hozLxqBn3yDBdFa2HWDFx1AT1eH1XshMZSliWvzHB352tRxwo1DiJGEOTGFmMMG
Twtio7xVbOjMODr3JpYSUuI94n1m4FbRx2g5ekIy2vsIe2kGf6+8RvAvKZ5LQrQVwf/wEz7IjdzJ
kuDvfP7d50J4EjyxDyEjlhN8V6wS8OMVBLfxwvjDxotwJXhiG2IiwTs3jOD/uPxdQIf4QD+Ct38w
MZzg737+NcsDjQkTgn/nmxG8S3xdO+Dn3MZ9+E1qRPDJGBAvE7y7/No8R5fE/6EY+wv1r6tSMwqn
vwAAAABJRU5ErkJggg==')
	#endregion
	$buttonstartMissingToons.ImageAlign = 'TopCenter'
	$buttonstartMissingToons.Location = '7, 6'
	$buttonstartMissingToons.Name = 'buttonstartMissingToons'
	$buttonstartMissingToons.Size = '88, 81'
	$buttonstartMissingToons.TabIndex = 11
	$buttonstartMissingToons.Text = 'Restart Missing Toons'
	$buttonstartMissingToons.TextAlign = 'BottomCenter'
	$tooltip1.SetToolTip($buttonstartMissingToons, 'Checks for any toons not running and starts them')
	$buttonstartMissingToons.UseCompatibleTextRendering = $True
	$buttonstartMissingToons.UseVisualStyleBackColor = $True
	$buttonstartMissingToons.add_Click($buttonstartMissingToons_Click)
	#
	# tabpage2
	#
	$tabpage2.Controls.Add($combobox1)
	$tabpage2.Controls.Add($buttonTaskbarGroupingFix)
	$tabpage2.Controls.Add($buttonEQClientiniReadOnly)
	$tabpage2.BackColor = 'Transparent'
	$tabpage2.Location = '4, 22'
	$tabpage2.Name = 'tabpage2'
	$tabpage2.Padding = '3, 3, 3, 3'
	$tabpage2.Size = '291, 259'
	$tabpage2.TabIndex = 1
	$tabpage2.Text = 'Tweaks'
	#
	# combobox1
	#
	$combobox1.BackColor = 'Info'
	$combobox1.DropDownStyle = 'DropDownList'
	$combobox1.FormattingEnabled = $True
	$combobox1.Location = '6, 145'
	$combobox1.Name = 'combobox1'
	$combobox1.Size = '278, 21'
	$combobox1.TabIndex = 15
	$combobox1.add_SelectedIndexChanged($combobox1_SelectedIndexChanged)
	$combobox1.add_Click($combobox1_Click)
	#
	# buttonTaskbarGroupingFix
	#
	#region Binary Data
	$buttonTaskbarGroupingFix.Image = [System.Convert]::FromBase64String('
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
5poAAAAASUVORK5CYII=')
	#endregion
	$buttonTaskbarGroupingFix.ImageAlign = 'TopCenter'
	$buttonTaskbarGroupingFix.Location = '7, 6'
	$buttonTaskbarGroupingFix.Name = 'buttonTaskbarGroupingFix'
	$buttonTaskbarGroupingFix.Size = '88, 81'
	$buttonTaskbarGroupingFix.TabIndex = 12
	$buttonTaskbarGroupingFix.Text = 'Taskbar Grouping Fix'
	$buttonTaskbarGroupingFix.TextAlign = 'BottomCenter'
	$tooltip1.SetToolTip($buttonTaskbarGroupingFix, 'Turns off taskbar grouping.  Allows independent movement of each window on the taskbar.
Modifies the registry - Must be an administrator.  ')
	$buttonTaskbarGroupingFix.UseCompatibleTextRendering = $True
	$buttonTaskbarGroupingFix.UseVisualStyleBackColor = $True
	$buttonTaskbarGroupingFix.add_Click($buttonTaskbarGroupingFix_Click)
	#
	# buttonEQClientiniReadOnly
	#
	#region Binary Data
	$buttonEQClientiniReadOnly.Image = [System.Convert]::FromBase64String('
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
tQcE/he1KvPnPfHWFAAAAABJRU5ErkJggg==')
	#endregion
	$buttonEQClientiniReadOnly.ImageAlign = 'TopCenter'
	$buttonEQClientiniReadOnly.Location = '6, 172'
	$buttonEQClientiniReadOnly.Name = 'buttonEQClientiniReadOnly'
	$buttonEQClientiniReadOnly.Size = '88, 81'
	$buttonEQClientiniReadOnly.TabIndex = 14
	$buttonEQClientiniReadOnly.Text = 'EQClient.ini ReadOnly Toggle'
	$buttonEQClientiniReadOnly.TextAlign = 'BottomCenter'
	$buttonEQClientiniReadOnly.UseCompatibleTextRendering = $True
	$buttonEQClientiniReadOnly.UseVisualStyleBackColor = $True
	$buttonEQClientiniReadOnly.add_Click($buttonEQClientiniReadOnly_Click)
	#
	# CPU
	#
	$CPU.Controls.Add($labelLogicalProcessors)
	$CPU.Controls.Add($labelCores)
	$CPU.Controls.Add($labelCPUName)
	$CPU.Location = '347, 294'
	$CPU.Name = 'CPU'
	$CPU.Size = '299, 80'
	$CPU.TabIndex = 20
	$CPU.TabStop = $False
	$CPU.UseCompatibleTextRendering = $True
	#
	# labelLogicalProcessors
	#
	$labelLogicalProcessors.AutoSize = $True
	$labelLogicalProcessors.Location = '7, 54'
	$labelLogicalProcessors.Name = 'labelLogicalProcessors'
	$labelLogicalProcessors.Size = '100, 17'
	$labelLogicalProcessors.TabIndex = 2
	$labelLogicalProcessors.Text = 'Logical Processors'
	$labelLogicalProcessors.UseCompatibleTextRendering = $True
	#
	# labelCores
	#
	$labelCores.AutoSize = $True
	$labelCores.Location = '7, 37'
	$labelCores.Name = 'labelCores'
	$labelCores.Size = '34, 17'
	$labelCores.TabIndex = 1
	$labelCores.Text = 'Cores'
	$labelCores.UseCompatibleTextRendering = $True
	#
	# labelCPUName
	#
	$labelCPUName.AutoSize = $True
	$labelCPUName.Location = '6, 16'
	$labelCPUName.Name = 'labelCPUName'
	$labelCPUName.Size = '61, 17'
	$labelCPUName.TabIndex = 0
	$labelCPUName.Text = 'CPU Name'
	$labelCPUName.UseCompatibleTextRendering = $True
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
	#
	# folderbrowserdialog4
	#
	#
	# helpToolStripMenuItem
	#
	[void]$helpToolStripMenuItem.DropDownItems.Add($aboutToolStripMenuItem)
	$helpToolStripMenuItem.Name = 'helpToolStripMenuItem'
	$helpToolStripMenuItem.Size = '44, 20'
	$helpToolStripMenuItem.Text = 'Help'
	#
	# aboutToolStripMenuItem
	#
	$aboutToolStripMenuItem.Name = 'aboutToolStripMenuItem'
	$aboutToolStripMenuItem.Size = '107, 22'
	$aboutToolStripMenuItem.Text = 'About'
	$aboutToolStripMenuItem.add_Click($aboutToolStripMenuItem_Click)
	$CPU.ResumeLayout()
	$tabpage2.ResumeLayout()
	$tabpage1.ResumeLayout()
	$tabcontrol1.ResumeLayout()
	$groupbox1.ResumeLayout()
	$menustrip1.ResumeLayout()
	$groupbox2.ResumeLayout()
	$MainForm.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $MainForm.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$MainForm.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$MainForm.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $MainForm.ShowDialog()

} #End Function

#Call the form
Show-MainForm_psf | Out-Null
