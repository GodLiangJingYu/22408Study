# 在新 Obsidian 仓库中启用全局插件和主题
# 运行此脚本后，重启 Obsidian 即可

param(
    [string]$VaultPath = (Get-Location).Path
)

Write-Host "正在配置 Obsidian 全局插件/主题..." -ForegroundColor Cyan
Write-Host "目标仓库：$VaultPath" -ForegroundColor Gray

# 创建 .obsidian 目录
$obsidianDir = Join-Path $VaultPath ".obsidian"
if (-not (Test-Path $obsidianDir)) {
    New-Item -ItemType Directory -Path $obsidianDir -Force | Out-Null
    Write-Host "✓ 创建 .obsidian 目录" -ForegroundColor Green
}

# 复制配置文件（如果不存在）
$configFiles = @("appearance.json", "community-plugins.json", "core-plugins.json")
foreach ($file in $configFiles) {
    $source = "D:\22408Study\数学\.obsidian\$file"
    $dest = Join-Path $obsidianDir $file
    if (-not (Test-Path $dest)) {
        Copy-Item -Path $source -Destination $dest -Force
        Write-Host "✓ 复制 $file" -ForegroundColor Green
    } else {
        Write-Host "○ $file 已存在，跳过" -ForegroundColor Yellow
    }
}

# 删除本地 plugins 和 themes 文件夹（强制使用全局）
$localPlugins = Join-Path $obsidianDir "plugins"
$localThemes = Join-Path $obsidianDir "themes"

if (Test-Path $localPlugins) {
    Remove-Item -Path $localPlugins -Recurse -Force
    Write-Host "✓ 删除本地 plugins 文件夹（使用全局）" -ForegroundColor Green
}

if (Test-Path $localThemes) {
    Remove-Item -Path $localThemes -Recurse -Force
    Write-Host "✓ 删除本地 themes 文件夹（使用全局）" -ForegroundColor Green
}

Write-Host "`n✅ 配置完成！" -ForegroundColor Green
Write-Host "请重启 Obsidian 以应用更改" -ForegroundColor Cyan
Write-Host "`n全局插件位置：%APPDATA%\obsidian\plugins\" -ForegroundColor Gray
Write-Host "全局主题位置：%APPDATA%\obsidian\themes\" -ForegroundColor Gray
