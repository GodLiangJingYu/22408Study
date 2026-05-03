# Obsidian 全局配置实时同步工具 (Symlink/Junction)

param(
    [string]$TargetVault = (Get-Location).Path,
    [string]$MasterVault = "D:\22408Study\数学"
)

Write-Host "============== Obsidian 全局同步 ==============" -ForegroundColor Cyan
Write-Host "目标仓库: $TargetVault"
Write-Host "主仓库 (模板): $MasterVault"
Write-Host "==============================================="

# 确保目标仓库存在基础文件夹
$targetObsidian = Join-Path $TargetVault ".obsidian"
if (-not (Test-Path $targetObsidian)) {
    New-Item -ItemType Directory -Path $targetObsidian -Force | Out-Null
}

# ========== 第一部分：创建实时链接 (Junctions) ==========
# 这些文件夹将被映射到主仓库，你在任何一个仓库里安装插件、更新配置，其他仓库立刻生效！

# 1. 链接 .obsidian 下的资源
$obsidianLinks = @("plugins", "themes", "snippets")
foreach ($folder in $obsidianLinks) {
    $source = Join-Path $MasterVault ".obsidian\$folder"
    $target = Join-Path $targetObsidian $folder
    
    if (Test-Path $source) {
        if (Test-Path $target) { Remove-Item -Path $target -Recurse -Force }
        cmd /c mklink /J "`"$target`"" "`"$source`""
        Write-Host "✓ [实时同步] .obsidian/$folder" -ForegroundColor Green
    }
}

# 2. 链接 .smart-env (智能环境配置)
$sourceSmartEnv = Join-Path $MasterVault ".smart-env"
$targetSmartEnv = Join-Path $TargetVault ".smart-env"
if (Test-Path $sourceSmartEnv) {
    if (Test-Path $targetSmartEnv) { Remove-Item -Path $targetSmartEnv -Recurse -Force }
    cmd /c mklink /J "`"$targetSmartEnv`"" "`"$sourceSmartEnv`""
    Write-Host "✓ [实时同步] .smart-env (配置)" -ForegroundColor Green
}

# 3. 链接 copilot (Copilot 自定义提示词等)
$sourceCopilot = Join-Path $MasterVault "copilot"
$targetCopilot = Join-Path $TargetVault "copilot"
if (Test-Path $sourceCopilot) {
    if (Test-Path $targetCopilot) { Remove-Item -Path $targetCopilot -Recurse -Force }
    cmd /c mklink /J "`"$targetCopilot`"" "`"$sourceCopilot`""
    Write-Host "✓ [实时同步] copilot (提示词)" -ForegroundColor Green
}

# ========== 第二部分：复制初始配置 ==========
# 配置文件不能链接，否则开关某个插件会影响所有仓库。我们只做首次复制。

$configFiles = @("appearance.json", "community-plugins.json", "core-plugins.json", "app.json")
foreach ($file in $configFiles) {
    $sourceFile = Join-Path $MasterVault ".obsidian\$file"
    $targetFile = Join-Path $targetObsidian $file
    
    if (Test-Path $sourceFile -and -not (Test-Path $targetFile)) {
        Copy-Item -Path $sourceFile -Destination $targetFile -Force
        Write-Host "✓ [初始复制] $file" -ForegroundColor Green
    }
}

Write-Host "`n🎉 同步设置完成！" -ForegroundColor Cyan
Write-Host "你的插件、主题、.smart-env 和 copilot 配置现在是全局实时同步的了。"
Write-Host "请完全重启 Obsidian 即可生效。" -ForegroundColor Yellow