# 作业四 纵向 Tabs 分类页面

使用 ArkUI 的 Tabs 与 TabContent 复现题图：左侧按顺序显示热门课程、最新课程、HarmonyOS、精彩活动、开发者说、后端开发、前端开发；默认选中精彩活动；右侧居中显示当前分类标题。

在 DevEco Studio 中打开本目录，使用 HarmonyOS 6.0.2 API 22，选择 `entry` 在手机模拟器运行。应用包名为 `com.example.homework.verticaltabs`。

核心实现位于 `entry/src/main/ets/pages/Index.ets`。分类数组配合 ForEach 生成七个 TabContent，选中索引由 onChange 更新。纵向 Scrollable 页签使用 52vp 行高，配合全高侧栏和 TopStart 对齐，从顶部紧凑排列。

已于 2026 年 11 月 2 日在 nova 16 Pro 模拟器验证：默认页面、七个分类点击、重复点击、上下滑动、冷启动恢复，共 12 个检查点。验证同时检查七个标签可见、侧栏约 27%、内容居中及页签顶部对齐。所有检查通过，运行截图和验证数据分别保存在 `screenshots/`、`evidence/`。

页面完成了分类导航、标题展示、点击切换和手势切页，冷启动默认进入精彩活动。
