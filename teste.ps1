# prank.ps1
# ----------------------------
# Harmless “troll” script for Windows: opens Notepad, shows pop-ups, and moves the mouse randomly.
# Save this as prank.ps1 and launch with:
#   powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\Users\Public\prank.ps1"
# ----------------------------

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Show-RandomPopup {
    $titles   = @("Hey there!", "Surprise!", "Gotcha!", "👻 Boo!")
    $messages = @(
        "Your PC is haunted... 👻",
        "Did you really do this?",
        "I see you typing...",
        "You shouldn't have clicked that!"
    )
    $rndTitle   = $titles   | Get-Random
    $rndMessage = $messages | Get-Random

    [System.Windows.Forms.MessageBox]::Show(
        $rndMessage,
        $rndTitle,
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    )
}

while ($true) {
    $np = Start-Process -FilePath "notepad.exe" -PassThru
    Start-Sleep -Milliseconds 500

    [System.Windows.Forms.SendKeys]::SendWait("Hello from Pico!{ENTER}This is just a friendly prank...{ENTER}")

    Start-Sleep -Seconds 2

    Show-RandomPopup

    Start-Sleep -Milliseconds (Get-Random -Minimum 800 -Maximum 1600)

    $screenWidth  = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width
    $screenHeight = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height
    $rndX = Get-Random -Minimum 0 -Maximum $screenWidth
    $rndY = Get-Random -Minimum 0 -Maximum $screenHeight
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($rndX, $rndY)

    Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 3)
}
