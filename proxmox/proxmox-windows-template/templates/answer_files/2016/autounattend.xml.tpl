<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
    <settings pass="windowsPE">
        <component name="Microsoft-Windows-PnpCustomizationsWinPE" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" processorArchitecture="amd64" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <DriverPaths>
                <PathAndCredentials wcm:action="add" wcm:keyValue="2">
                    <Path>F:\viostor\2k16\amd64</Path>
                </PathAndCredentials>

                <PathAndCredentials wcm:action="add" wcm:keyValue="3">
                    <Path>F:\NetKVM\2k16\amd64</Path>
                </PathAndCredentials>

                <PathAndCredentials wcm:action="add" wcm:keyValue="4">
                    <Path>F:\Balloon\2k16\amd64</Path>
                </PathAndCredentials>

                <PathAndCredentials wcm:action="add" wcm:keyValue="5">
                    <Path>F:\pvpanic\2k16\amd64</Path>
                </PathAndCredentials>

                <PathAndCredentials wcm:action="add" wcm:keyValue="6">
                    <Path>F:\qemupciserial\2k16\amd64</Path>
                </PathAndCredentials>

                <PathAndCredentials wcm:action="add" wcm:keyValue="7">
                    <Path>F:\qxldod\2k16\amd64</Path>
                </PathAndCredentials>

                <PathAndCredentials wcm:action="add" wcm:keyValue="8">
                    <Path>F:\vioinput\2k16\amd64</Path>
                </PathAndCredentials>

                <PathAndCredentials wcm:action="add" wcm:keyValue="9">
                    <Path>F:\viorng\2k16\amd64</Path>
                </PathAndCredentials>

                <PathAndCredentials wcm:action="add" wcm:keyValue="10">
                    <Path>F:\vioscsi\2k16\amd64</Path>
                </PathAndCredentials>

                <PathAndCredentials wcm:action="add" wcm:keyValue="11">
                    <Path>F:\vioserial\2k16\amd64</Path>
                </PathAndCredentials>
            </DriverPaths>
        </component>           
        <component name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <SetupUILanguage>
                <UILanguage>en-US</UILanguage>
            </SetupUILanguage>
            <InputLocale>en-US</InputLocale>
            <SystemLocale>en-US</SystemLocale>
            <UILanguage>en-US</UILanguage>
            <UILanguageFallback>en-US</UILanguageFallback>
            <UserLocale>en-US</UserLocale>
        </component>
        <component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <DiskConfiguration>
                <Disk wcm:action="add">
                    <CreatePartitions>
                        <CreatePartition wcm:action="add">
                            <Order>1</Order>
                            <Type>Primary</Type>
                            <Extend>true</Extend>
                        </CreatePartition>
                    </CreatePartitions>
                    <ModifyPartitions>
                        <ModifyPartition wcm:action="add">
                            <Format>NTFS</Format>
                            <Label>System</Label>
                            <Letter>C</Letter>
                            <Order>1</Order>
                            <PartitionID>1</PartitionID>
                        </ModifyPartition>
                    </ModifyPartitions>
                    <DiskID>0</DiskID>
                    <WillWipeDisk>true</WillWipeDisk>
                </Disk>
            </DiskConfiguration>
            <ImageInstall>
                <OSImage>
                    <InstallFrom>
                        <MetaData wcm:action="add">
                            <Key>/IMAGE/NAME</Key>
                            <Value>Windows Server {{windows_server_version}} {{windows_server_edition}}</Value>
                        </MetaData>
                    </InstallFrom>
                    <InstallTo>
                        <DiskID>0</DiskID>
                        <PartitionID>1</PartitionID>
                    </InstallTo>
                </OSImage>
            </ImageInstall>
            <UserData>
                <!-- Product Key from https://www.microsoft.com/de-de/evalcenter/evaluate-windows-server-technical-preview?i=1 -->
                <ProductKey>
                    <!-- Do not uncomment the Key element if you are using trial ISOs -->
                    <!-- You must uncomment the Key element (and optionally insert your own key) if you are using retail or volume license ISOs -->
                    <!-- <Key>6XBNX-4JQGW-QX6QG-74P76-72V67</Key> -->
                    <WillShowUI>OnError</WillShowUI>
                </ProductKey>
                <AcceptEula>true</AcceptEula>
                <FullName>Administrator</FullName>
                <Organization>{{org_name}}</Organization>
            </UserData>
        </component>
    </settings>
    <settings pass="specialize">
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <OEMInformation>
                <HelpCustomized>false</HelpCustomized>
            </OEMInformation>
            <ComputerName>*</ComputerName>
            <TimeZone>{{vm_time_zone}}</TimeZone>
            <RegisteredOwner/>
        </component>
        <component name="Microsoft-Windows-TerminalServices-LocalSessionManager" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <fDenyTSConnections>false</fDenyTSConnections>
        </component>
        <component name="Networking-MPSSVC-Svc" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="NonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <FirewallGroups>
                <FirewallGroup wcm:action="add" wcm:keyValue="RemoteDesktop">
                    <Active>true</Active>
                    <Group>Remote Desktop</Group>
                    <Profile>all</Profile>
                </FirewallGroup>
            </FirewallGroups>
        </component>
        <component name="Microsoft-Windows-TerminalServices-RDP-WinStationExtensions" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <SecurityLayer>1</SecurityLayer>
            <UserAuthentication>0</UserAuthentication>
        </component>        
        <component name="Microsoft-Windows-ServerManager-SvrMgrNc" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <DoNotOpenServerManagerAtLogon>true</DoNotOpenServerManagerAtLogon>
        </component>
        <component name="Microsoft-Windows-IE-ESC" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <IEHardenAdmin>false</IEHardenAdmin>
            <IEHardenUser>false</IEHardenUser>
        </component>
        <component name="Microsoft-Windows-OutOfBoxExperience" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <DoNotOpenInitialConfigurationTasksAtLogon>true</DoNotOpenInitialConfigurationTasksAtLogon>
        </component>
        <component name="Microsoft-Windows-Security-SPP-UX" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <SkipAutoActivation>true</SkipAutoActivation>
        </component>                  
    </settings>
    <settings pass="oobeSystem">
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <AutoLogon>
                <Username>administrator</Username>
                <Password>
                    <Value>temporary</Value>
                    <PlainText>true</PlainText>
                </Password>
                <Enabled>true</Enabled>
                <LogonCount>3</LogonCount>
            </AutoLogon>            
            <FirstLogonCommands>
                <SynchronousCommand wcm:action="add">
                    <CommandLine>%SystemRoot%\System32\reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff /f</CommandLine>
                    <Order>1</Order>
                    <Description>Disable Network Discovery Prompt</Description>
                </SynchronousCommand>
{% if vm_guest_agent is match("enabled=1") %}
                <SynchronousCommand wcm:action="add">
                    <CommandLine>msiexec /package F:\guest-agent\qemu-ga-x86_64.msi /quiet</CommandLine>
                    <Order>2</Order>
                    <Description>Install qemu-guest-agent</Description>
                </SynchronousCommand>
{% endif %}  
                <SynchronousCommand wcm:action="add">
                    <CommandLine>msiexec /package F:\virtio-win-gt-x64.msi /quiet</CommandLine>
                    <Order>3</Order>
                    <Description>Install qemu-guest-agent</Description>
                </SynchronousCommand>    
                <SynchronousCommand wcm:action="add">
                    <CommandLine>Xcopy /E /I E:\OpenSSH-Win64 C:\OpenSSH</CommandLine>
                    <Order>4</Order>
                    <Description>Copy OpenSSH to the target</Description>
                </SynchronousCommand>
                <SynchronousCommand wcm:action="add">
                    <CommandLine>powershell -File C:\OpenSSH\install-sshd.ps1</CommandLine>
                    <Description>Install OpenSSH</Description>
                    <Order>5</Order>
                </SynchronousCommand>
                <SynchronousCommand wcm:action="add">
                    <CommandLine>cmd.exe /c sc config sshd start= auto</CommandLine>
                    <Description>sshd autostart</Description>
                    <Order>6</Order>
                    <RequiresUserInput>true</RequiresUserInput>
                </SynchronousCommand> 
                <SynchronousCommand wcm:action="add">
                    <CommandLine>cmd.exe /c sc config ssh-agent start= auto</CommandLine>
                    <Description>ssh agent autostart</Description>
                    <Order>7</Order>
                    <RequiresUserInput>true</RequiresUserInput>
                </SynchronousCommand> 
                <SynchronousCommand wcm:action="add">
                    <CommandLine>cmd.exe /c netsh advfirewall set allprofiles state off</CommandLine>
                    <Description>disable firewall</Description>
                    <Order>8</Order>
                    <RequiresUserInput>true</RequiresUserInput>
                </SynchronousCommand> 
                <SynchronousCommand wcm:action="add">
                    <CommandLine>c:\windows\system32\sysprep\sysprep /generalize /oobe /shutdown</CommandLine>
                    <Description>Sysprep</Description>
                    <Order>9</Order>
                </SynchronousCommand>                                
            </FirstLogonCommands>
            <OOBE>
                <HideEULAPage>true</HideEULAPage>
                <HideLocalAccountScreen>true</HideLocalAccountScreen>
                <HideOEMRegistrationScreen>true</HideOEMRegistrationScreen>
                <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
                <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
                <NetworkLocation>Home</NetworkLocation>
                <ProtectYourPC>1</ProtectYourPC>
            </OOBE>
            <UserAccounts>
                <AdministratorPassword>
                    <Value>temporary</Value>
                    <PlainText>true</PlainText>
                </AdministratorPassword>
            </UserAccounts>
            <RegisteredOwner />
        </component>
    </settings>
    <settings pass="offlineServicing">
        <component name="Microsoft-Windows-LUA-Settings" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <EnableLUA>false</EnableLUA>
        </component>
    </settings>
    <cpi:offlineImage cpi:source="wim:c:/wim/install.wim#Windows Server {{windows_server_version}} {{windows_server_edition}}" xmlns:cpi="urn:schemas-microsoft-com:cpi" />
</unattend>
