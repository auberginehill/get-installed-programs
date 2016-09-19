<#
Get-InstalledPrograms.ps1
#>


$path = $env:temp
$computer = $env:COMPUTERNAME
$ErrorActionPreference = "Stop"
$start_time = Get-Date
$empty_line = ""


# Function to check weather a program is installed or not                                     # Credit: chocolatey: "Flash Player Plugin"
Function Check-InstalledSoftware ($display_name, $display_version) {
    $registry_paths = @(
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )
    Return Get-ItemProperty $registry_paths -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -eq $display_name -and $_.DisplayVersion -eq $display_version }
} # function


$obj_installed_programs = @()


$registry_paths_64_bit = @(
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )

$registry_paths_32_bit = @(
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )


# Determine the architecture of a machine
# Source: "PowerShell Basics: Filtering Objects": http://windowsitpro.com/powershell/powershell-basics-filtering-objects
# Credit: Tobias Weltner: "PowerTips Monthly vol 8 January 2014"
If ([IntPtr]::Size -eq 8) {
    $empty_line | Out-String
    "Running in a 64-bit subsystem" | Out-String
    $64 = $true
    $bit_number = "64"
    $programs = Get-ItemProperty $registry_paths_64_bit -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -ne $null }
    $empty_line | Out-String
} Else {
    $empty_line | Out-String
    "Running in a 32-bit subsystem" | Out-String
    $64 = $false
    $bit_number = "32"
    $programs = Get-ItemProperty $registry_paths_32_bit -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -ne $null }
    $empty_line | Out-String
} # else


<#

            # Code snippet 1 (Get-WmiObject -Class Win32_Product)

            ### .msi installed ActiveX for IE
            ### Note: Get-WmiObject -Class Win32_Product is very slow to run...
            $activex_already_installed = $false
            $activex_major_version = ([version]$xml_activex_win_current).Major
            If (Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "Adobe Flash Player $activex_major_version ActiveX" -and $_.Version -eq $xml_activex_win_current }) {
                $activex_already_installed = $true
                $activex_already_text = "The most recent version of Adobe Flash Player ActiveX for IE $activex_version is already installed."
                Write-Output $activex_already_text
            } Else {
                $continue = $true
            } # else




            # Code snippet 2 (Function: Check-InstalledSoftware)

            $downloading_plugin_is_required = $false
            If ($plugin_is_installed -eq $true) {
                $most_recent_plugin_major_version = ([version]$xml_plugin_win_current).Major 
                $most_recent_plugin_already_exists = Check-InstalledSoftware "Adobe Flash Player $most_recent_plugin_major_version NPAPI" $xml_plugin_win_current
                If ($most_recent_plugin_already_exists) {
                    Write-Output "Currently (until the next Flash Player version is released) Adobe Flash Player for Firefox (NPAPI) v$plugin_baseline doesn't need any further maintenance or care."
                    $empty_line | Out-String
                } Else {
                    $downloading_plugin_is_required = $true
                    Write-Warning "Adobe Flash Player for Firefox (NPAPI) v$plugin_baseline seems to be outdated."
                    $empty_line | Out-String
                    Write-Output "The most recent non-beta Flash version of NPAPI is v$xml_plugin_win_current. The installed NPAPI Flash version v$plugin_baseline needs to be updated."
                    $empty_line | Out-String
                } # else

            } Else {
                $continue = $true
            } # else

#>


# Reset the counter (important!)
$x = 0

# Progress bar variables
$activity             = "Retrieving installed programs in $computer"
$id                   = 1 # For using more than one progress bar

# Enumerate the installed programs
ForEach ($program in $programs) {

    # Increment the counter
    $x++

    # Write the progress bar
    $status = "Programs Found: $x"
    $task = "Currently Processing: $($program.DisplayName)"
    Write-Progress -Id $id -Activity $activity -Status $status -CurrentOperation $task -PercentComplete (($x / $programs.count) * 100)


            $obj_installed_programs += New-Object -TypeName PSCustomObject -Property @{
                    'Comments'              = $program.Comments
                    'Contact'               = $program.Contact
                    'Estimated Size'        = $program.EstimatedSize
                    'Help Link'             = $program.HelpLink
                    'Icon'                  = $program.DisplayIcon
                    'Install Date'          = $program.InstallDate
                    'Install Location'      = $program.InstallLocation
                    'Install Source'        = $program.InstallSource
                    'Language'              = $program.Language
                    'Modify Path'           = $program.ModifyPath
                    'Name'                  = $program.DisplayName
                    'NoModify'              = $program.NoModify
                    'NoRepair'              = $program.NoRepair
                    'Partner Code'          = $program.PartnerCode
                    'PSChildName'           = $program.PSChildName
                    'PSDrive'               = $program.PSDrive
                    'PSProvider'            = $program.PSProvider
                    'Publisher'             = $program.Publisher
                    'Uninstall String'      = $program.UninstallString
                    'URL Info (About)'      = $program.URLInfoAbout
                    'URL Update Info'       = $program.URLUpdateInfo
                    'Version'               = $program.DisplayVersion
                    'Version (Real)'        = $program.Version
                    'Version Major'         = $program.VersionMajor
                    'Version Minor'         = $program.VersionMinor
                    'Windows Installer'     = $program.WindowsInstaller
                } # New-Object


            $obj_installed_programs.PSObject.TypeNames.Insert(0,"Installed Programs")
            $obj_installed_programs_selection_all = $obj_installed_programs | Sort 'Name' | Select-Object 'Name','Version','Install Date','Publisher','Comments','Contact','Icon','Estimated Size','Help Link','Install Location','Install Source','Language','Modify Path','NoModify','NoRepair','Partner Code','PSChildName','PSDrive','PSProvider','Uninstall String','URL Info (About)','URL Update Info','Version (Real)','Version Major','Version Minor','Windows Installer'
            $obj_installed_programs_selection = $obj_installed_programs | Select-Object 'Name','Version','Install Date','Publisher' | Sort 'Name'

} # foreach ($program)


