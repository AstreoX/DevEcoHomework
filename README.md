# HarmonyOS 课程作业

每次作业保存在独立目录，报告位于仓库根目录。

| 作业 | 内容 | 工程 | 报告 |
| --- | --- | --- | --- |
| 作业一 | ArkTS 智能设备管理系统 | [homework_1](homework_1/) | [Markdown 报告](作业_1_报告.md) |
| 作业二 | 智能家居控制界面 | [homework_2](homework_2/) | [Markdown 报告](作业_2_报告.md) |
| 作业三 | Specified Ability 跳转与生命周期 | [homework_3](homework_3/) | [Markdown 报告](作业_3_报告.md) · [Word 报告](作业_3_报告.docx) · [完整长图](作业_3_报告_长图.png) |

## 作业三

使用 DevEco Studio 6.0.2.640 和 HarmonyOS 6.0.2 API 22。在 DevEco 中打开 `homework_3`，同步依赖后运行 `entry`。

入口通过 `instanceKey` 启动 `SpecifiedAbility`。`MyAbilityStage.onAcceptWant()` 返回稳定的匹配标识，用 A、B 两组参数验证实例新建、复用、状态保留及销毁后重建。

- DevEco 内置 Build Hap(s) 构建通过。
- nova 16 Pro 模拟器真实交互验证通过，六项断言全部通过。
- [11 张真实截图](homework_3/screenshots/)包括 9 张运行截图及 DevEco 源码、构建成功截图。
- [完整生命周期日志](homework_3/evidence/AppLifecycle.log)与[验证结果](homework_3/evidence/verification.json)随工程保存。
- [未签名 HAP](homework_3/dist/作业3-Specified-unsigned.hap)用于本次模拟器验证；真机安装需配置自己的调试签名。

详细步骤见[工程说明](homework_3/README.md)。Markdown 报告使用相对路径引用截图，克隆整个仓库即可查看。
