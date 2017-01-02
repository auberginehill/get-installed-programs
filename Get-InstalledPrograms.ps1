<#
Get-InstalledPrograms.ps1
#>


$path = $env:temp
$computer = $env:COMPUTERNAME
$ErrorActionPreference = "Stop"
$start_time = Get-Date
$empty_line = ""
$obj_installed_programs = @()


<#
            # Function to check whether a program is installed or not                         # Credit: chocolatey: "Flash Player Plugin"
            Function Check-InstalledSoftware ($display_name, $display_version) {
                $registry_paths = @(
                    'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
                    'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
                )
                Return Get-ItemProperty $registry_paths -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -eq $display_name -and $_.DisplayVersion -eq $display_version }
            } # function


            # Perhaps collect the results to an ArrayList, so that instead the copying the entire array into a new array in each addition (as in normal arrays),
            # just add the latest data to the bottom with .Add(the_data_to_be_added_at_the_bottom) method. .Insert(0,'added at the beginning') inserts to the first positition.
            # $result_list = @()
            # [System.Collections.ArrayList]$results = $result_list
            # $null = $results.Add($folder_properties)
#>
<#

            # Code snippet 1 (Get-WmiObject -Class Win32_Product)

            ### .msi installed ActiveX for IE
            ### Note: Get-WmiObject -Class Win32_Product is very slow to run...
            ### Note: Please see the Notes-section for caveats and disclaimers before using this command
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


# Determine the architecture of a machine                                                     # Credit: Tobias Weltner: "PowerTips Monthly vol 8 January 2014"
# Source: "PowerShell Basics: Filtering Objects": http://windowsitpro.com/powershell/powershell-basics-filtering-objects
If ([IntPtr]::Size -eq 8) {
    $empty_line | Out-String
    "Running in a 64-bit subsystem" | Out-String
    $64 = $true
    $bit_number = "64"
    $registry_paths_64_bit = @(
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )
    $programs = Get-ItemProperty $registry_paths_64_bit -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -ne $null }
} Else {
    $empty_line | Out-String
    "Running in a 32-bit subsystem" | Out-String
    $64 = $false
    $bit_number = "32"
    $registry_paths_32_bit = @(
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )
    $programs = Get-ItemProperty $registry_paths_32_bit -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -ne $null }
} # else




# List the Windows Store apps (app packages (.appx) that are installed in a user profile) on Windows 8 / Windows Server 2012 or later and export the results as a CSV-file
# To get the list of packages for a user profile other than the profile for the current user, PowerShell must be run with administrator permissions (in an elevated window with the -AllUsers parameter).
# Note: The Get-AppxPackage cmdlet requires PowerShell 3.0 or later
# Source: https://technet.microsoft.com/en-us/library/hh856044.aspx
If (([System.Environment]::OSVersion.Version) -ge 6.2) {

        # Perform a wider scan if enough permissions is detected                              # Credit: alejandro5042: "How to run exe with/without elevated privileges from PowerShell"
        If (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator") -eq $true) {
            $windows_store_apps = Get-AppxPackage -AllUsers | Sort Name
        } Else {
            Write-Verbose "Running this script in an elevated PowerShell prompt might yield more results for installed Windows Store apps (the Apps that are installed under other than the current user profile are not revealed unless enough privileges are granted for this script (or the underlying Get-AppxPackage cmdlet))."
            $windows_store_apps = Get-AppxPackage | Sort Name
        } # Else

    $number_of_store_apps = ($windows_store_apps | Measure-Object).Count
    $windows_store_apps | Export-Csv "$path\windows_store_apps.csv" -Delimiter ';' -NoTypeInformation -Encoding UTF8

} Else {
    $continue = $true
} # Else




# List the installed programs (both x86 and x64 or just x86 depending on the OS architecture)
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
    Write-Progress -Id $id -Activity $activity -Status $status -CurrentOperation $task -PercentComplete (($x / $programs.Count) * 100)


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

} # foreach ($program)


# Close the progress bar
$status = "Programs Found $x"
$task = "Finished retrieving installed programs."
Write-Progress -Id $id -Activity $activity -Status $status -CurrentOperation $task -PercentComplete (($programs.Count / $programs.Count) * 100) -Completed