# Close the progress bar
$status = "Programs Found $x"
$task = "Finished retrieving installed programs."
Write-Progress -Id $id -Activity $activity -Status $status -CurrentOperation $task -PercentComplete (($programs.count / $programs.count) * 100) -Completed


# Display the installed programs in console
$stats_text = "Found $($programs.count) programs."
Write-Output $stats_text
$empty_line | Out-String


# Write the installed programs to a CSV-file
$obj_installed_programs_selection_all | Export-Csv $path\installed_programs.csv -Delimiter ';' -NoTypeInformation -Encoding UTF8


# Display the results in a pop-up window (Out-Gridview)
$obj_installed_programs_selection_all | Out-Gridview


# Find out how long the script took to complete
$end_time = Get-Date
$runtime = ($end_time) - ($start_time)

    If ($runtime.Days -ge 2) {
        $runtime_result = [string]$runtime.Days + ' days ' + $runtime.Hours + ' h ' + $runtime.Minutes + ' min'
    } ElseIf ($runtime.Days -gt 0) {
        $runtime_result = [string]$runtime.Days + ' day ' + $runtime.Hours + ' h ' + $runtime.Minutes + ' min'
    } ElseIf ($runtime.Hours -gt 0) {
        $runtime_result = [string]$runtime.Hours + ' h ' + $runtime.Minutes + ' min'
    } ElseIf ($runtime.Minutes -gt 0) {
        $runtime_result = [string]$runtime.Minutes + ' min ' + $runtime.Seconds + ' sec'
    } ElseIf ($runtime.Seconds -gt 0) {
        $runtime_result = [string]$runtime.Seconds + ' sec'
    } ElseIf ($runtime.Milliseconds -gt 1) {
        $runtime_result = [string]$runtime.Milliseconds + ' milliseconds'
    } ElseIf ($runtime.Milliseconds -eq 1) {
        $runtime_result = [string]$runtime.Milliseconds + ' millisecond'
    } ElseIf (($runtime.Milliseconds -gt 0) -and ($runtime.Milliseconds -lt 1)) {
        $runtime_result = [string]$runtime.Milliseconds + ' milliseconds'
    } Else {
        $runtime_result = [string]''
    } # else (if)

        If ($runtime_result.Contains("0 h")) {
            $runtime_result = $runtime_result.Replace("0 h","")
            } If ($runtime_result.Contains("0 min")) {
                $runtime_result = $runtime_result.Replace("0 min","")
                } If ($runtime_result.Contains("0 sec")) {
                $runtime_result = $runtime_result.Replace("0 sec","")
        } # if ($runtime_result: first)

# Display the runtime in console
$rate = [Math]::Round(($programs.count / $runtime.TotalSeconds),1)
$runtime_text = "The installed programs were enumerated in $runtime_result (at the rate: $rate programs / second)."
Write-Output $runtime_text
$empty_line | Out-String




# [End of Line]


