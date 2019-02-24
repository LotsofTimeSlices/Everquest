# Everquest
PowerShell Scripts

**MacroQuest2.xml** - NotePad++ XML configuration file

**PEQ_Configurator** - A PowerShell GUI to help ease EQ boxing. 

**EQUI_BigBankWnd.xml** - Modified Big Bank UI Window.  Made larger than original.  

**Sync-skills.ps1** - Needed to mirror my skills from PEQ to my private server rather than just maxing them out.   
Gets total list of Skills (not languages) from PEQ Magelo. 
Creates a CSV and Macro for importing your skills into your private EQEMU server.
Make sure to create a toons.txt file with a list of toons (1 per line).
If you have a lot of bots, this will create a very large macro which can take some time to build.  It takes even longer for it to execute but should end up saving you many hours of clicking.

**Create Sync-Equipment.ps1** - PowerShell script to parse inventory files and create a macro file and inventory file.  The macro file is meant to be run on a private server with exact toon names as the live emulated server.  When run by the GM, it will pass out all equipped items including augs.  

1 - Run /bcaa //outputfile inventory on live emu server  
2 - Run this script and point to each instance of EQ that contains log files such as C:\EQ and C:\EQBots  
3 - Copy the macro to the macros folder on your private server and execute with GM toon (making sure all other characters are logged in)  

#It's a good idea to search for *-inventory.txt and delete any old files before proceeding with /outputfile inventory.  
#All toons are assumed to be exactly named as they are on the live EMU server.  
#This script ends all running macros and removes current pets.  
#Restart E3 to auto inventory equipment on the cursor.  
#Attunable items and augs must be manually added.  

