Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Stop-Service -Name eventlog -Force -ErrorAction SilentlyContinue

Start-Process explorer.exe -ErrorAction SilentlyContinue
Start-Service -Name eventlog -ErrorAction SilentlyContinue
