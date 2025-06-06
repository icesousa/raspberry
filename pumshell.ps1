while ($true) {
    Start-Sleep -Seconds (Get-Random -Minimum 10 -Maximum 60)
    $player = New-Object System.Media.SoundPlayer
    $player.SoundLocation = "C:\temp\fart_sound.wav"
    $player.Play()
    Start-Sleep -Seconds 1
}