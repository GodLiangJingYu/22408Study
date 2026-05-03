# Obsidian 全局插件/主题配置说明

## 当前状态
✅ 插件已全局安装到：`%APPDATA%\obsidian\plugins\`
✅ 主题已全局安装到：`%APPDATA%\obsidian\themes\`

## 全局可用的插件（13 个）
- obsidian-git
- obsidian-excalidraw-plugin
- obsidian-minimal-settings
- templater-obsidian
- obsidian-outliner
- note-refactor-obsidian
- buttons
- virtual-linker
- editing-toolbar
- obsidian-markmind
- pdf-plus
- copilot
- smart-connections

## 全局可用的主题（10 个）
- AnuPpuccin
- Atom
- Blue Topaz
- Discordian
- Dracula for Obsidian
- Minimal
- Obsidian Nord
- **Obsidianite** (当前使用)
- Things
- Wasp

---

## 如何在新仓库中使用全局配置

### 方法 1：创建轻量级 .obsidian 配置（推荐）

在新仓库中只需创建 `.obsidian` 文件夹，并只保留**仓库特定**的配置文件：

```
新仓库/
└── .obsidian/
    ├── appearance.json      ← 只保留主题选择，不存储主题文件
    ├── community-plugins.json ← 启用哪些全局插件
    └── core-plugins.json    ← 核心插件配置
```

**关键点**：
- 不要创建 `plugins/` 文件夹 → 自动使用全局插件
- 不要创建 `themes/` 文件夹 → 自动使用全局主题
- 每个仓库的 `appearance.json` 可以独立选择不同主题

### 方法 2：复制当前配置模板

在新仓库中执行：
```powershell
# 创建 .obsidian 文件夹
New-Item -ItemType Directory -Path ".obsidian" -Force

# 复制配置文件（不包含 plugins/themes 文件夹）
Copy-Item "D:\22408Study\数学\.obsidian\appearance.json" -Destination ".obsidian\"
Copy-Item "D:\22408Study\数学\.obsidian\community-plugins.json" -Destination ".obsidian\"
Copy-Item "D:\22408Study\数学\.obsidian\core-plugins.json" -Destination ".obsidian\"

# 删除本地 plugins 和 themes 文件夹（如果存在）
Remove-Item ".obsidian\plugins" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item ".obsidian\themes" -Recurse -Force -ErrorAction SilentlyContinue
```

---

## 主题自定义隔离

每个仓库的主题修改（如 CSS 片段）存储在各自的 `.obsidian/snippets/` 文件夹中，互不影响：

```
仓库 A/.obsidian/snippets/  ← 仓库 A 的自定义 CSS
仓库 B/.obsidian/snippets/  ← 仓库 B 的自定义 CSS
```

---

## 验证配置

1. 打开新仓库
2. 进入 设置 → 第三方插件
3. 应该能看到所有全局插件已可用
4. 进入 设置 → 外观 → 主题
5. 应该能看到所有全局主题已可用

---

## 添加新插件/主题

只需在任意仓库中通过 Obsidian 界面安装：
- 新插件 → 自动保存到全局 `%APPDATA%\obsidian\plugins\`
- 新主题 → 自动保存到全局 `%APPDATA%\obsidian\themes\`
- 所有仓库立即可用