# Display the installed programs in console
$obj_installed_programs.PSObject.TypeNames.Insert(0,"Installed Programs")
$obj_installed_programs_selection_all = $obj_installed_programs | Sort 'Name' | Select-Object 'Name','Version','Install Date','Publisher','Comments','Contact','Icon','Estimated Size','Help Link','Install Location','Install Source','Language','Modify Path','NoModify','NoRepair','Partner Code','PSChildName','PSDrive','PSProvider','Uninstall String','URL Info (About)','URL Update Info','Version (Real)','Version Major','Version Minor','Windows Installer'
# $obj_installed_programs_selection = $obj_installed_programs | Select-Object 'Name','Version','Install Date','Publisher' | Sort 'Name'
# $obj_installed_programs_selection
$empty_line | Out-String

    If (([System.Environment]::OSVersion.Version) -ge 6.2) {
        $stats_text_post = "Found $($programs.Count) programs and $number_of_store_apps Windows Store apps."
        Write-Output $stats_text_post

        # Display the Windows Store apps (app packages (.appx) that are installed in a user profile) in a pop-up window (Out-Gridview) on Windows 8 / Windows Server 2012 or later
        $windows_store_apps | Out-Gridview
    } Else {
        $stats_text_pre = "Found $($programs.Count) programs."
        Write-Output $stats_text_pre
    } # Else


# Write the installed programs to a CSV-file
$obj_installed_programs_selection_all | Export-Csv "$path\installed_programs.csv" -Delimiter ';' -NoTypeInformation -Encoding UTF8


# Display the programs in a pop-up window (Out-Gridview)
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

        If ($runtime_result.Contains(" 0 h")) {
            $runtime_result = $runtime_result.Replace(" 0 h"," ")
            } If ($runtime_result.Contains(" 0 min")) {
                $runtime_result = $runtime_result.Replace(" 0 min"," ")
                } If ($runtime_result.Contains(" 0 sec")) {
                $runtime_result = $runtime_result.Replace(" 0 sec"," ")
        } # if ($runtime_result: first)

# Display the runtime in console
$rate = [Math]::Round(($programs.Count / $runtime.TotalSeconds),1)
$runtime_text = "The installed programs were enumerated in $runtime_result (at the rate: $rate programs / second)."
$empty_line | Out-String
Write-Output $runtime_text
$empty_line | Out-String




# [End of Line]


<#

   ____        _   _
  / __ \      | | (_)
 | |  | |_ __ | |_ _  ___  _ __  ___
 | |  | | '_ \| __| |/ _ \| '_ \/ __|
 | |__| | |_) | |_| | (_) | | | \__ \
  \____/| .__/ \__|_|\___/|_| |_|___/
        | |
        |_|


