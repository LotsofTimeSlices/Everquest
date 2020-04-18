# Everquest
**Combine-AAtoCSV.ps1** - Combines all AAs from AA INIs in your macros folder to a single CSV.  You can filter this to compare who needs what.  

**EQSwitch** - A PowerShell GUI that helps manage multiple running instances of EQ.  Each instance must be uniquely named (use MQ2AutoLogin to accomplish this). 

**PEQ_Configurator** - A PowerShell GUI that monitors EQ processes and offers a variety of tweaks and options for multiboxing. 

**EQUI_BigBankWnd.xml** - Modified Big Bank UI Window.  Made larger than the original for high res monitors or folks with aging eyes.  

**Get-AAFromMagelo.ps1** - Example script to get AA total from Magelo.  Not complete. 

**Get-FlagsfromMagelo.ps1** - A quick way to get flags for a list of toons from ProjectEQ Magelo.  If Magelo changes at all, this script will likely break.  Paste your list of toons into the script and execute.  

**MacroQuest2.xml** - NotePad++ XML configuration file to add customized colors for MQ2.

**Rename-BotINIs.ps1** - Renames Bot INI files.  

**Search-Replace.PS1**  - Allows searching an INI file for a particular string and replacing a specific part of it.    
Example:  
$SearchTerm = 'Grade A' #Set your search term here -- This line will be altered if it contains the $BaseAction string else it will be skipped  
$BaseAction = '=Skip' #Set your current string here -- This is the string you want replaced  
$ReplaceAction = '=Keep' #Set your new/updated string here -- This is the replacement string  

**Set-ConstantAffinity** - Opens a PowerShell window which continually checks for *renamed* EQ process that are not set for processor affinity and applies it.  This scales to all cores whether you have a 2 core CPU or a 64 core Threadripper.  The PowerShell window closes once all EQ processes have exited.
Example:  
When you launch a your bot army, they will load up and rename their title from *Everquest* to *ToonName* (if you're using MQ2AutoLogin or another type of window renamer (WinEQ2, AutoHotKey, etc)). Once renamed, the script detects the process and sets it to affinity.   

**Set-EQAffinity.ps1**
One-liner that sets all running EQ processes to affinity regardless of how many cores your processor has.  This is often used after your toons are loaded from a batch file.  If you have an old batch file (from Creamo for example), update the code with this.

**Stop-FlashingEQTaskbarButtons.ps1**- *4/11/2020 - This no longer seems to work.* Forces EQ taskbar buttons to flash continuously and then stops them.  If the button has finished flashing, it will glow orange continuously and cannot be easily changed.  Therefore, the buttons are all forced to flash so they can be stopped.

**Sync-Equipment.ps1** - PowerShell script to parse inventory files and create a macro file and inventory file.  The macro file is meant to be run on a private server with exact toon names as the live emulated server.  When run by the GM, it will pass out all equipped items including augs.

1 - Run /bcaa //outputfile inventory on live emu server  
2 - Run this script and point to each instance of EQ that contains log files such as C:\EQ and C:\EQBots  
3 - Copy the macro to the macros folder on your private server and execute with GM toon (making sure all other characters are logged in)  

#It's a good idea to search for *-inventory.txt and delete any old files before proceeding with /outputfile inventory.  
#All toons are assumed to be exactly named as they are on the live EMU server.  
#This script ends all running macros and removes current pets.  
#Restart E3 to auto inventory equipment on the cursor.  
#Attunable items and augs must be manually added.  

**Sync-skills.ps1** - Needed to mirror my skills from PEQ to my private server rather than just maxing them out.   
Gets total list of Skills (not languages) from PEQ Magelo. 
Creates a CSV and Macro for importing your skills into your private EQEMU server.
Make sure to create a toons.txt file with a list of toons (1 per line).
If you have a lot of bots, this will create a very large macro which can take some time to build.  It takes even longer for it to execute but should end up saving you many hours of clicking.
