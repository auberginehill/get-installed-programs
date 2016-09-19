<!-- Visual Studio Code: For a more comfortable reading experience, use the key combination Ctrl + Shift + V 


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
      <td style="padding:6px">Get-InstalledPrograms queries the Windows registry for installed programs. The keys from <code>HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\</code> and <code>HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\</code> are read on 64-bit computers and on the 32-bit computers only the latter path is accessed. Basic program related properties, such as Name, Version, Install Date, Publisher, Comments, Contact, Icon, Estimated Size, Help Link, Install Location, Install Source, Language, Modify Path, NoModify, NoRepair, Partner Code, PSChildName, PSDrive, PSProvider, Uninstall String, URL Info (About), URL Update Info, Version (Real), Version Major, Version Minor and Windows Installer are displayed in console, written to a CSV-file and displayed in a pop-up window (Out-Gridview).
      <br />
      <br />The enumeration of installed programs in a Windows machine may take some time - therefore a progress bar is included in Get-InstalledPrograms for monitoring the steps taken. Also, after the Get-InstalledPrograms is finished, a rudimentary summary about the performance of the machine is shown. Similarly, in "Code snippet 1" is described what is not included in Get-InstalledPrograms. The "<code>Get-WmiObject -Class Win32_Product</code>" query method was discarded mainly due to the excessive long running times.
      <br />
      <br />On the other hand, as described in "Code snippet 2", if it is relevant to find out, weather a particular version of a known program is installed or not, the here unused function Check-InstalledSoftware could be called to action (the code is taken from <a href="https://github.com/auberginehill/update-adobe-flash-player">https://github.com/auberginehill/update-adobe-flash-player</a>" and is quite quick):
      <br />
      <br /><code>Check-InstalledSoftware "Adobe Flash Player 23 NPAPI" 23.0.0.162</code>
      <br />
      <br />will return all the aforementioned info on the queried program, if it is installed, but returs a null value, if such a program doesn't exist on the machine.</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Homepage:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-programs">https://github.com/auberginehill/get-installed-programs</a></td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Version:</strong></td>
      <td style="padding:6px">1.0</td>
   </tr>
   <tr>
        <td style="padding:6px"><strong>Sources:</strong></td>
        <td style="padding:6px">
            <table>
                <tr>
                    <td style="padding:6px">Emojis:</td>
                    <td style="padding:6px"><a href="https://api.github.com/emojis">https://api.github.com/emojis</a></td>
                </tr>                    
                <tr>
                    <td style="padding:6px">Tobias Weltner:</td>                
                    <td style="padding:6px"><a href="http://powershell.com/cs/PowerTips_Monthly_Volume_8.pdf#IDERA-1702_PS-PowerShellMonthlyTipsVol8-jan2014">PowerTips Monthly vol 8 January 2014</a> (or one of the <a href="https://web.archive.org/web/20150110213108/http://powershell.com/cs/media/p/30542.aspx">archive.org versions</a>)</td>                
                </tr>
                <tr>
                    <td style="padding:6px">chocolatey:</td>                
                    <td style="padding:6px"><a href="https://chocolatey.org/packages/flashplayerplugin">Flash Player Plugin</a></td>  
                </tr>
            </table>
        </td>
   </tr> 
   <tr>
      <td style="padding:6px"><strong>Downloads:</strong></td>
      <td style="padding:6px">For instance <a href="https://raw.githubusercontent.com/auberginehill/get-installed-programs/master/Get-InstalledPrograms.ps1">Get-InstalledPrograms.ps1</a>. Or <a href="https://github.com/auberginehill/get-installed-programs/archive/master.zip">everything as a .zip-file</a>.</td>
   </tr> 
</table>




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
                    <li>One pop-up window "$obj_installed_programs_selection_all" (Out-GridView):</li>
                </p>
                <ol>
                    <p>
                        <table>
                            <tr>
                                <td style="padding:6px"><strong>Name</strong></td>
                                <td style="padding:6px"><strong>Description</strong></td>
                            </tr>
                            <tr>
                                <td style="padding:6px">$obj_installed_programs_selection_all</a></td>
                                <td style="padding:6px">Enumerates the found installed programs</td>
                            </tr>
                        </table>
                    </p>
                </ol>
                <p>
                    <li>And also one CSV-file at $path.</li>
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
                <li>Please note that the CSV-file is created in a directory, which is specified with the <code>$path</code> variable (at line 6).</li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>The <code>$env:temp</code> variable points to the current temp folder. The default value of the <code>$env:temp</code> variable is <code>C:\Users\&lt;username&gt;\AppData\Local\Temp</code> (i.e. each user account has their own separate temp folder at path <code>%USERPROFILE%\AppData\Local\Temp</code>). To see the current temp path, for instance a command
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
                    This command is altering the Windows PowerShell rights to enable script execution. Windows PowerShell has to be run with elevated rights (run as an administrator) to actually be able to change the script execution properties. The default value is "<code>Set-ExecutionPolicy restricted</code>".</p>
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
                    <p>For more information, please type "<code>help Set-ExecutionPolicy -Full</code>" or visit <a href="https://technet.microsoft.com/en-us/library/hh849812.aspx">Set-ExecutionPolicy</a>.</p>
                    </li>
                </p>
                <p>
                    <li><code>New-Item -ItemType File -Path C:\Temp\Get-InstalledPrograms.ps1</code><br />
                    Creates an empty ps1-file to the <code>C:\Temp</code> directory. The <code>New-Item</code> cmdlet has an inherent <code>-NoClobber</code> mode built into it, so that the procedure will halt, if overwriting (replacing the contents) of an existing file is about to happen. Overwriting a file with the <code>New-Item</code> cmdlet requires using the <code>Force</code>.<br /> 
                    For more information, please type "<code>help New-Item -Full</code>".</li>
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
        <td style="padding:6px">chocolatey:</td>                
        <td style="padding:6px"><a href="https://chocolatey.org/packages/flashplayerplugin">Flash Player Plugin</a></td>  
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://www.credera.com/blog/technology-insights/perfect-progress-bars-for-powershell/">Perfect Progress Bars for PowerShell</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://msdn.microsoft.com/en-us/library/aa393941(v=vs.85).aspx">Uninstall method of the Win32_Product class</a></td>
    </tr>
</table>




### Related scripts

 <table>
    <tr>
        <th><img class="emoji" title="www" alt="www" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/0023-20e3.png"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-battery-info">Get-BatteryInfo</a></td>
    </tr>
    <tr>
        <th rowspan="6"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-computer-info">Get-ComputerInfo</a></td>    
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
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-unused-drive-letters">Get-UnusedDriveLetters</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/update-adobe-flash-player">Update-AdobeFlashPlayer</a></td>
    </tr>
</table>
