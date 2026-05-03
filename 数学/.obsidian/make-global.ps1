param(
    [string]$TargetVault = (Get-Location).Path,
    [string]$MasterVault = "D:\22408Study\数学"
)

Write-Host ""
Write-Host "============== Obsidian Global Config Sync ==============" -ForegroundColor Cyan
Write-Host "Target Vault: $TargetVault"
Write-Host "Master Vault: $MasterVault"
Write-Host "========================================================="
Write-Host ""

if ($TargetVault -eq $MasterVault) {
    Write-Host "Error: Target vault cannot be the same as Master vault! Please run this script inside the NEW vault directory." -ForegroundColor Red
    Exit
}

# 1. Ensure target .obsidian directory exists
$targetObsidian = Join-Path $TargetVault ".obsidian"
if (-not (Test-Path $targetObsidian)) {
    New-Item -ItemType Directory -Path $targetObsidian -Force | Out-Null
}

# 2. Link shared folders (Junctions)
$sharedFolders = @(
    ".obsidian\plugins",
    ".obsidian\themes",
    ".smart-env",
    "copilot"
)

foreach ($folder in $sharedFolders) {
    $sourcePath = Join-Path $MasterVault $folder
    $targetPath = Join-Path $TargetVault $folder
    
    if (Test-Path $sourcePath) {
        if (Test-Path $targetPath) {
            Remove-Item -Path $targetPath -Recurse -Force -ErrorAction SilentlyContinue
        }
        
        $targetParent = Split-Path $targetPath -Parent
        if (-not (Test-Path $targetParent)) {
            New-Item -ItemType Directory -Path $targetParent -Force | Out-Null
        }

        cmd /c mklink /J "`"$targetPath`"" "`"$sourcePath`"" | Out-Null
        Write-Host "SUCCESS: Linked folder -> $folder" -ForegroundColor Green
    }
}

# 3. Copy isolated settings files (Only if they don't exist yet)
$isolatedFiles = @(
    ".obsidian\appearance.json",
    ".obsidian\community-plugins.json",
    ".obsidian\core-plugins.json",
    ".obsidian\app.json"
)

foreach ($file in $isolatedFiles) {
    $sourceFile = Join-Path $MasterVault $file
    $targetFile = Join-Path $TargetVault $file
    
    if ((Test-Path $sourceFile) -and (-not (Test-Path $targetFile))) {
        Copy-Item -Path $sourceFile -Destination $targetFile -Force
        Write-Host "SUCCESS: Copied config file -> $file" -ForegroundColor Blue
    }
}

Write-Host ""
Write-Host "ALL DONE!" -ForegroundColor Green
Write-Host "Restart your Obsidian and everything should work perfectly."
Write-Host "Plugins, Themes, Copilot and Smart Env are now synced globally with the Master vault."
Write-Host ""
