# 全局 Obsidian 配置同步脚本 (Symlink/Junction 版本)
# 此脚本将使用目录链接（Junctions）将你的数学仓库配置作为全局模板
# 当你在数学仓库更新插件或主题时，其他所有链接的仓库会自动更新！

param(
    [string]$TargetVault = (Get-Location).Path,
    [string]$MasterVault = "D:\22408Study\数学"
)

Write-Host "正在将 [$MasterVault] 的配置链接到 [$TargetVault]..." -ForegroundColor Cyan

# 确保目标仓库有 .obsidian 文件夹
$targetObsidian = Join-Path $TargetVault ".obsidian"
if (-not (Test-Path $targetObsidian)) {
    New-Item -ItemType Directory -Path $targetObsidian -Force | Out-Null
}

# 要做链接的共享文件夹
$sharedFolders = @("plugins", "themes", "snippets", "copilot", ".smart-env")

foreach ($folder in $sharedFolders) {
    $sourcePath = Join-Path $MasterVault ".obsidian\$folder"
    $targetPath = Join-Path $targetObsidian $folder

    # 1. 检查主仓库是否有这个文件夹
    if (Test-Path $sourcePath) {
        
        # 2. 如果目标仓库已经有同名文件/文件夹，先删除它
        if (Test-Path $targetPath) {
            Remove-Item -Path $targetPath -Recurse -Force
        }

        # 3. 创建目录链接 (Junction)
        # 这样目标仓库的对应文件夹实际上就是主仓库的文件夹
        cmd /c mklink /J "`"$targetPath`"" "`"$sourcePath`""
        Write-Host "✓ 已链接: $folder -> 主仓库" -ForegroundColor Green
    }
}

# 要复制（而不是链接）的配置文件，因为每个仓库可能需要独立的开关状态
$configFiles = @("appearance.json", "community-plugins.json", "core-plugins.json", "app.json")
foreach ($file in $configFiles) {
    $sourceFile = Join-Path $MasterVault ".obsidian\$file"
    $targetFile = Join-Path $targetObsidian $file
    
    if (Test-Path $sourceFile) {
        if (-not (Test-Path $targetFile)) {
            Copy-Item -Path $sourceFile -Destination $targetFile -Force
            Write-Host "✓ 已复制: $file" -ForegroundColor Green
        } else {
            Write-Host "○ 已存在 (未覆盖): $file" -ForegroundColor Yellow
        }
    }
}

Write-Host "`n✅ 配置完成！" -ForegroundColor Green
Write-Host "现在 $TargetVault 的插件和主题已与数学仓库实时同步！" -ForegroundColor Cyan
