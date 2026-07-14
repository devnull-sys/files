Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Stop-Service -Name eventlog -Force -ErrorAction SilentlyContinue

Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\Shell" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage" -Recurse -Force -ErrorAction SilentlyContinue

Clear-DnsClientCache -ErrorAction SilentlyContinue

Remove-Item -Path "C:\Windows\System32\winevt\Logs\*.evtx" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\appcompat\pca*.txt" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\System32\sru\SRUDB.dat" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine*.txt" -Force -ErrorAction SilentlyContinue
Remove-Item -path "$env:USERPROFILE\AppData\Local\FiveM\FiveM.app\logs\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -path "$env:USERPROFILE\AppData\Local\FiveM\FiveM.app\crashes\*" -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem -Path "$env:USERPROFILE\AppData\Local\CrashDumps" -Recurse -File | Where-Object { $_.Name -like "*installer*" } | Remove-Item -Force -ErrorAction SilentlyContinue

rundll32.exe apphelp.dll,ShimFlushCache

Start-Process explorer.exe -ErrorAction SilentlyContinue
Start-Service -Name eventlog -ErrorAction SilentlyContinue