<#

   _____
  / ____|
 | (___   ___  _   _ _ __ ___ ___
  \___ \ / _ \| | | | '__/ __/ _ \
  ____) | (_) | |_| | | | (_|  __/
 |_____/ \___/ \__,_|_|  \___\___|



http://powershell.com/cs/PowerTips_Monthly_Volume_8.pdf#IDERA-1702_PS-PowerShellMonthlyTipsVol8-jan2014             # Tobias Weltner: "PowerTips Monthly vol 8 January 2014"
https://chocolatey.org/packages/flashplayerplugin                                                                   # chocolatey: "Flash Player Plugin"


  _    _      _
 | |  | |    | |
 | |__| | ___| |_ __
 |  __  |/ _ \ | '_ \
 | |  | |  __/ | |_) |
 |_|  |_|\___|_| .__/
               | |
               |_|

#>

<#

.SYNOPSIS
Retrieves the programs installed on a local machine.

.DESCRIPTION
Get-InstalledPrograms queries the Windows registry for installed programs. The keys from
HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\ and
HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\ are read on 64-bit computers
and on the 32-bit computers only the latter path is accessed. Basic program related
properties, such as Name, Version, Install Date, Publisher, Comments, Contact, Icon,
Estimated Size, Help Link, Install Location, Install Source, Language, Modify Path,
NoModify, NoRepair, Partner Code, PSChildName, PSDrive, PSProvider, Uninstall String,
URL Info (About), URL Update Info, Version (Real), Version Major, Version Minor and
Windows Installer are displayed in console, written to a CSV-file and displayed in a
pop-up window (Out-Gridview).

The enumeration of installed programs in a Windows machine may take some time 
- therefore a progress bar is included in Get-InstalledPrograms for monitoring the 
steps taken. Also, after the Get-InstalledPrograms is finished, a rudimentary summary 
about the performance of the machine is shown. Similarly, in "Code snippet 1" is 
described what is not included in Get-InstalledPrograms. The 
"Get-WmiObject -Class Win32_Product" query method was discarded mainly due to the 
excessive long running times.

On a sidenote, as described in "Code snippet 2", if it is relevant to find out, 
weather a particular version of a known program is installed or not, the here unused 
function Check-InstalledSoftware could be called to action (the code is taken from 
https://github.com/auberginehill/update-adobe-flash-player and is quite quick):

    Check-InstalledSoftware "Adobe Flash Player 23 NPAPI" 23.0.0.162

will return all the aforementioned info on the queried program, if it is installed, 
but returs a null value, if such a program doesn't exist on the machine.

.OUTPUTS
Displays general program related information in console. In addition to that...


One pop-up window "$obj_installed_programs_selection_all" (Out-GridView):

    Name                                    Description
    ----                                    -----------
    $obj_installed_programs_selection_all   Enumerates the found installed programs


And also one CSV-file at $path

$env:temp\installed_programs.csv            : CSV-file      : installed_programs.csv

.NOTES
Please note that the CSV-file is created in a directory, which is specified with the
$path variable (at line 6). The $env:temp variable points to the current temp folder.
The default value of the $env:temp variable is C:\Users\<username>\AppData\Local\Temp
(i.e. each user account has their own separate temp folder at path 
%USERPROFILE%\AppData\Local\Temp). To see the current temp path, for instance a command

    [System.IO.Path]::GetTempPath()

may be used at the PowerShell prompt window [PS>]. To change the temp folder for instance
to C:\Temp, please, for example, follow the instructions at
http://www.eightforums.com/tutorials/23500-temporary-files-folder-change-location-windows.html

    Homepage:           https://github.com/auberginehill/get-installed-programs
    Version:            1.0

.EXAMPLE
./Get-InstalledPrograms
Run the script. Please notice to insert ./ or .\ before the script name.

.EXAMPLE
help ./Get-InstalledPrograms -Full
Display the help file.

.EXAMPLE
Set-ExecutionPolicy remotesigned
This command is altering the Windows PowerShell rights to enable script execution. Windows PowerShell
has to be run with elevated rights (run as an administrator) to actually be able to change the script
execution properties. The default value is "Set-ExecutionPolicy restricted".


    Parameters:

    Restricted      Does not load configuration files or run scripts. Restricted is the default
                    execution policy.

    AllSigned       Requires that all scripts and configuration files be signed by a trusted
                    publisher, including scripts that you write on the local computer.

    RemoteSigned    Requires that all scripts and configuration files downloaded from the Internet
                    be signed by a trusted publisher.

    Unrestricted    Loads all configuration files and runs all scripts. If you run an unsigned
                    script that was downloaded from the Internet, you are prompted for permission
                    before it runs.

    Bypass          Nothing is blocked and there are no warnings or prompts.

    Undefined       Removes the currently assigned execution policy from the current scope.
                    This parameter will not remove an execution policy that is set in a Group
                    Policy scope.


For more information, please type "help Set-ExecutionPolicy -Full" or visit
https://technet.microsoft.com/en-us/library/hh849812.aspx.

.EXAMPLE
New-Item -ItemType File -Path C:\Temp\Get-InstalledPrograms.ps1
Creates an empty ps1-file to the C:\Temp directory. The New-Item cmdlet has an inherent -NoClobber mode
built into it, so that the procedure will halt, if overwriting (replacing the contents) of an existing
file is about to happen. Overwriting a file with the New-Item cmdlet requires using the Force.
For more information, please type "help New-Item -Full".

.LINK
http://powershell.com/cs/PowerTips_Monthly_Volume_8.pdf#IDERA-1702_PS-PowerShellMonthlyTipsVol8-jan2014
https://chocolatey.org/packages/flashplayerplugin
https://www.credera.com/blog/technology-insights/perfect-progress-bars-for-powershell/
https://msdn.microsoft.com/en-us/library/aa393941(v=vs.85).aspx

#>