# Open the Programs and Features location
# Source: http://winaero.com/blog/the-most-comprehensive-list-of-shell-locations-in-windows-8/
Start-Process explorer.exe "shell:::{7b81be6a-ce2b-4676-a29e-eb907a5126c5}"


   _____
  / ____|
 | (___   ___  _   _ _ __ ___ ___
  \___ \ / _ \| | | | '__/ __/ _ \
  ____) | (_) | |_| | | | (_|  __/
 |_____/ \___/ \__,_|_|  \___\___|



http://powershell.com/cs/PowerTips_Monthly_Volume_8.pdf#IDERA-1702_PS-PowerShellMonthlyTipsVol8-jan2014             # Tobias Weltner: "PowerTips Monthly vol 8 January 2014"
https://chocolatey.org/packages/flashplayerplugin                                                                   # chocolatey: "Flash Player Plugin"
http://stackoverflow.com/questions/29266622/how-to-run-exe-with-without-elevated-privileges-from-powershell?rq=1    # alejandro5042: "How to run exe with/without elevated privileges from PowerShell"
https://4sysops.com/archives/powershell-versions-and-their-windows-version/                                         # Michael Pietroforte: "PowerShell versions and their Windows version"
http://www.vb-helper.com/howto_net_os_version.html                                                                  # "Get operating system information in VB .NET"
https://social.msdn.microsoft.com/Forums/vstudio/en-US/5956c04f-072a-406c-ae6a-cc8b3a207936/systemenvironmentosversionversionmajor?forum=csharpgeneral              # "System.Environment.OSVersion.Version.Major"


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
Retrieves the programs installed on a local machine. Additionally on Windows 8 or
Windows Server 2012 machines and later also some of or all the installed Windows 
Store apps (app packages (.appx)) are enumerated depending whether the script is run
in an elevated PowerShell window or not.

.DESCRIPTION
Get-InstalledPrograms queries the Windows registry for installed programs. The keys 
from HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\ and
HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\ are read on 64-bit computers
and on the 32-bit computers only the latter path is accessed. Basic program related
properties, such as Name, Version, Install Date, Publisher, Comments, Contact, Icon,
Estimated Size, Help Link, Install Location, Install Source, Language, Modify Path,
NoModify, NoRepair, Partner Code, PSChildName, PSDrive, PSProvider, Uninstall String,
URL Info (About), URL Update Info, Version (Real), Version Major, Version Minor and
Windows Installer are displayed in console, written to a CSV-file and displayed in a
pop-up window (Out-Gridview). On Windows 8 / Windows Server 2012 machines (and later)
also the installed Windows Store apps are enumerated with the Get-AppxPackage cmdlet(,
which requires PowerShell 3.0 or later) in a separate CSV-file and displayed in a 
pop-up window (Out-Gridview); If Get-InstalledPrograms is run in an elevated 
PowerShell window, the Apps that are installed under other than the current user 
profile are detected, too.

The enumeration of installed programs in a Windows machine may take some time
- therefore a progress bar is included in Get-InstalledPrograms for monitoring the
steps taken. Also, after the Get-InstalledPrograms is finished, a rudimentary summary
about the performance of the machine is shown. Similarly, in "Code snippet 1" is
described what is not included in Get-InstalledPrograms. The
"Get-WmiObject -Class Win32_Product" query method was discarded mainly due to the
excessive long running times. Please see the Notes section below for further debate
on the notorious Win32_Product Class.

On the other hand, as described in "Code snippet 2", if it is relevant to find out,
whether a particular version of a known program is installed or not, the here unused
function Check-InstalledSoftware could be called to action (the code is taken from
https://github.com/auberginehill/update-adobe-flash-player and is quite quick):

    Check-InstalledSoftware "Adobe Flash Player 23 NPAPI" 23.0.0.162

will return all the aforementioned info on the queried program, if it is installed,
but returns a null value, if such a program doesn't exist on the machine.

.OUTPUTS
Displays general program related information in console. In addition to that...

Two pop-up windows "$obj_installed_programs_selection_all" and "$windows_store_apps"
(Out-GridView) on machines running Windows 8 / Windows Server 2012 or later. On
machines with an earlier OS version only the former pop-up window is displayed. For
determining the Operating System version, please see the Notes-section below.

    Name                                    Description
    ----                                    -----------
    $obj_installed_programs_selection_all   Enumerates the found installed programs
    $windows_store_apps                     Inventory of some or all the Windows
                                            Store apps; If Get-InstalledPrograms is
                                            run in an elevated PowerShell window,
                                            the Apps that are installed under other
                                            than the current user profile are
                                            detected, too.

And also two CSV-files at $path on machines running Windows 8 / Windows Server 2012
or later. On machines with an earlier OS version only the former file is written.
For determining the Operating System version, please see the Notes-section below.

$env:temp\installed_programs.csv            : CSV-file      : installed_programs.csv
$env:temp\windows_store_apps.csv            : CSV-file      : windows_store_apps.csv

.NOTES
Despite Get-InstalledPrograms makes valid eforts to detect the installed programs
on a local machine, achieving a 100 % detect rate of the installed programs might
not happen, since not every program writes the uninstallation information to the
registry. The unused WMI query Get-WmiObject -Class Win32_InstalledWin32Program
seems not to detect every installed program either, and even listing all the
shortcuts found on a computer omits those programs, which don't have a shortcut,
so increasing the detect rate of the hard-to-detect installed programs is clearly
a prominent area for further development in Get-InstalledPrograms.

The notoriously slow and possibly harmful Get-WmiObject -Class Win32_Product command
is deliberately not used for listing the installed programs in Get-InstalledPrograms,
since the Win32_Product Class has some unpleasant behaviors - namely it uses a
provider DLL that validates the consistency of every installed MSI package on the
computer (msiprov.dll with the mandatorily initiated resiliency check, in which the
installations are verified and possibly also repaired or repair-installed), which
is the main reason behind the slow performance of Win32_Product Class. All in all
Win32_product Class is not query optimized and in Get-InstalledPrograms, for now,
a combination of various registry queries is used instead.


    PowerShell versions and their Windows versions

                                                                        This PowerShell is
    PowerShell      Release Date          Default on Windows            also available on
    version (1)                     Version (8)          OSVersion (2)  Windows Version(s)

                                    Win3.1 (6)                  ?.?
                                    Win95 (7)                   4.0
                                    Win98 (7)                   4.10
                                    WinME (7)                   4.90
                                    NT 3.51                     3.51
                                    NT 4.0                      4.0
                                    Win2000                     5.0
                                    WinXP                       5.1
                                    WinXP 64-bit                5.2
                                    Win2003                     5.2
                                    Vista                       6.0
    PowerShell 1.0  November 2006   Windows Server 2008 (3)     6.0     Windows XP SP2
                                                                        Windows XP SP3
                                                                        Windows Server 2003 SP1
                                                                        Windows Server 2003 SP2
                                                                        Windows Server 2003 R2
                                                                        Windows Vista
                                                                        Windows Vista SP2
    PowerShell 2.0  October 2009    Windows 7                   6.1     Windows XP SP3
                                                                        Windows Vista SP1
                                                                        Windows Vista SP2
                                    Windows Server 2008 R2 (4)  6.1     Windows Server 2003 SP2
                                                                        Windows Server 2008 SP1
                                                                        Windows Server 2008 SP2
    PowerShell 3.0  September 2012  Windows 8                   6.2     Windows 7 SP1
                                    Windows Server 2012         6.2     Windows Server 2008 SP2
                                                                        Windows Server 2008 R2 SP1
    PowerShell 4.0  October 2013    Windows 8.1                 6.3     Windows 7 SP1
                                    Windows Server 2012 R2      6.3     Windows Server 2008 R2 SP1
                                                                        Windows Server 2012
    PowerShell 5.0  April 2014 (5)  Windows 10                  10.0    Windows 8.1
                                                                        Windows Server 2012 R2

    (1) $PSVersionTable.PSVersion
    (2) [System.Environment]::OSVersion.Version (format: Major.Minor - requires 
        .NET Framework 1.1 or later; To find out the .NET Framework version with PowerShell, 
        a command $PSVersionTable.CLRVersion could be used). 
    (3) Has to be installed through Server Manager
    (4) Also integrated in all later Windows versions
    (5) Release date of public review
    (6) Platform ID = 0
    (7) Platform ID = 1 (whereas on NT 3.51 and later the Platform ID >/= 2)
    (8) (Get-WmiObject -Class Win32_OperatingSystem).Caption

    # Source: https://4sysops.com/archives/powershell-versions-and-their-windows-version/
    # Source: http://www.vb-helper.com/howto_net_os_version.html
    # Source: https://social.msdn.microsoft.com/Forums/vstudio/en-US/5956c04f-072a-406c-ae6a-cc8b3a207936/systemenvironmentosversionversionmajor?forum=csharpgeneral
    # Source: http://windowsitpro.com/powershell/q-find-your-net-framework-versions


Please note that this script will try to check whether it is run in an elevated
PowerShell window (run as an administrator) or not when executed on a Windows 8 or
a Windows Server 2012 machine or later.

Please note that the CSV-file(s) is/are created in a directory, which is specified with
the $path variable (at line 6). The $env:temp variable points to the current temp folder.
The default value of the $env:temp variable is C:\Users\<username>\AppData\Local\Temp
(i.e. each user account has their own separate temp folder at path
%USERPROFILE%\AppData\Local\Temp). To see the current temp path, for instance a command

    [System.IO.Path]::GetTempPath()

may be used at the PowerShell prompt window [PS>]. To change the temp folder for instance
to C:\Temp, please, for example, follow the instructions at
http://www.eightforums.com/tutorials/23500-temporary-files-folder-change-location-windows.html

    Homepage:           https://github.com/auberginehill/get-installed-programs
    Short URL:          http://tinyurl.com/j7a4eky
    Version:            1.2

.EXAMPLE
./Get-InstalledPrograms
Run the script. Please notice to insert ./ or .\ before the script name.

.EXAMPLE
help ./Get-InstalledPrograms -Full
Display the help file.

.EXAMPLE
Set-ExecutionPolicy remotesigned
This command is altering the Windows PowerShell rights to enable script execution for
the default (LocalMachine) scope. Windows PowerShell has to be run with elevated rights
(run as an administrator) to actually be able to change the script execution properties.
The default value of the default (LocalMachine) scope is "Set-ExecutionPolicy restricted".


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


For more information, please type "Get-ExecutionPolicy -List", "help Set-ExecutionPolicy -Full",
"help about_Execution_Policies" or visit https://technet.microsoft.com/en-us/library/hh849812.aspx
or http://go.microsoft.com/fwlink/?LinkID=135170.

.EXAMPLE
New-Item -ItemType File -Path C:\Temp\Get-InstalledPrograms.ps1
Creates an empty ps1-file to the C:\Temp directory. The New-Item cmdlet has an inherent -NoClobber mode
built into it, so that the procedure will halt, if overwriting (replacing the contents) of an existing
file is about to happen. Overwriting a file with the New-Item cmdlet requires using the Force. If the
path name includes space characters, please enclose the path name in quotation marks (single or double):

    New-Item -ItemType File -Path "C:\Folder Name\Get-InstalledPrograms.ps1"

For more information, please type "help New-Item -Full".

.LINK
http://powershell.com/cs/PowerTips_Monthly_Volume_8.pdf#IDERA-1702_PS-PowerShellMonthlyTipsVol8-jan2014
https://chocolatey.org/packages/flashplayerplugin
https://www.credera.com/blog/technology-insights/perfect-progress-bars-for-powershell/
https://msdn.microsoft.com/en-us/library/aa393941(v=vs.85).aspx
http://stackoverflow.com/questions/29266622/how-to-run-exe-with-without-elevated-privileges-from-powershell?rq=1
https://4sysops.com/archives/powershell-versions-and-their-windows-version/
http://www.vb-helper.com/howto_net_os_version.html
https://social.msdn.microsoft.com/Forums/vstudio/en-US/5956c04f-072a-406c-ae6a-cc8b3a207936/systemenvironmentosversionversionmajor?forum=csharpgeneral

#>
