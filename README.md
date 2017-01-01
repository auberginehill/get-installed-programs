<!-- Visual Studio Code: For a more comfortable reading experience, use the key combination Ctrl + Shift + V
     Visual Studio Code: To crop the tailing end space characters out, please use the key combination Ctrl + A Ctrl + K Ctrl + X (Formerly Ctrl + Shift + X)
     Visual Studio Code: To improve the formatting of HTML code, press Shift + Alt + F and the selected area will be reformatted in a html file.
     Visual Studio Code shortcuts: http://code.visualstudio.com/docs/customization/keybindings (or https://aka.ms/vscodekeybindings)
     Visual Studio Code shortcut PDF (Windows): https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf


   _____      _        _____           _        _ _          _ _____
  / ____|    | |      |_   _|         | |      | | |        | |  __ \
 | |  __  ___| |_ ______| |  _ __  ___| |_ __ _| | | ___  __| | |__) | __ ___   __ _ _ __ __ _ _ __ ___  ___
 | | |_ |/ _ \ __|______| | | '_ \/ __| __/ _` | | |/ _ \/ _` |  ___/ '__/ _ \ / _` | '__/ _` | '_ ` _ \/ __|
 | |__| |  __/ |_      _| |_| | | \__ \ || (_| | | |  __/ (_| | |   | | | (_) | (_| | | | (_| | | | | | \__ \
  \_____|\___|\__|    |_____|_| |_|___/\__\__,_|_|_|\___|\__,_|_|   |_|  \___/ \__, |_|  \__,_|_| |_| |_|___/
                                                                                __/ |
                                                                               |___/                               -->


## Get-InstalledPrograms.ps1

<table>
   <tr>
      <td style="padding:6px"><strong>OS:</strong></td>
      <td style="padding:6px">Windows</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Type:</strong></td>
      <td style="padding:6px">A Windows PowerShell script</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Language:</strong></td>
      <td style="padding:6px">Windows PowerShell</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Description:</strong></td>
      <td style="padding:6px">Get-InstalledPrograms queries the Windows registry for installed programs. The keys from <code>HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\</code> and <code>HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\</code> are read on 64-bit computers and on the 32-bit computers only the latter path is accessed. Basic program related properties, such as Name, Version, Install Date, Publisher, Comments, Contact, Icon, Estimated Size, Help Link, Install Location, Install Source, Language, Modify Path, NoModify, NoRepair, Partner Code, PSChildName, PSDrive, PSProvider, Uninstall String, URL Info (About), URL Update Info, Version (Real), Version Major, Version Minor and Windows Installer are written to a CSV-file and displayed in a pop-up window (Out-Gridview). On Windows 8 / Windows Server 2012 machines (and later) also the installed Windows Store apps are enumerated with the <code>Get-AppxPackage</code> cmdlet(, which requires PowerShell 3.0 or later) in a separate CSV-file and displayed in a pop-up window (Out-Gridview); If Get-InstalledPrograms is run in an elevated PowerShell window, the Apps that are installed under other than the current user profile are detected, too.
      <br />
      <br />The enumeration of installed programs in a Windows machine may take some time – therefore a progress bar is included in Get-InstalledPrograms for monitoring the steps taken. Also, after the Get-InstalledPrograms is finished, a rudimentary summary about the performance of the machine is shown. Similarly, in "Code snippet 1" is described what is not included in Get-InstalledPrograms. The "<code>Get-WmiObject -Class Win32_Product</code>" query method was discarded mainly due to the excessive long running times. Please see the Notes section below for further debate on the notorious <code>Win32_Product</code> Class.
      <br />
      <br />On the other hand, as described in "Code snippet 2", if it is relevant to find out, whether a particular version of a known program is installed or not, the here unused function Check-InstalledSoftware could be called to action (the code is taken from <a href="https://github.com/auberginehill/update-adobe-flash-player">https://github.com/auberginehill/update-adobe-flash-player</a>" and is quite quick):
      <br />
      <br /><code>Check-InstalledSoftware "Adobe Flash Player 23 NPAPI" 23.0.0.162</code>
      <br />
      <br />will return all the aforementioned info on the queried program, if it is installed, but returs a null value, if such a program doesn't exist on the machine.</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Homepage:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-programs">https://github.com/auberginehill/get-installed-programs</a>
      <br />Short URL: <a href="http://tinyurl.com/j7a4eky">http://tinyurl.com/j7a4eky</a></td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Version:</strong></td>
      <td style="padding:6px">1.2</td>
   </tr>
   <tr>
        <td style="padding:6px"><strong>Sources:</strong></td>
        <td style="padding:6px">
            <table>
                <tr>
                    <td style="padding:6px">Emojis:</td>
                    <td style="padding:6px"><a href="https://github.com/auberginehill/emoji-table">Emoji Table</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">Tobias Weltner:</td>
                    <td style="padding:6px"><a href="http://powershell.com/cs/PowerTips_Monthly_Volume_8.pdf#IDERA-1702_PS-PowerShellMonthlyTipsVol8-jan2014">PowerTips Monthly vol 8 January 2014</a> (or one of the <a href="https://web.archive.org/web/20150110213108/http://powershell.com/cs/media/p/30542.aspx">archive.org versions</a>)</td>
                </tr>
                <tr>
                    <td style="padding:6px">chocolatey:</td>
                    <td style="padding:6px"><a href="https://chocolatey.org/packages/flashplayerplugin">Flash Player Plugin</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">alejandro5042:</td>
                    <td style="padding:6px"><a href="http://stackoverflow.com/questions/29266622/how-to-run-exe-with-without-elevated-privileges-from-powershell?rq=1">How to run exe with/without elevated privileges from PowerShell</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">Michael Pietroforte:</td>
                    <td style="padding:6px"><a href="https://4sysops.com/archives/powershell-versions-and-their-windows-version/">PowerShell versions and their Windows version</a></td>
                </tr>
            </table>
        </td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Downloads:</strong></td>
      <td style="padding:6px">For instance <a href="https://raw.githubusercontent.com/auberginehill/get-installed-programs/master/Get-InstalledPrograms.ps1">Get-InstalledPrograms.ps1</a>. Or <a href="https://github.com/auberginehill/get-installed-programs/archive/master.zip">everything as a .zip-file</a>.</td>
   </tr>
</table>




### Screenshot

<img class="screenshot" title="screenshot" alt="screenshot" height="100%" width="100%" src="https://raw.githubusercontent.com/auberginehill/get-installed-programs/master/Get-InstalledPrograms.png">




### Outputs

<table>
    <tr>
        <th>:arrow_right:</th>
        <td style="padding:6px">
            <ul>
                <li>Displays general program related information in console. In addition to that...</li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>Two pop-up windows "<code>$obj_installed_programs_selection_all</code>" and "<code>$windows_store_apps</code>" (Out-GridView) on machines running Windows 8 / Windows Server 2012 or later. On machines with an earlier OS version only the former pop-up window is displayed. For determining the Operating System version, please see the Notes-section below.</li>
                </p>
                <ol>
                    <p>
                        <table>
                            <tr>
                                <td style="padding:6px"><strong>Name</strong></td>
                                <td style="padding:6px"><strong>Description</strong></td>
                            </tr>
                            <tr>
                                <td style="padding:6px"><code>$obj_installed_programs_selection_all</code></td>
                                <td style="padding:6px">Enumerates the found installed programs</td>
                            </tr>
                            <tr>
                                <td style="padding:6px"><code>$windows_store_apps</code></td>
                                <td style="padding:6px">Inventory of some or all the Windows Store apps; If Get-InstalledPrograms is run in an elevated PowerShell window, the Apps that are installed under other than the current user profile are detected, too.</td>
                            </tr>
                        </table>
                    </p>
                </ol>
                <p>
                    <li>And also two CSV-files at <code>$path</code> on machines running Windows 8 / Windows Server 2012 or later. On machines with an earlier OS version only the former file is written. For determining the Operating System version, please see the Notes-section below.</li>
                </p>
                <ol>
                    <p>
                        <table>
                            <tr>
                                <td style="padding:6px"><strong>Path</strong></td>
                                <td style="padding:6px"><strong>Type</strong></td>
                                <td style="padding:6px"><strong>Name</strong></td>
                            </tr>
                            <tr>
                                <td style="padding:6px"><code>$env:temp\installed_programs.csv</code></td>
                                <td style="padding:6px">CSV-file</td>
                                <td style="padding:6px"><code>installed_programs.csv</code></td>
                            </tr>
                            <tr>
                                <td style="padding:6px"><code>$env:temp\windows_store_apps.csv</code></td>
                                <td style="padding:6px">CSV-file</td>
                                <td style="padding:6px"><code>windows_store_apps.csv</code></td>
                            </tr>
                        </table>
                    </p>
                </ol>
            </ul>
        </td>
    </tr>
</table>




### Notes

<table>
    <tr>
        <th>:warning:</th>
        <td style="padding:6px">
            <ul>
                <li>Despite Get-InstalledPrograms makes valid eforts to detect the installed programs on a local machine, achieving a 100 % detect rate of the installed programs might not happen, since not every program writes the uninstallation information to the registry. The unused WMI query <code>Get-WmiObject -Class Win32_InstalledWin32Program</code> seems not to detect every installed program either, and even listing all the shortcuts found on a computer omits those programs, which don't have a shortcut, so increasing the detect rate of the hard-to-detect installed programs is clearly a prominent area for further development in Get-InstalledPrograms.</li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>The notoriously slow and possibly harmful <code>Get-WmiObject -Class Win32_Product</code> command is deliberately not used for listing the installed programs in Get-InstalledPrograms, since the <code>Win32_Product</code> Class has some unpleasant behaviors – namely it uses a provider DLL that validates the consistency of every installed MSI package on the computer (<code>msiprov.dll</code> with the mandatorily initiated resiliency check, in which the installations are verified and possibly also repaired or repair-installed), which is the main reason behind <a href="https://sdmsoftware.com/group-policy-blog/wmi/why-win32_product-is-bad-news/">the</a> <a href="https://blogs.technet.microsoft.com/askds/2012/04/19/how-to-not-use-win32_product-in-group-policy-filtering/">slow</a> <a href="https://support.microsoft.com/en-us/kb/974524">performance</a> of <code>Win32_Product</code> Class. All in all <code>Win32_product</code> Class is not query optimized and in Get-InstalledPrograms, for now, a combination of various registry queries is used instead.</li>
                </p>
                <p>
                    <li>PowerShell versions and their Windows versions:
                    <ol>
                        <table>
                            <tr>
                                <td rowspan="2" style="padding:6px"><strong>PowerShell version<sup>1</sup></strong></td>
                                <td rowspan="2" style="padding:6px"><strong>Release Date</strong></td>
                                <th colspan="2" style="padding:6px">Default on Windows</th>
                                <td rowspan="2" style="padding:6px"><strong>This PowerShell Version is also available on Windows Version(s)</strong></td>
                            </tr>
                            <tr>
                                <td style="padding:6px"><strong>Version</strong></td>
                                <th style="padding:6px">OSVersion<sup>2</sup></th>
                            </tr>
                            <tr>
                                <td rowspan="11"></td>
                                <td rowspan="11"></td>
                                <td style="padding:6px">Win3.1<sup>6</sup></td>
                                <td style="padding:6px">?.?</td>
                                <td rowspan="11"></td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Win95<sup>7</sup></td>
                                <td style="padding:6px">4.0</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Win98<sup>7</sup></td>
                                <td style="padding:6px">4.10</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">WinME<sup>7</sup></td>
                                <td style="padding:6px">4.90</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">NT 3.51</td>
                                <td style="padding:6px">3.51</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">NT 4.0</td>
                                <td style="padding:6px">4.0</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Win2000</td>
                                <td style="padding:6px">5.0</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">WinXP</td>
                                <td style="padding:6px">5.1</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">WinXP 64-bit</td>
                                <td style="padding:6px">5.2</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Win2003</td>
                                <td style="padding:6px">5.2</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Vista</td>
                                <td style="padding:6px">6.0</td>
                            </tr>
                            <tr>
                                <td rowspan="7" style="padding:6px">PowerShell 1.0</td>
                                <td rowspan="7" style="padding:6px">November 2006</td>
                                <td rowspan="7" style="padding:6px">Windows Server 2008<sup>3</sup></td>
                                <td rowspan="7" style="padding:6px">6.0</td>
                                <td style="padding:6px">Windows XP SP2</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows XP SP3</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Vista</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Vista SP2</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Server 2003 SP1</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Server 2003 SP2</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Server 2003 R2</td>
                            </tr>
                            <tr>
                                <td rowspan="6" style="padding:6px">PowerShell 2.0</td>
                                <td rowspan="6" style="padding:6px">October 2009</td>
                                <td rowspan="3" style="padding:6px">Windows 7</td>
                                <td rowspan="3" style="padding:6px">6.1</td>
                                <td style="padding:6px">Windows XP SP3</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Vista SP1</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Vista SP2</td>
                            </tr>
                            <tr>
                                <td rowspan="3" style="padding:6px">Windows Server 2008 R2<sup>4</sup></td>
                                <td rowspan="3" style="padding:6px">6.1</td>
                                <td style="padding:6px">Windows Server 2003 SP2</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Server 2008 SP1</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Server 2008 SP2</td>
                            </tr>
                            <tr>
                                <td rowspan="3" style="padding:6px">PowerShell 3.0</td>
                                <td rowspan="3" style="padding:6px">September 2012</td>
                                <td style="padding:6px">Windows 8</td>
                                <td style="padding:6px">6.2</td>
                                <td style="padding:6px">Windows 7 SP1</td>
                            </tr>
                            <tr>
                                <td rowspan="2" style="padding:6px">Windows Server 2012</td>
                                <td rowspan="2" style="padding:6px">6.2</td>
                                <td style="padding:6px">Windows Server 2008 SP2</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Server 2008 R2 SP1</td>
                            </tr>
                            <tr>
                                <td rowspan="3" style="padding:6px">PowerShell 4.0</td>
                                <td rowspan="3" style="padding:6px">October 2013</td>
                                <td style="padding:6px">Windows 8.1</td>
                                <td style="padding:6px">6.3</td>
                                <td style="padding:6px">Windows 7 SP1</td>
                            </tr>
                            <tr>
                                <td rowspan="2" style="padding:6px">Windows Server 2012 R2</td>
                                <td rowspan="2" style="padding:6px">6.3</td>
                                <td style="padding:6px">Windows Server 2008 R2 SP1</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Server 2012</td>
                            </tr>
                            <tr>
                                <td rowspan="2" style="padding:6px">PowerShell 5.0</td>
                                <td rowspan="2" style="padding:6px">April 2014<sup>5</sup></td>
                                <td rowspan="2" style="padding:6px">Windows 10</td>
                                <td rowspan="2" style="padding:6px">10.0</td>
                                <td style="padding:6px">Windows 8.1</td>
                            </tr>
                            <tr>
                                <td style="padding:6px">Windows Server 2012 R2</td>
                            </tr>
                        </table>
                        <p><sup>1</sup> <code>$PSVersionTable.PSVersion</code>
                        <br /><sup>2</sup> <code>[System.Environment]::OSVersion.Version</code> (requires .NET Framework 1.1 or later, format: Major.Minor)
                        <br /><sup>3</sup> Has to be installed through Server Manager
                        <br /><sup>4</sup> Also integrated in all later Windows versions
                        <br /><sup>5</sup> Release date of public review
                        <br /><sup>6</sup> Platform ID = 0
                        <br /><sup>7</sup> Platform ID = 1 (whereas on NT 3.51 and later the Platform ID ≥ 2)</p>
                        <p>Sources: <a href="https://4sysops.com/archives/powershell-versions-and-their-windows-version/">PowerShell versions and their Windows version</a>, <a href="http://www.vb-helper.com/howto_net_os_version.html">Get operating system information in VB .NET</a> and <a href="https://social.msdn.microsoft.com/Forums/vstudio/en-US/5956c04f-072a-406c-ae6a-cc8b3a207936/systemenvironmentosversionversionmajor?forum=csharpgeneral">System.Environment.OSVersion.Version.Major</a></p>
                    </ol></li>
                </p>
                <p>
                    <li>Please note that this script will try to check whether it is run in an elevated PowerShell window (run as an administrator) or not when executed on a Windows 8 or a Windows Server 2012 machine or later.</li>
                </p>
                <p>
                    <li>Please note that the CSV-file is created in a directory, which is specified with the <code>$path</code> variable (at line 6). The <code>$env:temp</code> variable points to the current temp folder. The default value of the <code>$env:temp</code> variable is <code>C:\Users\&lt;username&gt;\AppData\Local\Temp</code> (i.e. each user account has their own separate temp folder at path <code>%USERPROFILE%\AppData\Local\Temp</code>). To see the current temp path, for instance a command
                    <br />
                    <br /><code>[System.IO.Path]::GetTempPath()</code>
                    <br />
                    <br />may be used at the PowerShell prompt window <code>[PS>]</code>. To change the temp folder for instance to <code>C:\Temp</code>, please, for example, follow the instructions at <a href="http://www.eightforums.com/tutorials/23500-temporary-files-folder-change-location-windows.html">Temporary Files Folder - Change Location in Windows</a>, which in essence are something along the lines:
                        <ol>
                           <li>Right click on Computer and click on Properties (or select Start → Control Panel → System). In the resulting window with the basic information about the computer...</li>
                           <li>Click on Advanced system settings on the left panel and select Advanced tab on the resulting pop-up window.</li>
                           <li>Click on the button near the bottom labeled Environment Variables.</li>
                           <li>In the topmost section labeled User variables both TMP and TEMP may be seen. Each different login account is assigned its own temporary locations. These values can be changed by double clicking a value or by highlighting a value and selecting Edit. The specified path will be used by Windows and many other programs for temporary files. It's advisable to set the same value (a directory path) for both TMP and TEMP.</li>
                           <li>Any running programs need to be restarted for the new values to take effect. In fact, probably also Windows itself needs to be restarted for it to begin using the new values for its own temporary files.</li>
                        </ol>
                    </li>
                </p>
            </ul>
        </td>
    </tr>
</table>




### Examples

<table>
    <tr>
        <th>:book:</th>
        <td style="padding:6px">To open this code in Windows PowerShell, for instance:</td>
   </tr>
   <tr>
        <th></th>
        <td style="padding:6px">
            <ol>
                <p>
                    <li><code>./Get-InstalledPrograms</code><br />
                    Run the script. Please notice to insert <code>./</code> or <code>.\</code> before the script name.</li>
                </p>
                <p>
                    <li><code>help ./Get-InstalledPrograms -Full</code><br />
                    Display the help file.</li>
                </p>
                <p>
                    <li><p><code>Set-ExecutionPolicy remotesigned</code><br />
                    This command is altering the Windows PowerShell rights to enable script execution for the default (LocalMachine) scope. Windows PowerShell has to be run with elevated rights (run as an administrator) to actually be able to change the script execution properties. The default value of the default (LocalMachine) scope is "<code>Set-ExecutionPolicy restricted</code>".</p>
                        <p>Parameters:
                                <ol>
                                    <table>
                                        <tr>
                                            <td style="padding:6px"><code>Restricted</code></td>
                                            <td style="padding:6px">Does not load configuration files or run scripts. Restricted is the default execution policy.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>AllSigned</code></td>
                                            <td style="padding:6px">Requires that all scripts and configuration files be signed by a trusted publisher, including scripts that you write on the local computer.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>RemoteSigned</code></td>
                                            <td style="padding:6px">Requires that all scripts and configuration files downloaded from the Internet be signed by a trusted publisher.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Unrestricted</code></td>
                                            <td style="padding:6px">Loads all configuration files and runs all scripts. If you run an unsigned script that was downloaded from the Internet, you are prompted for permission before it runs.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Bypass</code></td>
                                            <td style="padding:6px">Nothing is blocked and there are no warnings or prompts.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Undefined</code></td>
                                            <td style="padding:6px">Removes the currently assigned execution policy from the current scope. This parameter will not remove an execution policy that is set in a Group Policy scope.</td>
                                        </tr>
                                    </table>
                                </ol>
                        </p>
                    <p>For more information, please type "<code>Get-ExecutionPolicy -List</code>", "<code>help Set-ExecutionPolicy -Full</code>", "<code>help about_Execution_Policies</code>" or visit <a href="https://technet.microsoft.com/en-us/library/hh849812.aspx">Set-ExecutionPolicy</a> or <a href="http://go.microsoft.com/fwlink/?LinkID=135170.">about_Execution_Policies</a>.</p>
                    </li>
                </p>
                <p>
                    <li><code>New-Item -ItemType File -Path C:\Temp\Get-InstalledPrograms.ps1</code><br />
                    Creates an empty ps1-file to the <code>C:\Temp</code> directory. The <code>New-Item</code> cmdlet has an inherent <code>-NoClobber</code> mode built into it, so that the procedure will halt, if overwriting (replacing the contents) of an existing file is about to happen. Overwriting a file with the <code>New-Item</code> cmdlet requires using the <code>Force</code>. If the path name includes space characters, please enclose the path name in quotation marks (single or double):
                        <ol>
                            <br /><code>New-Item -ItemType File -Path "C:\Folder Name\Get-InstalledPrograms.ps1"</code>
                        </ol>
                    <br />For more information, please type "<code>help New-Item -Full</code>".</li>
                </p>
            </ol>
        </td>
    </tr>
</table>




### Contributing

<p>Find a bug? Have a feature request? Here is how you can contribute to this project:</p>

 <table>
   <tr>
      <th><img class="emoji" title="contributing" alt="contributing" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f33f.png"></th>
      <td style="padding:6px"><strong>Bugs:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-programs/issues">Submit bugs</a> and help us verify fixes.</td>
   </tr>
   <tr>
      <th rowspan="2"></th>
      <td style="padding:6px"><strong>Feature Requests:</strong></td>
      <td style="padding:6px">Feature request can be submitted by <a href="https://github.com/auberginehill/get-installed-programs/issues">creating an Issue</a>.</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Edit Source Files:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-programs/pulls">Submit pull requests</a> for bug fixes and features and discuss existing proposals.</td>
   </tr>
 </table>




### www

<table>
    <tr>
        <th><img class="emoji" title="www" alt="www" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f310.png"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-programs">Script Homepage</a></td>
    </tr>
    <tr>
        <th rowspan="8"></th>
        <td style="padding:6px">Tobias Weltner: <a href="http://powershell.com/cs/PowerTips_Monthly_Volume_8.pdf#IDERA-1702_PS-PowerShellMonthlyTipsVol8-jan2014">PowerTips Monthly vol 8 January 2014</a> (or one of the <a href="https://web.archive.org/web/20150110213108/http://powershell.com/cs/media/p/30542.aspx">archive.org versions</a>)</td>
    </tr>
    <tr>
        <td style="padding:6px">chocolatey: <a href="https://chocolatey.org/packages/flashplayerplugin">Flash Player Plugin</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://www.credera.com/blog/technology-insights/perfect-progress-bars-for-powershell/">Perfect Progress Bars for PowerShell</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://msdn.microsoft.com/en-us/library/aa393941(v=vs.85).aspx">Uninstall method of the Win32_Product class</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="http://stackoverflow.com/questions/29266622/how-to-run-exe-with-without-elevated-privileges-from-powershell?rq=1">How to run exe with/without elevated privileges from PowerShell</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://4sysops.com/archives/powershell-versions-and-their-windows-version/">PowerShell versions and their Windows version</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="http://www.vb-helper.com/howto_net_os_version.html">Get operating system information in VB .NET</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://social.msdn.microsoft.com/Forums/vstudio/en-US/5956c04f-072a-406c-ae6a-cc8b3a207936/systemenvironmentosversionversionmajor?forum=csharpgeneral">System.Environment.OSVersion.Version.Major</a></td>
    </tr>
</table>




### Related scripts

 <table>
    <tr>
        <th><img class="emoji" title="www" alt="www" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/0023-20e3.png"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/firefox-customization-files">Firefox Customization Files</a></td>
    </tr>
    <tr>
        <th rowspan="16"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-ascii-table">Get-AsciiTable</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-battery-info">Get-BatteryInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-computer-info">Get-ComputerInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-culture-tables">Get-CultureTables</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-directory-size">Get-DirectorySize</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-windows-updates">Get-InstalledWindowsUpdates</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-ram-info">Get-RAMInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/eb07d0c781c09ea868123bf519374ee8">Get-TimeDifference</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-time-zone-table">Get-TimeZoneTable</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-unused-drive-letters">Get-UnusedDriveLetters</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/emoji-table">Emoji Table</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/java-update">Java-Update</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/rock-paper-scissors">Rock-Paper-Scissors</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/toss-a-coin">Toss-a-Coin</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/update-adobe-flash-player">Update-AdobeFlashPlayer</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/update-mozilla-firefox">Update-MozillaFirefox</a></td>
    </tr>
</table>
