# Specified Ability 跳转与生命周期实验

此目录是独立的 HarmonyOS 工程。原 Homework 工程及之前作业的未提交修改保持不变。

## 打开与运行

在 DevEco Studio 中打开本目录，等待依赖同步完成，选择 HarmonyOS 6.0.2 API 22 模拟器并运行 entry。入口为 EntryAbility，目标为 launchType="specified" 的 SpecifiedAbility。真机安装需配置自己的调试签名。

本机已经使用 DevEco 自带 SDK 构建，并通过 HDC 安装到 nova 16 Pro 模拟器完成真实交互验证。DevEco 的 Build Hap(s) 也已成功，退出码为 0，截图在 `screenshots/11-deveco-build.png`。构建记录在 `evidence/build.log`。报告位于上一级目录的 `作业_3_报告.docx`，模拟器使用的未签名安装包位于 `dist/作业3-Specified-unsigned.hap`。

## 实验步骤与已验证结果

1. 打开 A，得到 S1，接收 Want 次数为 1，保留计数为 0。
2. 将保留计数增加两次，再次打开 A：仍为 S1，接收次数为 2，计数仍为 2，出现 onNewWant。
3. 切换到 B：新建 S2，接收次数为 1，计数为 0。
4. 将 B 的计数增加到 1，再返回 A：S1 接收次数为 3，计数仍为 2。
5. 回到入口再打开 A：仍复用 S1。
6. 结束 A，再从入口打开 A：创建 S3，接收次数和计数重新初始化；原 B 仍是 S2，计数为 1。

实例编号是进程内演示标记；保留计数仅验证存活实例的内存状态，不提供跨进程持久化。当前台实例再次启动时，实际观察到 onNewWant；从后台恢复时另有 onForeground。

## 代码与证据

- `entry/src/main/module.json5`：注册 Ability，设置启动模式。
- `entry/src/main/ets/myabilitystage/MyAbilityStage.ets`：根据 instanceKey 返回稳定的实例匹配标识。
- `entry/src/main/ets/specifiedability/SpecifiedAbility.ets`：每个实例持有 LocalStorage，并记录生命周期。
- `entry/src/main/ets/utils/AbilityLauncher.ets`：封装 startAbility。
- `entry/src/main/ets/pages/LaunchPage.ets`、`SpecifiedPage.ets`：入口及验证页面。
- `screenshots/`：原始模拟器和 DevEco 截图。
- `evidence/AppLifecycle.log`：本轮验证进程的完整生命周期日志，共 131 条。
- `evidence/verification.json`：交互验证结果和断言，状态为 PASS。
- `evidence/02-*.json` 至 `09-*.json`：截图时的实际界面布局，用于核对显示数值。

HiLog 请使用 Info 级别和 AppLifecycle 标签。SDK 读取命令为 `hdc shell hilog -x -T AppLifecycle`。

本机原 F 盘模拟器空间不足，验证时使用 H 盘的任务副本，原实例保留。DevEco 因旧缓存中的 IPC 端点异常，改用独立缓存目录 `H:/DevecoA3Final` 成功打开。自动化启动环境缺少 `OS` 变量曾导致 OHPM 批处理异常，补齐 `OS=Windows_NT` 并重启后，依赖同步及 IDE 内置构建均成功，SDK 原文件保持不变。这些本机设置不属于工程配置。

参考：OpenHarmony 官方文档 [UIAbility 组件启动模式](https://github.com/openharmony/docs/blob/master/zh-cn/application-dev/application-models/uiability-launch-type.md)。
